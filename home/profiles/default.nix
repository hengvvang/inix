{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.enable = lib.mkEnableOption "配置文件模块" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.enable {
    # 配置文件层默认值：环境变量和字体都很重要
    myHome.profiles = {
      envVar.enable = lib.mkDefault true;    # 环境变量 - 默认开启
      fonts.enable = lib.mkDefault true;     # 字体配置 - 默认开启
    };
  };

  imports = [
    ./env-var
    ./fonts
  ];
}