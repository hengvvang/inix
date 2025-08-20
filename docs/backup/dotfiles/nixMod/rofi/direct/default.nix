{ config, lib, pkgs, ... }:

{
  imports = [
    ./config.rasi.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "direct") {

    home.packages = lib.optionals config.myHome.dotfiles.rofi.packageEnable (with pkgs; [ rofi ]);

    home.file.".local/bin/rofi-launcher".text = ''
    '';

    home.file.".local/bin/rofi-launcher" = {
      executable = true;
    };
  };
}
