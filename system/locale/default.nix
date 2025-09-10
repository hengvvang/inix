{ config, lib, pkgs, ... }:

{
  imports = [
    ./timeZone.nix
    ./inputMethod.nix
  ];

  options.mySystem.locale = {
    enable = lib.mkEnableOption "本地化配置支持";
    # 时区配置选项
    timeZone = {
      enable = lib.mkEnableOption "时区配置支持";
      preset = lib.mkOption {
        type = lib.types.enum [ "shanghai" "newYork" "losAngeles" "london" "tokyo" ];
        default = "shanghai";
        description = ''
          时区预设配置:
          - shanghai: 上海时区 (Asia/Shanghai) - 中国标准时间
          - newYork: 纽约时区 (America/New_York) - 美国东部时间
          - losAngeles: 洛杉矶时区 (America/Los_Angeles) - 美国西部时间
          - london: 伦敦时区 (Europe/London) - 格林威治标准时间
          - tokyo: 东京时区 (Asia/Tokyo) - 日本标准时间
        '';
      };
    };
    # 输入法配置选项
    inputMethod = {
      enable = lib.mkEnableOption "输入法配置支持";
      fcitx5.enable = lib.mkEnableOption "Fcitx5 输入法框架";
      ibus.enable = lib.mkEnableOption "IBus 输入法框架";
    };
  };
}
