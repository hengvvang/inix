{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "bauhaus") {
    home.packages = with pkgs; [
      # 主要字体 - 包豪斯几何风格
      source-sans-pro      # Adobe 现代几何设计
      inter                # 现代几何无衬线字体
      roboto               # Google 几何设计
      ubuntu_font_family   # Ubuntu 几何风格
      
      # 完整 Nerd Font 支持 - 几何简洁风格
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "Iosevka" "IBMPlexMono" "Ubuntu" "RobotoMono"
          "SourceCodePro" "Hack" "FiraCode" "CascadiaCode" "SpaceMono"
          "InconsolataGo" "DroidSansMono" "DejaVuSansMono" "LiberationMono"
          "UbuntuMono" "Meslo" "AnonymousPro" "ProFont" "ProggyClean"
        ]; 
      })
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
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
    ];

    # 字体配置 - 优化几何美学
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Roboto" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Iosevka Nerd Font" 
          "IBM Plex Mono Nerd Font" 
          "Ubuntu Mono Nerd Font"
          "Monaspace Neon" 
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
