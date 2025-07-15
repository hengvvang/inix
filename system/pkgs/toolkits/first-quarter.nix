# 🌓 上弦月 - 高级终端和基础开发
# 提供高级终端功能和基础开发工具
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.firstQuarter.enable {
    environment.systemPackages = with pkgs; [
      # 高级Shell和终端工具
      nushell           # 现代化shell
      ghostty           # 现代终端
      starship          # 美化的提示符
      tmux              # 终端复用器
      
      # 文件管理器
      yazi              # 现代终端文件管理器
      ranger            # 传统终端文件管理器
      
      # 基础开发工具
      neovim            # 现代化 vim
      lazygit           # Git TUI客户端
      gitui             # 另一个 Git TUI
      delta             # 更好的 git diff
      
      # 文本处理工具
      choose            # 更好的 cut
      sd                # 现代 sed
      jq                # JSON 处理
      yq                # YAML 处理
      tealdeer          # 快速 man 页面 (tldr)
      
      # 网络工具
      wget              # 文件下载
      curl              # HTTP 客户端
      httpie            # 现代 curl
      gping             # 现代 ping
      
      # 文件操作
      rsync             # 文件同步
      hexyl             # 十六进制查看器
      
      # 安全工具
      openssh           # SSH 客户端
      gnupg             # GPG 加密
    ];
  };
}
