{ lib, ... }:

{
  # 模块合并辅助函数集合
  
  # 合并多个 environment.systemPackages 定义
  mergeSystemPackages = packageLists: {
    environment.systemPackages = lib.flatten packageLists;
  };
  
  # 合并多个 boot.kernelModules 定义
  mergeKernelModules = moduleLists: {
    boot.kernelModules = lib.flatten moduleLists;
  };
  
  # 合并多个 services.udev.extraRules 定义
  mergeUdevRules = rulesList: {
    services.udev.extraRules = lib.concatStringsSep "\n" rulesList;
  };
  
  # 合并多个 boot.supportedFilesystems 定义
  mergeFilesystems = filesystemLists: {
    boot.supportedFilesystems = lib.flatten filesystemLists;
  };
  
  # 合并多个 boot.kernel.sysctl 定义
  mergeSysctlSettings = settingsList: {
    boot.kernel.sysctl = lib.mkMerge settingsList;
  };
  
  # 通用条件包安装器
  conditionalPackages = condition: packages: 
    lib.optionals condition packages;
  
  # 创建模块合并模板
  createMergedModule = { config, enable, mergeConfigs }: 
    lib.mkIf enable (lib.mkMerge mergeConfigs);
}
