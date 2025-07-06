{ config, lib, pkgs, ... }:

{
  options.mySystem.services.network.ssh = {
    enable = lib.mkEnableOption "SSH 远程访问服务";
    passwordAuth = lib.mkEnableOption "SSH 密码认证";
  };

  imports = [
    ./core.nix
  ];
}
