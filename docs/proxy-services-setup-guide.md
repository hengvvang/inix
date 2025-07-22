# 代理服务配置指南

本指南介绍如何配置和使用 v2raya、xray 和 shadowsocks 代理服务。

## V2rayA 配置

V2rayA 是一个图形化的 v2ray 管理工具，提供 Web 界面管理。

### 启用 V2rayA

在您的主机配置中添加：

```nix
{
  mySystem.services.network.proxy.v2raya = {
    enable = true;
    # 可选：自定义包
    cliPackage = pkgs.v2ray;  # 或 pkgs.xray
    package = pkgs.v2raya;
  };
}
```

### 使用步骤

1. **部署配置**：
   ```bash
   sudo nixos-rebuild switch
   ```

2. **启动服务**：
   ```bash
   sudo systemctl start v2raya
   sudo systemctl enable v2raya
   ```

3. **访问 Web 界面**：
   打开浏览器访问：http://127.0.0.1:2017

4. **配置代理**：
   - 在 Web 界面中添加订阅链接
   - 选择节点并启动代理
   - 配置系统代理或透明代理

## Xray 配置

Xray 是高性能的代理工具，兼容 v2ray 协议。

### 启用 Xray

#### 方式一：使用内联配置

```nix
{
  mySystem.services.network.proxy.xray = {
    enable = true;
    settings = {
      inbounds = [{
        tag = "socks-in";
        protocol = "socks";
        listen = "127.0.0.1";
        port = 1080;
        settings = {
          auth = "noauth";
          udp = true;
        };
      }];
      outbounds = [{
        tag = "proxy";
        protocol = "vmess";
        settings = {
          vnext = [{
            address = "your-server.com";
            port = 443;
            users = [{
              id = "your-uuid-here";
              alterId = 0;
            }];
          }];
        };
      }];
    };
  };
}
```

#### 方式二：使用配置文件

```nix
{
  mySystem.services.network.proxy.xray = {
    enable = true;
    settingsFile = "/path/to/your/config.json";
  };
}
```

### 使用配置文件模板

您可以使用提供的配置文件模板：
`/home/hengvvang/inix/system/services/network/proxy/xray/config.json`

修改其中的服务器信息：
- `address`: 您的服务器地址
- `port`: 服务器端口
- `id`: 您的 UUID
- `path`: WebSocket 路径（如果使用 WS 传输）

### 使用步骤

1. **部署配置**：
   ```bash
   sudo nixos-rebuild switch
   ```

2. **启动服务**：
   ```bash
   sudo systemctl start xray
   sudo systemctl enable xray
   ```

3. **配置代理**：
   - SOCKS5 代理：127.0.0.1:1080
   - HTTP 代理：127.0.0.1:8080

## Shadowsocks 配置

Shadowsocks 是轻量级的代理工具。

### 启用 Shadowsocks

```nix
{
  mySystem.services.network.proxy.shadowsocks = {
    enable = true;
    mode = "tcp_and_udp";
    localAddress = ["127.0.0.1"];
    port = 8388;
    password = "your-password";  # 或使用 passwordFile
    encryptionMethod = "chacha20-ietf-poly1305";
    fastOpen = true;
  };
}
```

### 使用密码文件（推荐）

出于安全考虑，建议使用密码文件：

1. 创建密码文件：
   ```bash
   echo "your-secure-password" | sudo tee /etc/shadowsocks-password
   sudo chmod 600 /etc/shadowsocks-password
   ```

2. 配置使用密码文件：
   ```nix
   {
     mySystem.services.network.proxy.shadowsocks = {
       enable = true;
       passwordFile = "/etc/shadowsocks-password";
       # 其他配置...
     };
   }
   ```

### 使用步骤

1. **部署配置**：
   ```bash
   sudo nixos-rebuild switch
   ```

2. **启动服务**：
   ```bash
   sudo systemctl start shadowsocks-libev
   sudo systemctl enable shadowsocks-libev
   ```

3. **配置客户端**：
   - 服务器地址：127.0.0.1
   - 端口：8388（或您配置的端口）
   - 密码：您设置的密码
   - 加密方法：chacha20-ietf-poly1305

## 支持的加密方法

Shadowsocks 支持以下加密方法：
- `aes-128-gcm`
- `aes-256-gcm`
- `chacha20-ietf-poly1305`（推荐）
- `xchacha20-ietf-poly1305`

## 故障排除

### 服务启动失败

```bash
# 查看服务状态
sudo systemctl status v2raya  # 或 xray/shadowsocks-libev

# 查看详细日志
sudo journalctl -u v2raya -f  # 或 xray/shadowsocks-libev
```

### 端口冲突

如果端口冲突，可以修改配置中的端口号：

```nix
{
  mySystem.services.network.proxy.shadowsocks.port = 8389;  # 更改端口
}
```

### 防火墙问题

如果需要局域网访问，请确保防火墙允许相关端口：

```nix
{
  networking.firewall = {
    allowedTCPPorts = [ 2017 1080 8080 8388 ];  # 根据需要添加端口
  };
}
```

## 配置示例

### 完整配置示例

```nix
{
  # 启用代理服务支持
  mySystem.services.network.proxy.enable = true;
  
  # V2rayA - 图形化管理
  mySystem.services.network.proxy.v2raya.enable = true;
  
  # Xray - 高性能代理
  mySystem.services.network.proxy.xray = {
    enable = true;
    settingsFile = "/home/hengvvang/inix/system/services/network/proxy/xray/config.json";
  };
  
  # Shadowsocks - 轻量级代理
  mySystem.services.network.proxy.shadowsocks = {
    enable = true;
    mode = "tcp_and_udp";
    port = 8388;
    passwordFile = "/etc/shadowsocks-password";
    encryptionMethod = "chacha20-ietf-poly1305";
  };
}
```

## 注意事项

1. **安全性**：使用密码文件而非明文密码
2. **权限**：某些功能可能需要 root 权限
3. **端口**：确保端口不冲突
4. **防火墙**：根据需要开放相应端口
5. **更新**：定期更新代理软件包以获得最新功能和安全修复

## 高级配置

### 透明代理配置

对于需要透明代理的场景，可以结合 iptables 规则实现全局代理。具体配置请参考各代理工具的官方文档。

### 负载均衡

可以同时启用多个代理服务，通过上层工具实现负载均衡和故障转移。
