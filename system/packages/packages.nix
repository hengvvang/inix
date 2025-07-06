{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.packages.enable {
    environment.systemPackages = with pkgs; [
      wget
      vim
      git
      htop
      yazi
      fish
      nushell
      rustup
      vscode
      zed-editor
      google-chrome
      clash-verge-rev
      telegram-desktop
      discord
      spotify
      obs-studio
      wpsoffice-cn
      qq
      wechat-uos
      ghostty
      steam
    ];
  };
}
