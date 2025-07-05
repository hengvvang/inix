{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.enable = lib.mkEnableOption "Shell 配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.apps.shells.enable {
    # 直接配置而不设置过深的层次结构
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
