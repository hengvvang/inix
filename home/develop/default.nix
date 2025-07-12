{ config, lib, pkgs, ... }:

{
  options.myHome.develop = {
    enable = lib.mkEnableOption "开发环境支持";
  };

  # 开发环境核心模块 - 按语言导入实现
  imports = [
    ./rust       # Rust 开发环境
    ./python     # Python 开发环境  
    ./javascript # JavaScript 开发环境
    ./typescript # TypeScript 开发环境
    ./cpp        # C/C++ 开发环境
    ./devenv     # devenv 开发环境管理
  ];
}
