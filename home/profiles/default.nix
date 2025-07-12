{ config, lib, pkgs, ... }:

{
  options.myHome.profiles = {
    enable = lib.mkEnableOption "用户配置档案支持";
  };

  # 配置文件模块 - 仅做导入
  imports = [
    ./fonts
    ./stylix
  ];
}