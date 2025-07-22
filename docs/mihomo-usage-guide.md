# Mihomo 代理服务使用指南

## 配置完成

我已经为您配置好了 mihomo 代理服务，配置包括：

### 服务配置
- **Web UI**: metacubexd (https://d.metacubex.one)
- **TUN 模式**: 已启用（透明代理）
- **订阅链接**: 已配置您的 utushop 订阅

### 端口配置
- **混合代理端口**: 7890 (HTTP + SOCKS5)
- **HTTP 代理端口**: 7891
- **SOCKS5 代理端口**: 7892
- **Web 控制面板**: http://127.0.0.1:9090

## 使用步骤

### 1. 部署配置
```bash
# 重建 NixOS 系统以应用新配置
sudo nixos-rebuild switch
```

### 2. 启动服务
```bash
# 启动 mihomo 服务
sudo systemctl start mihomo

# 设置开机自启
sudo systemctl enable mihomo

# 查看服务状态
sudo systemctl status mihomo

# 查看服务日志
sudo journalctl -u mihomo -f
```

### 3. 访问 Web 界面
在浏览器中打开: http://127.0.0.1:9090

在 Web 界面中您可以：
- 查看代理状态
- 切换代理节点
- 查看连接统计
- 管理规则和策略

### 4. 配置代理
mihomo 服务启动后，您可以：

**自动代理（推荐）**:
- TUN 模式已启用，所有流量会自动根据规则进行代理
- 国内网站直连，国外网站走代理

**手动代理**:
- HTTP 代理: 127.0.0.1:7891
- SOCKS5 代理: 127.0.0.1:7892
- 混合代理: 127.0.0.1:7890

### 5. 订阅更新
订阅会每小时自动更新，您也可以在 Web 界面手动更新。

## 代理组说明

已配置的代理组：
- **PROXY**: 手动选择节点
- **自动选择**: 自动选择最快节点
- **负载均衡**: 负载均衡模式
- **故障转移**: 故障转移模式

## 故障排除

### 如果服务启动失败
```bash
# 检查配置文件语法
mihomo -t -f /home/hengvvang/inix/system/services/network/proxy/mihomo/config.yaml

# 查看详细错误日志
sudo journalctl -u mihomo -n 50
```

### 如果无法访问网站
1. 确认服务运行正常: `sudo systemctl status mihomo`
2. 检查 Web 控制面板: http://127.0.0.1:9090
3. 查看连接日志确认流量是否通过代理

### 更新订阅
```bash
# 重启服务以强制更新订阅
sudo systemctl restart mihomo
```

## 注意事项

1. **首次启动**: 首次启动时会下载订阅配置，可能需要几分钟
2. **权限要求**: TUN 模式需要 root 权限，已通过 systemd 服务配置
3. **防火墙**: 如需局域网访问，请确保防火墙允许相关端口

## 高级配置

如需修改配置，请编辑:
`/home/hengvvang/inix/system/services/network/proxy/mihomo/config.yaml`

修改后执行:
```bash
sudo nixos-rebuild switch
sudo systemctl restart mihomo
```
