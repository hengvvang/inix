{ config, lib, pkgs, ... }:

{
  options = {
    myHome.profiles.fonts.fonts.enable = lib.mkEnableOption "字体配置";
  };

  config = lib.mkIf config.myHome.profiles.fonts.fonts.enable {
    # 字体配置
    fonts.fontconfig.enable = true;
    
    home.packages = with pkgs; [
      # 基础字体
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}