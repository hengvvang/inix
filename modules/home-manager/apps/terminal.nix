{ config, lib, pkgs, ... }:

{
  # 终端相关应用
  home.packages = with pkgs; [
    # 终端工具
    alacritty      # 现代终端模拟器
    # tmux          # 终端复用器
  ];

  # 配置 Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell.program = "${pkgs.fish}/bin/fish";
    };
  };
}