{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "tokyo") {
    home.packages = with pkgs; [
      # 主要字体 - 日式简约现代
      noto-fonts-cjk-sans  # Google 现代中日韩字体
      
      # 编程字体 - 现代简洁
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "FiraCode" "Iosevka" "CascadiaCode" "SourceCodePro"
          "RobotoMono" "Hack" "Ubuntu" "UbuntuMono" "DejaVuSansMono"
          "InconsolataGo" "SpaceMono" "DroidSansMono" "Meslo" "AnonymousPro"
          "LiberationMono" "ProFont" "ProggyClean" "GoMono" "Agave"
          "VictorMono" "BigBlueTerminal" "Terminus"
        ]; 
      })
      monaspace            # GitHub 现代编程字体
      source-code-pro      # 简洁专业
      jetbrains-mono       # 现代等宽字体
      fira-code           # Mozilla 连字编程字体
      cascadia-code       # Microsoft 现代编程字体
      
      # 西文字体 - 简约现代
      inter                # 现代几何设计
      source-sans-pro      # Adobe 系统字体风格
      roboto              # Google 材质设计字体
      ubuntu_font_family   # Ubuntu 现代字体
      
      # 中文字体 - 东亚现代美学
      lxgw-wenkai         # 霞鹜文楷，优雅中文
      source-han-sans      # Adobe 思源黑体
      source-han-serif     # Adobe 思源宋体
      noto-fonts-cjk-serif # Google 传统中文
      sarasa-gothic       # 更纱黑体
      
      # 日文特色字体
      klee-one            # 日式手写风格
      zen-old-mincho      # 禅古明朝体
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Han Serif SC" "Noto Serif CJK SC" "LXGW WenKai" ];
        sansSerif = [ "Inter" "Source Han Sans SC" "Noto Sans CJK SC" "Roboto" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Fira Code Nerd Font"
          "Cascadia Code Nerd Font"
          "Source Code Pro Nerd Font"
          "Monaspace Neon" 
          "Sarasa Gothic SC" 
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
