{ config, lib, pkgs, ... }:

{
  # Home Manager 用户级配置入口
  imports = [
    ./apps
    ./toolkits
    ./development
    ./profiles
  ];
}
