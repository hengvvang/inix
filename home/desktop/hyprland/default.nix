{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./homeDir
    # ./nixMod  # Home Manager 原生模块（暂未实现）
  ];
}
