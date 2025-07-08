# 代理服务 TUN 模式支持文档

## 原生 TUN 模式支持情况

### ✅ **原生支持 TUN 模式的代理**

1. **V2Ray 5.x+**
   - 原生 TUN 模式支持
   - 配置：`inbounds` 中添加 `tun` 协议
   - 接口名称：`v2ray-tun`
   - IP 范围：`172.19.0.1/30`

2. **Xray**
   - 原生 TUN 模式支持（基于 V2Ray 代码）
   - 配置：`inbounds` 中添加 `tun` 协议
   - 接口名称：`xray-tun`
   - IP 范围：`172.20.0.1/30`

3. **sing-box**
   - 原生 TUN 模式支持
   - 配置：`inbounds` 中添加 `tun` 类型
   - 接口名称：`sing-box`
   - IP 范围：`172.19.0.1/30`

### ❌ **不原生支持 TUN 模式的代理**

1. **Clash**
   - 支持 TUN 模式，但需要额外配置
   - 配置：`tun` 配置块
   - 接口名称：`clash+`

2. **Shadowsocks**
   - 不原生支持 TUN 模式
   - 通过 `tun2socks` 工具实现透明代理
   - 接口名称：`ss-tun`
   - IP 范围：`172.21.0.1/30`

## TUN 模式配置详情

### V2Ray TUN 模式配置

```json
{
  "inbounds": [
    {
      "tag": "tun-in",
      "protocol": "tun",
      "settings": {
        "tag": "tun"
      },
      "streamSettings": {
        "sockopt": {
          "tproxy": "tun"
        }
      }
    }
  ],
  "tun": {
    "tag": "tun",
    "stack": "system",
    "mtu": 1500,
    "name": "v2ray-tun",
    "inet4_address": "172.19.0.1/30",
    "inet6_address": "fdfe:dcba:9876::1/126",
    "auto_route": true,
    "strict_route": true,
    "sniff": true,
    "sniff_override_destination": true
  }
}
```

### Xray TUN 模式配置

```json
{
  "inbounds": [
    {
      "tag": "tun-in",
      "protocol": "tun",
      "settings": {
        "tag": "tun"
      },
      "streamSettings": {
        "sockopt": {
          "tproxy": "tun"
        }
      }
    }
  ],
  "tun": {
    "tag": "tun",
    "stack": "system",
    "mtu": 1500,
    "name": "xray-tun",
    "inet4_address": "172.20.0.1/30",
    "inet6_address": "fdfe:dcba:9877::1/126",
    "auto_route": true,
    "strict_route": true,
    "sniff": true,
    "sniff_override_destination": true
  }
}
```

## 系统配置要求

### 必需的系统权限

```nix
# systemd 服务配置
serviceConfig = {
  # TUN 模式需要的网络权限
  AmbientCapabilities = [ "CAP_NET_ADMIN" ];
  CapabilityBoundingSet = [ "CAP_NET_ADMIN" ];
  User = "root";  # TUN 模式通常需要 root 权限
};
```

### 内核参数配置

```nix
# 启用 IP 转发
boot.kernel.sysctl = {
  "net.ipv4.ip_forward" = 1;
  "net.ipv6.conf.all.forwarding" = 1;
  "net.core.default_qdisc" = "fq";
  "net.ipv4.tcp_congestion_control" = "bbr";
};
```

### 防火墙配置

```nix
networking.firewall = {
  # 允许 TUN 接口流量
  extraCommands = ''
    iptables -I INPUT -i v2ray-tun -j ACCEPT
    iptables -I FORWARD -i v2ray-tun -j ACCEPT
    iptables -I FORWARD -o v2ray-tun -j ACCEPT
  '';
};
```

## 使用方法

### 启用 TUN 模式

在 `configuration.nix` 中设置：

```nix
mySystem.services.network.proxy = {
  v2ray = {
    enable = true;
    tunMode = true;  # 启用 TUN 模式
    # 其他配置...
  };
  
  xray = {
    enable = true;
    tunMode = true;  # 启用 TUN 模式
    # 其他配置...
  };
};
```

### TUN 模式特性

1. **透明代理**：无需配置应用程序代理设置
2. **全局流量拦截**：自动拦截所有网络流量
3. **DNS 劫持**：可以拦截和处理 DNS 请求
4. **智能路由**：根据规则自动分流流量

### 注意事项

1. **权限要求**：TUN 模式需要 root 权限或 CAP_NET_ADMIN 能力
2. **冲突避免**：不同代理使用不同的 TUN 接口名称和 IP 范围
3. **环境变量**：TUN 模式下不设置 HTTP_PROXY 等环境变量
4. **系统配置**：需要启用 IP 转发和相关内核参数

## 端口分配

| 代理服务 | TUN 接口 | IP 范围 | TUN 端口 |
|---------|----------|---------|----------|
| V2Ray   | v2ray-tun | 172.19.0.1/30 | 10808 |
| Xray    | xray-tun  | 172.20.0.1/30 | 10809 |
| sing-box | sing-box | 172.19.0.1/30 | - |
| Clash   | clash+    | 198.18.0.1/16 | - |

## 管理命令

```bash
# V2Ray
v2ray-ctl start    # 启动服务
v2ray-ctl status   # 查看状态
v2ray-ctl test     # 测试连接

# Xray
xray-ctl start     # 启动服务
xray-ctl status    # 查看状态
xray-ctl test      # 测试连接
```
