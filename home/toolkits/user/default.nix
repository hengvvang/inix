{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.user.enable = lib.mkEnableOption "用户工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.user.enable {
    # 用户工具层默认值：实用工具默认开启
    myHome.toolkits.user = {
      utilities.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./utilities.nix
  ];
}