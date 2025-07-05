{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.user.enable = lib.mkEnableOption "用户工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.user.enable {
    # 设置用户工具的默认值
    myHome.toolkits.user = {
      utilities.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./utilities.nix
  ];
}