{ config, lib, pkgs, ... }:

{
  options.myHome.apps.terminals.enable = lib.mkEnableOption "终端配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.apps.terminals.enable {
    # 终端层默认值：ghostty默认开启
    myHome.apps.terminals = {
      ghostty.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./ghostty.nix
  ];
}