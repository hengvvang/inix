{ config, lib, pkgs, ... }:

{
  # Linux 系统工具配置模块 - 日常使用和管理
  home.packages = with pkgs; [
    gnupg              # GPG 加密
    openssh            # SSH 客户端
  ];
  
  home.shellAliases = {

  };
}
