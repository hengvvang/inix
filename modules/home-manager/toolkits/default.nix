{ config, lib, pkgs, ... }:

{
  # 工具模块入口
  imports = [
    ./system/linux-admin.nix
    ./user/replacements.nix
  ];
}
