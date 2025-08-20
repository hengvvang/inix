{ config, lib, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./tilde    # 引用重构后的 tilde 配置系统
    # ./nixMod  # Home Manager 原生模块（暂未实现）
  ];
}
