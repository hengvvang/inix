{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.enable = lib.mkEnableOption "Shell 配置";

  config = lib.mkIf config.myHome.apps.shells.enable {
    # Shell层默认配置：fish作为主shell，别名和提示符默认开启
    myHome.apps.shells = {
      fish.enable = lib.mkDefault true;        # Fish - 主shell，默认开启
      aliases.enable = lib.mkDefault true;     # 别名 - 提升效率，默认开启
      prompts.enable = lib.mkDefault true;     # 提示符 - 美化终端，默认开启
      zsh.enable = lib.mkDefault false;        # Zsh - 可选
      nushell.enable = lib.mkDefault false;    # Nushell - 可选
    };
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
