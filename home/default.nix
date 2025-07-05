{ config, lib, pkgs, ... }:

{
  # Home Manager 用户级配置入口 - 仅做导入
  imports = [
    ./apps
    ./toolkits
    ./development
    ./profiles
  ];
}
