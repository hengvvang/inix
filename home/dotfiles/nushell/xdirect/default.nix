{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "xdirect") {
    home.packages = with pkgs; [ nushell ];

    programs.nushell = {
      enable = true;
      
      configFile.text = builtins.readFile ./configs/config.nu;
      envFile.text = builtins.readFile ./configs/env.nu;
    };
  };
}
