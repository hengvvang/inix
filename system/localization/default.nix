{ config, lib, pkgs, ... }:

{
  # 选项定义移至各子模块
  imports = [
    ./timeZone
    ./inputMethod
  ];
}