{ config, lib, pkgs, ... }:

{
  options.myHome.development.languages.enable = lib.mkEnableOption "编程语言支持" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.languages.enable {
    # 直接配置而不设置过深的层次结构
  };

  # 开发环境语言模块入口
  imports = [
    ./rust.nix         # Rust 开发环境
    ./python.nix       # Python 开发环境  
    ./javascript.nix   # JavaScript 开发环境
    ./typescript.nix   #TypeScript 开发环境
    ./c.nix            # C 开发环境
    ./cpp.nix          # C++ 开发环境
  ];
}
