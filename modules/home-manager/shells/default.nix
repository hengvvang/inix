{ config, lib, pkgs, ... }:

{
  # Shell 环境配置 - fish, zsh, nushell + 终端
  imports = [
    ./fish.nix         # Fish Shell 配置
    ./zsh.nix          # Zsh Shell 配置  
    ./nushell.nix      # Nushell 配置
    ./terminals.nix    # 终端配置 (Alacritty, Ghostty)
    ./aliases.nix      # 通用 Shell 别名
    ./prompts          # 提示符配置 (Starship 等)
  ];
}
