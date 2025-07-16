{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "forest") {
    home.packages = with pkgs; [
      # 主要字体 - 自然有机风格
      source-serif-pro     # 温暖的阅读字体
      merriweather         # 自然优雅的衬线
      crimson              # 优雅的阅读字体
      
      # 无衬线字体 - 温暖人文
      open-sans            # 人文主义无衬线
      lato                 # 温暖现代风格
      source-sans-pro      # 友好易读
      ubuntu_font_family   # Ubuntu 温暖字体
      
      # 完整 Nerd Font 支持 - 森林温和风格
      (nerdfonts.override { 
        fonts = [ 
          "FiraCode" "JetBrainsMono" "Iosevka" "SourceCodePro" "RobotoMono"
          "Hack" "CascadiaCode" "Ubuntu" "UbuntuMono" "DejaVuSansMono"
          "InconsolataGo" "SpaceMono" "DroidSansMono" "Meslo" "AnonymousPro"
          "LiberationMono" "ProFont" "ProggyClean" "GoMono" "Agave"
        ]; 
      })
      monaspace            # GitHub 现代编程字体
      fira-code            # 连字编程字体
      source-code-pro      # 人文主义等宽字体
      jetbrains-mono       # 现代等宽字体
      
      # 中文字体 - 温暖自然
      lxgw-wenkai         # 霞鹜文楷，温暖中文
      noto-fonts-cjk-sans  # Google 现代中文
      source-han-sans      # Adobe 思源黑体
      source-han-serif     # Adobe 思源宋体
      sarasa-gothic       # 更纱黑体
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      dejavu_fonts
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
      powerline-fonts     # Powerline 字体支持
    ];

    # 字体配置 - 森林自然风格
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ 
          "Source Serif Pro" "Merriweather" "Source Han Serif SC" "LXGW WenKai"
          "Font Awesome 6 Free"
        ];
        sansSerif = [ 
          "Open Sans" "Lato" "Source Han Sans SC" "LXGW WenKai"
          "Font Awesome 6 Free" "Material Design Icons"
        ];
        monospace = [ 
          "Fira Code Nerd Font" "Monaspace Neon Var" "Sarasa Gothic SC"
          "JetBrains Mono Nerd Font" "Source Code Pro Nerd Font"
        ];
        emoji = [ 
          "Noto Color Emoji" "OpenMoji Color" "Twemoji" "Font Awesome 6 Free"
        ];
      };
    };
  };
}
