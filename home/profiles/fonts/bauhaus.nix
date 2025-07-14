{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "bauhaus") {
    home.packages = with pkgs; [
      # 主要字体 - 包豪斯几何风格
      source-sans-pro      # Adobe 现代几何设计
      inter                # 现代几何无衬线字体
      roboto               # Google 几何设计
      ubuntu_font_family   # Ubuntu 几何风格
      
      # 编程字体 - 几何简洁
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" "IBMPlexMono" ]; })
      monaspace            # GitHub 现代编程字体
      jetbrains-mono       # 现代几何等宽字体
      iosevka             # 现代几何编程字体
      ibm-plex            # IBM 几何字体族
      
      # 显示字体 - 构成主义风格
      source-serif-pro     # 现代衬线字体
      
      # 中文字体 - 几何现代
      lxgw-wenkai         # 霞鹜文楷，现代设计
      noto-fonts-cjk-sans  # Google 几何中文
      source-han-sans      # Adobe 思源黑体
      sarasa-gothic       # 更纱黑体，几何风格
      
      # 系统字体
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Roboto" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ "IBM Plex Mono Nerd Font" "Monaspace Neon" "Iosevka" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
