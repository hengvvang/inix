{ config, lib, pkgs, ... }:

{
  options.myHome.development.languages = {
    enable = lib.mkEnableOption "编程语言开发环境支持";
    c.enable = lib.mkEnableOption "C 开发环境";
    cpp.enable = lib.mkEnableOption "C++ 开发环境";
    javascript.enable = lib.mkEnableOption "JavaScript 开发环境";
    python.enable = lib.mkEnableOption "Python 开发环境";
    rust.enable = lib.mkEnableOption "Rust 开发环境";
    typescript.enable = lib.mkEnableOption "TypeScript 开发环境";
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
