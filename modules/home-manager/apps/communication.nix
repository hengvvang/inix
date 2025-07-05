{ config, lib, pkgs, ... }:

{
  # 通信相关应用
  home.packages = with pkgs; [
    # 基础通信工具
    thunderbird    # 邮件客户端
    signal-desktop # 安全通信
    telegram-desktop # 即时通信
  ];
}