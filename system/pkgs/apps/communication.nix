{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.communication.enable {
    environment.systemPackages = with pkgs; [
      telegram-desktop # Telegram
      discord         # Discord
      qq              # QQ
      wechat-uos      # 微信
    ];
  };
}
