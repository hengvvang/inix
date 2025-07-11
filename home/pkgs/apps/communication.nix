{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.communication.enable {
    home.packages = with pkgs; [
      telegram-desktop # Telegram
      discord         # Discord
      qq              # QQ
      wechat-uos      # 微信
    ];
  };
}
