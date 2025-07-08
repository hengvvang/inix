{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.profiles.fonts.fonts.enable {
    # 字体配置
    fonts.fontconfig.enable = true;
    
    home.packages = with pkgs; [
      # 基础字体
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      
      # 编程字体
      jetbrains-mono
      fira-code
      fira-code-symbols
      cascadia-code
      
      # Nerd Fonts - 编程字体with图标
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.meslo-lg
      nerd-fonts.ubuntu-mono
      nerd-fonts.cascadia-code
      
      # 系统字体
      liberation_ttf
      source-han-sans
      source-han-serif
      
      # 特殊字体
      font-awesome
      material-icons
      
      # 终端优化字体
      terminus_font
      inconsolata
      
      # 现代字体
      inter
      roboto
      roboto-mono
      ubuntu_font_family
    ];
    
    # 字体配置文件
    home.file.".config/fontconfig/fonts.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <!-- 默认字体配置 -->
        <alias>
          <family>serif</family>
          <prefer>
            <family>Noto Serif</family>
            <family>Source Han Serif</family>
          </prefer>
        </alias>
        
        <alias>
          <family>sans-serif</family>
          <prefer>
            <family>Inter</family>
            <family>Noto Sans</family>
            <family>Source Han Sans</family>
          </prefer>
        </alias>
        
        <alias>
          <family>monospace</family>
          <prefer>
            <family>JetBrainsMono Nerd Font</family>
            <family>Fira Code</family>
            <family>Cascadia Code</family>
          </prefer>
        </alias>
        
        <!-- 终端字体优化 -->
        <match target="pattern">
          <test name="family" qual="any">
            <string>monospace</string>
          </test>
          <edit mode="prepend" name="family" binding="strong">
            <string>JetBrainsMono Nerd Font</string>
          </edit>
        </match>
        
        <!-- 字体渲染优化 -->
        <match target="font">
          <edit mode="assign" name="antialias">
            <bool>true</bool>
          </edit>
          <edit mode="assign" name="hinting">
            <bool>true</bool>
          </edit>
          <edit mode="assign" name="hintstyle">
            <const>hintslight</const>
          </edit>
          <edit mode="assign" name="lcdfilter">
            <const>lcddefault</const>
          </edit>
          <edit mode="assign" name="rgba">
            <const>rgb</const>
          </edit>
        </match>
        
        <!-- 禁用位图字体 -->
        <selectfont>
          <rejectfont>
            <pattern>
              <patelt name="scalable"><bool>false</bool></patelt>
            </pattern>
          </rejectfont>
        </selectfont>
      </fontconfig>
    '';
  };
}