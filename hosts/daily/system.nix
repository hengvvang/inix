{ config, lib, pkgs, inputs, ... }:

{
  # macOS 系统配置 - 日常使用主机配置

  # 设置主用户
  system.primaryUser = user1;

  # macOS 基本设置
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "daily";
    screencapture.location = "~/Desktop";
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # 启用 Homebrew
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
  };
}
