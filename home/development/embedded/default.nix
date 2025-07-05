{ config, lib, pkgs, ... }:

{
  # 嵌入式开发模块入口
  imports = [
    ./toolchain.nix
  ];
}
