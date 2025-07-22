# V2ray、Xray 和 Shadowsocks 代理服务配置指南

## 配置完成

我已经为您配置了三个代理服务模块，所有配置都基于 MyNixOS 官方文档支持的选项：

### 1. V2ray 代理服务

V2ray 是一个功能强大的网络代理工具。

**配置选项**：
- `mySystem.services.network.proxy.v2ray.enable` - 启用 V2ray 服务
- `mySystem.services.network.proxy.v2ray.package` - 指定 V2ray 包（默认：pkgs.v2ray）
- `mySystem.services.network.proxy.v2ray.config` - 内联配置对象
- `mySystem.services.network.proxy.v2ray.configFile` - 配置文件路径

**默认端口**：
- SOCKS5: 1080
- HTTP: 8080

### 2. Xray 代理服务

Xray 是 V2ray 的高性能分支，兼容 V2ray 配置。

**配置选项**：
- `mySystem.services.network.proxy.xray.enable` - 启用 Xray 服务
- `mySystem.services.network.proxy.xray.package` - 指定 Xray 包（默认：pkgs.xray）
- `mySystem.services.network.proxy.xray.settings` - 内联配置对象
- `mySystem.services.network.proxy.xray.settingsFile` - 配置文件路径

**默认端口**：
- SOCKS5: 1080
- HTTP: 8080

### 3. Shadowsocks 代理服务

Shadowsocks 是一个轻量级的代理工具。

**配置选项**：
- `mySystem.services.network.proxy.shadowsocks.enable` - 启用 Shadowsocks 服务
- `mySystem.services.network.proxy.shadowsocks.mode` - 协议模式（tcp_only/tcp_and_udp/udp_only）
- `mySystem.services.network.proxy.shadowsocks.localAddress` - 本地绑定地址
- `mySystem.services.network.proxy.shadowsocks.port` - 服务端口（默认：8388）
- `mySystem.services.network.proxy.shadowsocks.password` - 连接密码
- `mySystem.services.network.proxy.shadowsocks.passwordFile` - 密码文件路径
- `mySystem.services.network.proxy.shadowsocks.encryptionMethod` - 加密方法（默认：chacha20-ietf-poly1305）

## 使用步骤

### 1. 在主机配置中启用服务

在您的主机配置文件（如 `hosts/laptop/system.nix`）中添加：

```nix
{
  # 启用代理服务支持
  mySystem.services.network.proxy.enable = true;
  
  # 启用 V2ray
  mySystem.services.network.proxy.v2ray = {
    enable = true;
    configFile = /home/hengvvang/inix/system/services/network/proxy/v2ray/config.json;
  };
  
  # 启用 Xray
  mySystem.services.network.proxy.xray = {
    enable = true;
    settingsFile = /home/hengvvang/inix/system/services/network/proxy/xray/config.json;
  };
  
  # 启用 Shadowsocks
  mySystem.services.network.proxy.shadowsocks = {
    enable = true;
    port = 8388;
    password = "your-password-here";
    encryptionMethod = "chacha20-ietf-poly1305";
  };
}
```

### 2. 配置代理服务器信息

**V2ray/Xray 配置**：
编辑配置文件 `/system/services/network/proxy/v2ray/config.json` 或 `/system/services/network/proxy/xray/config.json`，修改以下关键信息：
- `outbounds.settings.vnext.address` - 服务器地址
- `outbounds.settings.vnext.users.id` - 用户 UUID
- `streamSettings` - 传输协议设置

**Shadowsocks 配置**：
在 NixOS 配置中设置：
```nix
mySystem.services.network.proxy.shadowsocks = {
  enable = true;
  localAddress = ["127.0.0.1"];
  port = 8388;
  password = "your-server-password";
  encryptionMethod = "chacha20-ietf-poly1305";
};
```

### 3. 部署配置

```bash
# 重建系统配置
sudo nixos-rebuild switch

# 查看服务状态
sudo systemctl status v2ray
sudo systemctl status xray  
sudo systemctl status shadowsocks-libev

# 查看服务日志
sudo journalctl -u v2ray -f
sudo journalctl -u xray -f
sudo journalctl -u shadowsocks-libev -f
```

## 故障排除

### 服务无法启动
```bash
# 检查配置文件语法
v2ray test -config /path/to/config.json
xray run -test -config /path/to/config.json

# 查看详细错误日志
sudo journalctl -u v2ray -n 50
sudo journalctl -u xray -n 50
sudo journalctl -u shadowsocks-libev -n 50
```

## 注意事项

1. **配置文件权限**: 确保配置文件有正确的读取权限
2. **防火墙**: 相关端口已自动在防火墙中开放
3. **服务依赖**: 确保网络服务正常运行
4. **密码安全**: 建议使用 `passwordFile` 而不是直接在配置中写明文密码
