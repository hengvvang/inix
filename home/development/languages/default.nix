{ config, lib, pkgs, ... }:

{
  options.myHome.development.languages.enable = lib.mkEnableOption "编程语言支持" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.languages.enable {
    # 语言层默认值：常用语言默认开启
    myHome.development.languages = {
      rust.enable = lib.mkDefault true;        # Rust - 现代系统语言
      python.enable = lib.mkDefault true;      # Python - 通用脚本语言
      javascript.enable = lib.mkDefault true;  # JavaScript - Web开发必需
      typescript.enable = lib.mkDefault true;  # TypeScript - 类型安全的JS
      c.enable = lib.mkDefault false;          # C - 按需开启
      cpp.enable = lib.mkDefault false;        # C++ - 按需开启
    };
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
