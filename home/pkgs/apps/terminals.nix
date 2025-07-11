{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.terminals.enable {
    home.packages = with pkgs; [
      ghostty         # Ghostty 终端
    ];
  };
}
