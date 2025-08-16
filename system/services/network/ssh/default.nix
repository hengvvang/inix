{ config, lib, pkgs, ... }:

{
  imports = [
    ./ssh.nix
  ];
  # SSH 服务模块 - 简化版
  options.mySystem.services.network.ssh = {
    enable = lib.mkEnableOption "SSH 服务支持";

    # 服务端配置
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
        description = "是否允许密码认证（建议使用密钥认证）";
      };
    };

    # 客户端工具
    client = {
      enable = lib.mkEnableOption "SSH 客户端工具" // { default = true; };
    };
  };
}
