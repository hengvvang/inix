{ config, lib, pkgs, ... }:

{
  # SSH 服务模块的完整选项定义
  options.mySystem.services.network.ssh = {
    enable = lib.mkEnableOption "SSH 服务基础支持";
    
    # === 服务端选项 ===
    server = {
      enable = lib.mkEnableOption "SSH 服务端" // { default = true; };
      port = lib.mkOption {
        type = lib.types.int;
        default = 22;
        description = "SSH 服务端口";
      };
      passwordAuth = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "是否允许密码认证";
      };
    };
    
    # === 客户端选项 ===
    client = {
      enable = lib.mkEnableOption "SSH 客户端工具" // { default = true; };
      mosh = lib.mkEnableOption "Mosh 移动Shell支持";
    };
    
    # === 安全选项 ===
    security = {
      hardening = lib.mkEnableOption "SSH 安全加固" // { default = true; };
      fail2ban = lib.mkEnableOption "Fail2Ban 暴力破解防护";
    };
    
    # === 高级功能选项 ===
    features = {
      tunneling = lib.mkEnableOption "SSH 隧道功能";
      x11Forwarding = lib.mkEnableOption "X11 转发功能";
      agent = lib.mkEnableOption "SSH 代理功能" // { default = true; };
    };
    
    # === 监控选项 ===
    monitoring = {
      enable = lib.mkEnableOption "SSH 连接监控";
      verboseLogging = lib.mkEnableOption "详细日志记录";
    };
  };

  imports = [
    ./server.nix        # SSH 服务端
    ./client.nix        # SSH 客户端
    ./security.nix      # 安全功能
    ./features.nix      # 高级功能
    ./monitoring.nix    # 监控功能
  ];
}
