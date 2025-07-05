{ config, lib, pkgs, ... }:

{
  # 开发环境核心模块
  imports = [
    ./version-control
    ./languages
    ./embedded
  ];
}
