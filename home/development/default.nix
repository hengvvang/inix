{ config, lib, pkgs, ... }:

{
  options.myHome.development = {
    enable = lib.mkEnableOption "开发环境支持";
  };

  # 开发环境核心模块 - 仅做导入
  imports = [
    ./languages
    ./embedded
  ];
}
