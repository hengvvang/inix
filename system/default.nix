{ config, lib, pkgs, ... }:

{
  # 系统模块入口 - 仅做导入，类似 home/default.nix
  imports = [
    ./desktop
    ./locale
    ./services
    ./pkgs
    ./profiles    # ✅ 添加 profiles 模块
  ];

}
