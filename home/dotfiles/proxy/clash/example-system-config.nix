# 在你的 configuration.nix 或 hosts/laptop/configuration.nix 中添加以下配置

{ config, pkgs, ... }:

{
  # 其他配置...

  # 启用 Clash 代理服务
  mySystem.services.network.proxy.clash = {
    enable = true;
    configPath = "/etc/clash/config.yaml";
    webPort = 9090;          # Web UI 端口
    mixedPort = 7890;        # HTTP/SOCKS5 混合端口
    tunMode = true;          # 启用 TUN 模式 (透明代理)
    
    # 可选: 设置订阅链接，系统会自动下载配置
    # subscriptionUrl = "你的订阅链接";
  };

  # 其他配置...
}
