{ config, lib, pkgs, ... }:

{
  # JavaScript 开发环境 - 简化版
  home.packages = with pkgs; [
    nodejs                # Node.js 运行时
    npm                   # npm 包管理器
    yarn                  # Yarn 包管理器
  ];
}
