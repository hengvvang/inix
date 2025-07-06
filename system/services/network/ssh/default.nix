{ config, lib, pkgs, ... }:

{
  # SSH 服务模块的完整选项定义
  options.mySystem.services.network.ssh = {
    enable = lib.mkEnableOption "SSH 服务基础支持";
    
    # === 认证选项 ===
    auth = {
      passwordAuth = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "是否允许密码认证";
      };
      
      keyAuth = lib.mkEnableOption "密钥认证增强" // { default = true; };
      
      mfa = lib.mkEnableOption "多因素认证支持";
    };
    
    # === 安全选项 ===
    security = {
      hardening = lib.mkEnableOption "SSH 安全加固" // { default = true; };
      
      failBan = lib.mkEnableOption "Fail2Ban 暴力破解防护";
      
      portKnocking = lib.mkEnableOption "端口敲门保护";
    };
    
    # === 高级功能选项 ===
    advanced = {
      tunneling = lib.mkEnableOption "SSH 隧道功能";
      
      portForwarding = lib.mkEnableOption "端口转发功能";
      
      x11Forwarding = lib.mkEnableOption "X11 转发功能";
      
      agent = lib.mkEnableOption "SSH 代理功能";
    };
    
    # === 监控选项 ===
    monitoring = {
      logging = lib.mkEnableOption "详细日志记录" // { default = true; };
      
      metrics = lib.mkEnableOption "性能指标收集";
    };
  };

  imports = [
    ./core.nix          # 基础 SSH 服务
    ./auth.nix          # 认证功能
    ./security.nix      # 安全加固
    ./advanced.nix      # 高级功能
    ./monitoring.nix    # 监控功能
  ];
}
