{ config, lib, pkgs, ... }:

{
  imports = [
    ./clash
  ];

  # 代理配置模块的选项定义
  options.myHome.dotfiles.proxy = {
    enable = lib.mkEnableOption "代理配置支持";
  };
}
