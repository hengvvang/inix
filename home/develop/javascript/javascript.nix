{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.develop.enable && config.myHome.develop.javascript.enable) {
    # JavaScript 开发环境配置
    home.packages = with pkgs; [
      nodejs                # Node.js 运行时 (包含 npm)
      yarn                  # Yarn 包管理器
      nodePackages.eslint   # JavaScript linter
    ];
  };
}
