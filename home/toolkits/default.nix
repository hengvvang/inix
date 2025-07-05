{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.enable = lib.mkEnableOption "工具包模块" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.enable {
    
  };

  # 工具模块入口
  imports = [
    ./system
    ./user
  ];
}
