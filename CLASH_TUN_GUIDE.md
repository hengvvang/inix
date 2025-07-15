# Clash Verge Rev 虚拟网卡模式配置指南

## 配置概览

按照您的设计风格，我已经重新组织了虚拟网卡和 Clash Verge Rev 的配置：

### 1. 虚拟网卡支持模块
位置: `system/services/network/virtualInterface/`

```nix
# 在 hosts/laptop/system.nix 中的配置
virtualInterface = {
  enable = true;               # 🟢 启用虚拟网卡支持
  tun = true;                  # 启用 TUN 支持
  tap = false;                 # 禁用 TAP 支持
  forwarding = {
    ipv4 = true;               # 启用 IPv4 转发
    ipv6 = false;              # 禁用 IPv6 转发
  };
  tools = {
    basic = true;              # 启用基础网络工具
    bridge = false;            # 禁用网桥工具
  };
};
```

### 2. Clash Verge Rev 代理模块
位置: `system/services/network/proxy/clash-verge-rev/`

```nix
# 在 hosts/laptop/system.nix 中的配置
clash-verge-rev = {
  enable = true;             # 🟢 启用 Clash Verge Rev
  tunMode = true;            # 🟢 启用 TUN 模式（虚拟网卡）
  capabilities = true;       # 🟢 启用网络管理权限
  client = "clash-nyanpasu"; # 使用 clash-nyanpasu 客户端
};
```

## 设计特点

### 模块化设计
- `virtualInterface` 是独立的基础虚拟网卡支持模块
- `clash-verge-rev` 是专门的 Clash 客户端代理模块
- 两个模块职责分离，符合您的原子化设计风格

### 灵活配置
- 支持多种 Clash 客户端选择 (`clash-nyanpasu`, `clash-verge-rev`, `flclash`)
- 可选的 TUN/TAP 支持
- 细粒度的转发和工具配置

### 自动依赖管理
- `clash-verge-rev` 模块会自动启用所需的 `virtualInterface` 功能
- 包含断言检查，确保依赖正确配置

## 构建和激活

```bash
# 1. 构建配置
sudo nixos-rebuild build --flake .#laptop

# 2. 测试配置
sudo nixos-rebuild test --flake .#laptop

# 3. 永久应用配置
sudo nixos-rebuild switch --flake .#laptop
```

## 验证步骤

1. **检查内核模块**:
   ```bash
   lsmod | grep tun
   ```

2. **检查设备权限**:
   ```bash
   ls -la /dev/net/tun
   ```

3. **检查用户组**:
   ```bash
   groups $USER
   ```

4. **检查客户端安装**:
   ```bash
   which clash-nyanpasu
   ```

5. **检查权限设置**:
   ```bash
   getcap $(which clash-nyanpasu)
   ```

## 使用说明

1. 重建并切换到新配置
2. 重新登录以应用用户组更改
3. 启动 clash-nyanpasu
4. 在设置中启用 TUN 模式
5. 导入您的代理配置

## 故障排除

如果虚拟网卡模式仍然无法使用：

1. 确保重新登录系统
2. 检查 `/var/log/nixos-rebuild.log` 中的错误
3. 验证所有断言都通过
4. 查看 clash-nyanpasu 的日志输出

## 文件结构

```
system/services/network/
├── virtualInterface.nix          # 虚拟网卡模块入口
├── virtualInterface/
│   ├── default.nix               # 子模块导入
│   └── virtualInterface.nix      # 具体实现
└── proxy/
    ├── clash-verge-rev/
    │   ├── default.nix           # Clash 客户端模块入口
    │   └── clash-verge-rev.nix   # 具体实现
    └── ...
```

这种设计完全符合您的模块化风格，每个功能都有清晰的边界和职责。
