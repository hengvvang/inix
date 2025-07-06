{ config, lib, pkgs, ... }:

{
  # 配置文件模块 - 仅做导入
  imports = [
    ./fonts
  ];
}