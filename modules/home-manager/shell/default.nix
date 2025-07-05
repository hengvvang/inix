{ config, lib, pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./zsh.nix
    # starship.nix - 已在 modern-tools.nix 中配置
  ];
}
