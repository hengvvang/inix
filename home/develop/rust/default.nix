{ config, lib, pkgs, ... }:

{
  options.myHome.develop.rust = {
    enable = lib.mkEnableOption "Rust 开发环境";
    embedded.enable = lib.mkEnableOption "Rust 嵌入式开发环境";
  };

  imports = [
    ./rust.nix
  ];
}
