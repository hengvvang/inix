{ config, lib, pkgs, ... }:

{
  options.myHome.development.languages = {
    c = lib.mkEnableOption "C 开发环境";
    cpp = lib.mkEnableOption "C++ 开发环境";
    javascript = lib.mkEnableOption "JavaScript 开发环境";
    python = lib.mkEnableOption "Python 开发环境";
    rust = lib.mkEnableOption "Rust 开发环境";
    typescript = lib.mkEnableOption "TypeScript 开发环境";
  };

  # 开发环境语言模块入口
  imports = [
    ./rust.nix         # Rust 开发环境
    ./python.nix       # Python 开发环境  
    ./javascript.nix   # JavaScript 开发环境
    ./typescript.nix   # TypeScript 开发环境
    ./c.nix            # C 开发环境
    ./cpp.nix          # C++ 开发环境
  ];
}
