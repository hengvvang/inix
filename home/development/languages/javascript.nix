{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.development.languages.javascript {
    # JavaScript 开发环境 - 简化版
    home.packages = with pkgs; [
      nodejs                # Node.js 运行时 (包含 npm)
      yarn                  # Yarn 包管理器
    ];
  };
}
