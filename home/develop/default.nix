{ config, lib, pkgs, ... }:

{
  options.myHome.develop = {
    enable = lib.mkEnableOption "开发环境支持";
    
    # Rust 开发环境
    rust = {
      enable = lib.mkEnableOption "Rust 开发环境";
      embedded.enable = lib.mkEnableOption "Rust 嵌入式开发环境";
    };
    
    # Python 开发环境
    python = {
      enable = lib.mkEnableOption "Python 开发环境";
    };
    
    # JavaScript 开发环境
    javascript = {
      enable = lib.mkEnableOption "JavaScript 开发环境";
    };
    
    # TypeScript 开发环境
    typescript = {
      enable = lib.mkEnableOption "TypeScript 开发环境";
    };
    
    # C/C++ 开发环境
    cpp = {
      enable = lib.mkEnableOption "C/C++ 开发环境";
      embedded.enable = lib.mkEnableOption "C/C++ 嵌入式开发环境";
    };
  };

  # 开发环境核心模块 - 按语言导入实现
  imports = [
    ./rust       # Rust 开发环境
    ./python     # Python 开发环境  
    ./javascript # JavaScript 开发环境
    ./typescript # TypeScript 开发环境
    ./cpp        # C/C++ 开发环境
  ];
}
