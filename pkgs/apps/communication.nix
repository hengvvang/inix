{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.communication.enable {
    environment.systemPackages = with pkgs; [
      telegram-desktop # Telegram
      discord         # Discord
      qq              # QQ
      wechat-uos      # 微信
    ];
  };
}
