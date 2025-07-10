{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "cyberPunk") {
    home.packages = with pkgs; [
      # 主要编程字体 - 赛博朋克科技感
      fira-code            # 连字编程字体，科技感十足
      jetbrains-mono       # 现代等宽字体
      cascadia-code        # 微软开发的现代编程字体
      
      # 显示字体 - 未来主义风格
      inter                # 现代几何无衬线字体
      source-sans-pro      # Adobe 现代无衬线
      
      # 中文字体 - 简洁现代
      noto-fonts-cjk-sans  # Google 现代中文无衬线
      source-han-sans      # Adobe 思源黑体
      
      # 特色字体 - 赛博朋克元素
      hack-font            # 黑客风格等宽字体
      
      # 系统字体
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Source Sans Pro" "Source Han Sans SC" ];
        monospace = [ "Fira Code" "JetBrains Mono" "Source Han Sans SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
