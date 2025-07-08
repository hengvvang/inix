{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.proxy.clash = {
    enable = lib.mkEnableOption "Clash 代理配置";
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
