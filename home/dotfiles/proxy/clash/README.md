# Clash 代理服务配置说明

## 配置结构

```
system/services/network/proxy/clash/  # 系统服务配置
home/dotfiles/proxy/clash/            # 用户配置文件
```

## 启用 Clash 服务

在你的系统配置中添加以下配置：

### 1. 系统配置 (configuration.nix 或相关配置文件)

```nix
{
  # 启用 Clash 系统服务
  mySystem.services.network.proxy.clash = {
    enable = true;
    configPath = "/etc/clash/config.yaml";
    webPort = 9090;          # Web UI 端口
    mixedPort = 7890;        # HTTP/SOCKS5 混合端口
    tunMode = true;          # 启用 TUN 模式
    subscriptionUrl = "你的订阅链接";  # 可选：设置订阅链接
  };
}
```

### 2. Home Manager 配置 (home.nix)

```nix
{
  # 启用 Clash 用户配置
  myHome.dotfiles.proxy.clash = {
    enable = true;
    subscriptionUrl = "你的订阅链接";
    autoUpdate = false;      # 是否自动更新订阅
  };
}
```

## 使用方法

### 1. 手动更新订阅配置

```bash
# 如果配置了订阅链接，运行更新脚本
~/.config/clash/update-subscription.sh
```

### 2. 管理服务

```bash
# 启动服务
sudo systemctl start clash

# 停止服务
sudo systemctl stop clash

# 重启服务
sudo systemctl restart clash

# 查看状态
sudo systemctl status clash

# 查看日志
sudo journalctl -u clash -f
```

### 3. 访问 Web UI

打开浏览器访问: http://localhost:9090

推荐的 Web UI 界面：
- Clash Dashboard: https://clash.razord.top/
- Yacd: http://yacd.haishan.me/

### 4. 代理设置

服务启动后，系统会自动设置以下环境变量：
- HTTP_PROXY=http://127.0.0.1:7890
- HTTPS_PROXY=http://127.0.0.1:7890
- ALL_PROXY=socks5://127.0.0.1:7890

### 5. 订阅链接配置

当你提供订阅链接后，请将其设置在配置中：

```nix
subscriptionUrl = "https://your-subscription-url";
```

然后重新构建系统配置：

```bash
sudo nixos-rebuild switch
```

## 注意事项

1. **TUN 模式**: 需要 root 权限，自动处理所有网络流量
2. **订阅更新**: 支持自动或手动更新订阅配置
3. **配置备份**: 更新订阅时会自动备份当前配置
4. **防火墙**: 自动配置防火墙规则开放相关端口

## 故障排查

1. 检查服务状态: `sudo systemctl status clash`
2. 查看日志: `sudo journalctl -u clash -f`
3. 检查配置文件: `/etc/clash/config.yaml`
4. 测试连接: `curl -x http://127.0.0.1:7890 http://www.google.com`
