{ config, lib, pkgs, ... }:

{
  imports = [
    ./yazi-config.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.yazi.packageEnable (with pkgs; [
      yazi
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
    ]);
  };
}
