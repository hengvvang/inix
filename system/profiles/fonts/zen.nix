{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "zen") {
    fonts.packages = with pkgs; [

      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.roboto-mono
      nerd-fonts.hack
      nerd-fonts.caskaydia-mono
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.inconsolata-go
      nerd-fonts.space-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.meslo-lg
      nerd-fonts.anonymice
      nerd-fonts.liberation
      nerd-fonts.profont
      nerd-fonts.proggy-clean-tt
      nerd-fonts.go-mono
      nerd-fonts.agave
      nerd-fonts.monaspace

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      source-han-mono

      monaspace
      lxgw-wenkai

      inter
      source-sans-pro
      source-serif-pro
      noto-fonts
      inconsolata
      ubuntu_font_family
      iosevka
      jetbrains-mono

      # 系统字体和图标支持
      liberation_ttf
      dejavu_fonts
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
      powerline-fonts     # Powerline 字体支持
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Source Han Sans SC" "LXGW WenKai" ];
        serif = [ "Source Serif Pro" "Source Han Serif SC" "LXGW WenKai" ];
        monospace = [
          "Iosevka Nerd Font"
          "JetBrains Mono Nerd Font"
          "Inconsolata Go Nerd Font"
          "Source Code Pro Nerd Font"
          "Monaspace Xenon"
          "LXGW WenKai Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
