{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "cyberPunk") {
    fonts.packages = with pkgs; [
      # 完整 Nerd Font 支持 - 赛博朋克科技感
      (nerd-fonts.override { 
        fonts = [ 
          "FiraCode" "CascadiaCode" "VictorMono" "Hack" "JetBrainsMono"
          "Iosevka" "SourceCodePro" "RobotoMono" "SpaceMono" "InconsolataGo"
          "DroidSansMono" "DejaVuSansMono" "UbuntuMono" "Meslo" "AnonymousPro"
          "ProFont" "ProggyClean" "BigBlueTerminal" "Terminus" "GoMono"
        ]; 
      })
      monaspace            # GitHub 现代编程字体族
      fira-code            # 连字编程字体，科技感十足
      jetbrains-mono       # 现代等宽字体
      cascadia-code        # 微软开发的现代编程字体
      victor-mono          # 手写风格编程字体
      
      # 显示字体 - 未来主义风格
      inter                # 现代几何无衬线字体
      source-sans-pro      # Adobe 现代无衬线
      roboto               # Google 材质设计字体
      ubuntu_font_family   # Ubuntu 现代字体族
      
      # 中文字体 - 简洁现代
      lxgw-wenkai         # 霞鹜文楷
      noto-fonts-cjk-sans  # Google 现代中文无衬线
      source-han-sans      # Adobe 思源黑体
      sarasa-gothic       # 更纱黑体，编程友好
      
      # 特色字体 - 赛博朋克元素
      hack-font            # 黑客风格等宽字体
      iosevka             # 现代编程字体
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
      powerline-fonts     # Powerline 字体支持
    ];

    # 字体配置 - 赛博朋克风格优化
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Roboto" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ 
          "Fira Code Nerd Font" 
          "Cascadia Code Nerd Font"
          "Victor Mono Nerd Font"
          "Hack Nerd Font"
          "JetBrains Mono Nerd Font"
          "Monaspace Krypton" 
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
