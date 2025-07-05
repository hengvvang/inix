{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.envVar.enable = lib.mkEnableOption "环境变量配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.envVar.enable {
    # 设置环境变量配置的默认值
    myHome.profiles.envVar = {
      environment.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./environment.nix
  ];
}