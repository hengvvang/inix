{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells = {
    fish = lib.mkEnableOption "Fish Shell 配置";
    zsh = lib.mkEnableOption "Zsh Shell 配置";
    nushell = lib.mkEnableOption "Nushell 配置";
    aliases = lib.mkEnableOption "通用 Shell 别名";
    # prompts 选项由 ./prompts 目录定义
  };

  # Shell 环境配置 - fish, zsh, nushell + 终端
  imports = [
    ./fish.nix         # Fish Shell 配置
    ./zsh.nix          # Zsh Shell 配置  
    ./nushell.nix      # Nushell 配置
    ./aliases.nix      # 通用 Shell 别名
    ./prompts          # 提示符配置 (Starship 等)
  ];
}
