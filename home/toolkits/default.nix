{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits = {
    enable = lib.mkEnableOption "工具包支持";
  };

  # 工具包模块 - 仅做导入
  imports = [
    ./system
    ./user
  ];
}
