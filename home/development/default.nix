{ config, lib, pkgs, ... }:

{
  # 开发环境核心模块 - 仅做导入
  imports = [
    ./versionControl
    ./languages
    ./embedded
  ];
}
