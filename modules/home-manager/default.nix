{ config, lib, pkgs, ... }:

{
  # Home Manager 用户级配置入口
  imports = [
    ./apps
    ./development
    ./editors
    ./shells
    ./profiles
    ./toolkits
  ];
}
