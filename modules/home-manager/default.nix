{ config, lib, pkgs, ... }:

{
  # Home Manager 用户级配置入口
  imports = [
    ./apps
    ./development
    ./editors
    ./user-env
    ./shells
    ./profiles
    ./toolkits
  ];
}
