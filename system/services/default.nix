{ config, lib, pkgs, ... }:

{
  imports = [
    # 模块化服务目录
    ./docker
    ./network
    ./media
    ./sync
    ./hardware
    ./drivers
  ];
}
