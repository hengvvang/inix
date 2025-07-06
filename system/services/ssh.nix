{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.ssh.enable {
    # SSH 服务配置
    services.openssh.enable = true;
    services.openssh.settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
}