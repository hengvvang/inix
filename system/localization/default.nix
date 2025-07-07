{ config, lib, pkgs, ... }:

{
  options.mySystem.localization = {
    enable = lib.mkEnableOption "本地化配置支持";
  };

  # 选项已经在各子模块中定义，这里只做导入
  imports = [
    ./timeZone
    ./inputMethod
  ];
}