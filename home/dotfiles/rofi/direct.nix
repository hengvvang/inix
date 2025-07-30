{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "direct") {
    
    home.packages = with pkgs; [ rofi ];

    # 直接配置文件写入方式 - 简单象征性配置
    home.file.".config/rofi/config.rasi".text = ''
    '';

    home.file.".local/bin/rofi-launcher".text = ''
    '';

    home.file.".local/bin/rofi-launcher" = {
      executable = true;
    };
  };
}
