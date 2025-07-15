# 🌑 新月 - 系统核心基础
# 系统运行绝对必需的最基本工具，没有这些系统无法正常使用
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.newMoon.enable {
    environment.systemPackages = with pkgs; [
      # 最基础的文本编辑器（系统管理必需）
      vim               # 系统默认编辑器
      nano              # 简单易用的编辑器
      
      # 基础文件操作（系统维护必需）
      gnutar            # 归档工具
      
      # 版本控制（配置管理必需）
      git               # 版本控制系统
      
      # 系统监控（故障排除必需）
      procps            # 进程状态工具 (包含 ps 命令)
    ];
  };
}
