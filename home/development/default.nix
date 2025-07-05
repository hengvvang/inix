{ config, lib, pkgs, ... }:

{
  options.myHome.development.enable = lib.mkEnableOption "开发环境模块" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.enable {
    
  };

  # 开发环境核心模块
  imports = [
    ./version-control
    ./languages
    ./embedded
  ];
}
