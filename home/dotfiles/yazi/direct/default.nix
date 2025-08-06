{ config, lib, pkgs, ... }:

{
  imports = [
    ./yazi-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "direct") {
    home.packages = with pkgs; [
      yazi
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
    ];

    home.file.".config/yazi/yazi.toml".text = ''
      [manager]
      show_hidden = false
    '';
    
    home.file.".config/yazi/keymap.toml".text = ''
      # Yazi keymap config
    '';
  };
}