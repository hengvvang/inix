{ config, lib, pkgs, ... }:

{
  # 工具模块入口
  imports = [
    ./system
    ./user
  ];
}
