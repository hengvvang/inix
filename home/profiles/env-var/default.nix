{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.envVar.enable = lib.mkEnableOption "环境变量配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.envVar.enable {
    # 环境变量层默认值：环境变量文件默认开启
    myHome.profiles.envVar = {
      environment.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./environment.nix
  ];
}