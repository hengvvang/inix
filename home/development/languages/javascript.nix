{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.development.languages.javascript.enable {
    home.packages = with pkgs; [
      nodejs                # Node.js 运行时 (包含 npm)
      yarn                  # Yarn 包管理器
    ];
  };
}
