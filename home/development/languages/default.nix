{ config, lib, pkgs, ... }:

{
  options.myHome.development.languages.enable = lib.mkEnableOption "编程语言支持" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.languages.enable {
    # 设置语言模块的默认值
    myHome.development.languages = {
      c.enable = lib.mkDefault false;
      cpp.enable = lib.mkDefault false;
      javascript.enable = lib.mkDefault true;
      python.enable = lib.mkDefault true;
      rust.enable = lib.mkDefault false;
      typescript.enable = lib.mkDefault false;
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
