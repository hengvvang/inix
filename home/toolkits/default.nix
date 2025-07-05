{ config, lib, pkgs, ... }:

{
  # 工具包模块 - 仅做导入
  imports = [
    ./system
    ./user
  ];
}
