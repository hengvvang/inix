# 会话管理配置

此部分涵盖与会话序列化、恢复和管理相关的配置选项。

## 会话序列化

### session_serialization
启用后，会话将被序列化到缓存文件夹（包括标签页/窗格、工作目录和运行的命令），以便稍后可以在重启或退出后恢复。

**可选值:**
- `true` (默认) - 启用会话序列化
- `false` - 禁用会话序列化

**注意:** 需要重启生效

```kdl
session_serialization false
```

### pane_viewport_serialization
与 `session_serialization` 一起启用时，窗格视图（终端的可见部分，不包括滚动缓冲区）也将被序列化和恢复。

**可选值:**
- `true` - 启用窗格视图序列化
- `false` (默认) - 禁用窗格视图序列化

**注意:** 需要重启生效

```kdl
pane_viewport_serialization true
```

### scrollback_lines_to_serialize
当启用 `pane_viewport_serialization` 时，设置要序列化的滚动历史行数。

**可选值:**
- `0` - 序列化所有滚动历史
- 正整数 - 序列化指定行数（最大为滚动缓冲区限制）

**注意:** 这可能导致更高的资源使用率和缓存文件夹使用量

```kdl
scrollback_lines_to_serialize 100
```

### serialization_interval
会话序列化到磁盘的间隔时间（秒）（如果启用了 `session_serialization`）。

**可选值:** 正整数（秒）

**注意:** 这可能导致更高的资源使用率和缓存文件夹使用量

```kdl
serialization_interval 60
```

### post_command_discovery_hook
当 Zellij 尝试发现窗格内运行的命令以便序列化时，有时可能不准确。这在命令在某种包装器内运行时可能发生。为了解决这个问题，可以定义一个后处理钩子。

这个命令将在用户默认 shell 的上下文中运行，并接收刚刚发现但尚未序列化的特定窗格的 `$RESURRECT_COMMAND`。该命令通过 `STDOUT` 输出的任何内容都将替代发现的命令被序列化。

**示例:**
```kdl
post_command_discovery_hook "echo \"$RESURRECT_COMMAND\" | sed 's/^sudo\\s\\+//'"  // 从命令中删除 sudo
```

## 会话元数据

### disable_session_metadata
启用或禁用向磁盘写入会话元数据

**可选值:**
- `true` - 禁用元数据写入
- `false` (默认) - 启用元数据写入

**注意:**
- 如果禁用，其他会话可能不知道此会话的元数据信息
- 会话管理器和会话列表等功能可能无法正常工作
- 需要重启生效

```kdl
disable_session_metadata true
```

## Web 服务器配置

### web_server
是否在启动时启动 Zellij Web 服务器

**可选值:**
- `true` - 启动 Web 服务器
- `false` (默认) - 不启动 Web 服务器

**注意:** 需要重启生效

```kdl
web_server true
```

### web_server_ip
Zellij Web 服务器监听的 IP 地址

**默认值:** `"127.0.0.1"`

**注意:** 需要重启生效

```kdl
web_server_ip "0.0.0.0"  // 监听所有接口
```

### web_server_port
Zellij Web 服务器监听的端口

**默认值:** `8082`

**注意:** 需要重启生效

```kdl
web_server_port 9000
```

### web_server_cert
Zellij Web 服务器的 SSL 证书路径

**注意:** 必须同时设置 `web_server_key` 才能提供 HTTPS 服务

```kdl
web_server_cert "/path/to/cert.pem"
```

### web_server_key
Zellij Web 服务器 SSL 证书的私钥路径

**注意:** 必须同时设置 `web_server_cert` 才能提供 HTTPS 服务

```kdl
web_server_key "/path/to/private.key"
```

### enforce_https_on_localhost
是否在 localhost 上强制 HTTPS 连接

**可选值:**
- `true` - 强制 HTTPS
- `false` (默认) - 允许 HTTP

**注意:** 在非本地接口上始终强制 HTTPS

```kdl
enforce_https_on_localhost true
```

### web_client
Web 客户端的浏览器内终端配置（如颜色、字体）

```kdl
web_client {
    font "JetBrains Mono"
    font_size 14
}
```

## 会话恢复最佳实践

### 基本会话恢复
```kdl
session_serialization true
serialization_interval 30
```

### 完整会话恢复（包括视图）
```kdl
session_serialization true
pane_viewport_serialization true
scrollback_lines_to_serialize 1000
serialization_interval 60
```

### Web 服务器配置示例
```kdl
web_server true
web_server_ip "127.0.0.1"
web_server_port 8082
web_client {
    font "Fira Code"
}
```

### 高安全性配置
```kdl
web_server_cert "/etc/ssl/certs/zellij.crt"
web_server_key "/etc/ssl/private/zellij.key"
enforce_https_on_localhost true
disable_session_metadata false  // 保留元数据以供审计
```
