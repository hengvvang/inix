{ config, lib, pkgs, ... }:

{
  # 开发环境语言模块入口 - 简化版
  imports = [
    ./rust.nix         # Rust 开发环境
    ./python.nix       # Python 开发环境  
    ./javascript.nix   # JavaScript/TypeScript 开发环境
    ./typescript.nix   #TypeScript 开发环境
    ./c.nix            # C 开发环境
    ./cpp.nix          # C++ 开发环境
  ];
}
