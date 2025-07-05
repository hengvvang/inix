{ config, lib, pkgs, ... }:

{
  # 应用程序模块 - 仅做导入
  imports = [
    ./editors
    ./terminals
    ./shells
    ./yazi
  ];
}