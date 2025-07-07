# 在你的 home.nix 或 hosts/laptop/home.nix 中添加以下配置

{ config, pkgs, ... }:

{
  # 其他配置...

  # 启用 Clash 用户配置
  myHome.dotfiles.proxy.clash = {
    enable = true;
    
    # 可选: 设置订阅链接
    # subscriptionUrl = "你的订阅链接";
    
    # 可选: 启用自动更新订阅 (每天更新一次)
    autoUpdate = false;
  };

  # 其他配置...
}
