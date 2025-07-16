# 🌘 残月 - 基础应用核心

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningCrescent.enable {
    home.packages = with pkgs; [
      
      # 基础 Shell 工具
      fish              # Fish shell
      nushell           # Nushell
      
      # 基础终端
      ghostty           # Ghostty 终端
      
      # 基础浏览器
      qutebrowser       # 轻量级浏览器
      
    ];
  };
}
