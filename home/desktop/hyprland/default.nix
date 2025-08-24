{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./homeDir    # 引用重构后的 tilde 配置系统
    # ./nixMod  # Home Manager 原生模块（暂未实现）
  ];
}
