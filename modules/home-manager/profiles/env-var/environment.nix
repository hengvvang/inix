{ config, lib, pkgs, ... }:

{
  # 环境变量配置
  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
  };
}