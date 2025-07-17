{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "aurora") {
    # 系统级字体包配置 - 极光风格
    fonts.packages = with pkgs; [
      # 主要字体 - 绚烂多彩风格
      inter                # 现代动感设计
      roboto               # Google 活力设计
      ubuntu_font_family   # Ubuntu 活力风格
      
      # Nerd Font 支持 - 活力风格
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "FiraCode" "Iosevka" "CascadiaCode"
          "RobotoMono" "Ubuntu" "UbuntuMono" "Hack" "SpaceMono"
        ]; 
      })
      
      # 中文字体 - 活力风格
      noto-fonts-cjk-sans
      source-han-sans
      sarasa-gothic       # 活力中文字体
      
      # 基础字体
      noto-fonts
      noto-fonts-emoji
      font-awesome
      material-design-icons
    ];

    # 系统级字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Roboto" "Ubuntu" "Source Han Sans SC" "Sarasa Gothic SC" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Fira Code Nerd Font"
          "Cascadia Code Nerd Font"
          "Iosevka Nerd Font"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
