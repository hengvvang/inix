# Clash Verge Rev 虚拟网卡模式修复指南

## 问题描述

clash-verge-rev 无法开启虚拟网卡模式（TUN 模式），这通常是因为缺少：
1. TUN/TAP 内核模块支持
2. 用户权限配置
3. 系统网络配置

## 已进行的修复

### 1. 系统配置更新

- ✅ 在 `hosts/laptop/hardware.nix` 中添加了 `tun` 和 `tap` 内核模块
- ✅ 在 `hosts/laptop/system.nix` 中启用了 Clash 代理服务的 TUN 模式
- ✅ 创建了专门的虚拟网卡支持模块 `system/services/network/virtualInterface.nix`
- ✅ 配置了必要的用户组和权限

### 2. 权限配置

- ✅ 创建 `tun` 用户组
- ✅ 将用户添加到 `tun` 组
- ✅ 设置 TUN 设备权限 (666)
- ✅ 配置网络权限 capabilities

### 3. 系统参数

- ✅ 启用 IP 转发 (`net.ipv4.ip_forward = 1`)
- ✅ 启用 IPv6 转发
- ✅ 优化网络参数

## 使用步骤

### 方法一：自动重建（推荐）

```bash
cd /home/hengvvang/inix
./rebuild-nixos.sh
```

### 方法二：手动重建

```bash
cd /home/hengvvang/inix

# 重建 NixOS 系统配置
sudo nixos-rebuild switch --flake .#laptop

# 重建 Home Manager 配置
nix build .#homeConfigurations."hengvvang@laptop".activationPackage
./result/activate
```

### 方法三：仅用户层修复

如果只想临时修复而不重建整个配置：

```bash
./fix-clash-tun-user.sh
```

## 验证步骤

1. **检查系统状态**：
   ```bash
   # 检查用户组
   groups $USER
   
   # 检查 TUN 设备
   ls -la /dev/net/tun
   
   # 检查内核模块
   lsmod | grep tun
   
   # 检查 IP 转发
   sysctl net.ipv4.ip_forward
   ```

2. **重启或重新登录**（重要）：
   ```bash
   # 重启系统（推荐）
   sudo reboot
   
   # 或者重新登录以应用用户组更改
   ```

3. **启动 Clash Verge Rev**：
   - 打开 Clash Verge Rev
   - 进入设置 → 系统代理
   - 启用 "TUN 模式" 或 "虚拟网卡模式"
   - 导入您的代理配置

## 故障排除

### 如果仍然无法启用 TUN 模式：

1. **检查日志**：
   ```bash
   journalctl -u clash-meta --follow
   ```

2. **检查权限**：
   ```bash
   getcap $(which clash-verge-rev)
   ```

3. **手动测试 TUN 设备**：
   ```bash
   # 测试 TUN 设备访问权限
   cat /dev/net/tun
   ```

4. **重启网络服务**：
   ```bash
   sudo systemctl restart NetworkManager
   ```

### 常见错误及解决方案

| 错误信息 | 解决方案 |
|---------|---------|
| "Permission denied" | 确保用户在 tun 组中，重新登录 |
| "No such device" | 检查 TUN 模块是否加载：`sudo modprobe tun` |
| "Operation not permitted" | 检查 capabilities：`sudo setcap cap_net_admin,cap_net_raw=+eip $(which clash-verge-rev)` |

## 配置文件说明

### 关键配置文件：

1. **`hosts/laptop/hardware.nix`**：添加了 TUN/TAP 内核模块
2. **`hosts/laptop/system.nix`**：启用了 Clash TUN 模式和虚拟网卡支持
3. **`system/services/network/virtualInterface.nix`**：虚拟网卡支持模块

### 配置变更：

```nix
# 在 hosts/laptop/system.nix 中
virtualInterface = {
  enable = true;  # 启用虚拟网卡支持
};

proxy = {
  enable = true;
  clash = {
    enable = true;     # 启用 Clash 系统服务
    tunMode = true;    # 启用 TUN 模式
    autoStart = false; # 手动启动，避免冲突
  };
};
```

## 额外说明

1. **系统服务 vs 用户应用**：
   - 我们启用了系统级的 Clash 服务作为 TUN 模式的基础支持
   - clash-verge-rev 作为用户界面，可以使用这些权限

2. **权限安全**：
   - TUN 模式需要管理员权限来创建虚拟网络接口
   - 我们通过 capabilities 机制授予最小必要权限

3. **冲突避免**：
   - 系统级 Clash 服务设置为手动启动
   - 避免与 clash-verge-rev 的端口冲突

## 成功指标

当一切配置正确时，您应该能够：
- ✅ 在 Clash Verge Rev 中启用 TUN 模式
- ✅ 看到创建的虚拟网络接口（通常名为 `clash0` 或类似）
- ✅ 系统级透明代理工作正常
- ✅ 所有网络流量都通过代理（而非仅浏览器）
