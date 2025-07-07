# Clash 代理服务配置完成

## 🎯 配置结构

### 系统服务 (完全独立)
- **位置**: `system/services/network/proxy/clash/`
- **功能**: 完整的 Clash 系统服务，包括：
  - 自动下载订阅配置
  - TUN 模式支持
  - 系统级代理环境变量
  - 自动更新订阅
  - 完整的系统服务管理
  - 防火墙配置
  - 系统优化

### 用户配置 (三种方式)
- **位置**: `home/dotfiles/proxy/clash/`
- **功能**: 管理用户配置文件，支持三种配置方式

## 🚀 使用步骤

### 1. 设置订阅链接

在 `hosts/laptop/configuration.nix` 中更新订阅链接：

```nix
services.network.proxy.clash = {
  enable = true;
  tunMode = true;
  subscriptionUrl = "你的实际订阅链接";  # 🔴 请替换这里
  autoStart = true;
  updateInterval = "daily";
};
```

### 2. 重新构建系统

```bash
cd /home/hengvvang/nix
sudo nixos-rebuild switch
```

### 3. 验证服务状态

```bash
# 检查服务状态
clash-ctl status

# 查看日志
clash-ctl logs

# 测试连接
clash-ctl test
```

### 4. 访问 Web UI

打开浏览器访问: http://localhost:9090

推荐的 Web UI:
- Clash Dashboard: https://clash.razord.top/
- Yacd: http://yacd.haishan.me/

## 🛠️ 管理命令

### 系统级管理
```bash
clash-ctl start      # 启动服务
clash-ctl stop       # 停止服务
clash-ctl restart    # 重启服务
clash-ctl status     # 查看状态
clash-ctl logs       # 查看日志
clash-ctl update     # 更新订阅
clash-ctl test       # 测试连接
clash-ctl ui         # 显示 Web UI 地址
```

### 用户配置管理
```bash
# 进入用户配置目录
cd ~/.config/clash

# 使用配置工具
./clash-tools.sh status     # 查看配置状态
./clash-tools.sh diff       # 比较配置差异
./clash-tools.sh backup     # 备份配置
./clash-tools.sh validate   # 验证配置
```

## 📋 三种配置方式

### 1. Home Manager 模式 (推荐)
- 配置由 Nix 管理
- 修改 Nix 配置后运行 `home-manager switch`
- 最稳定和可重现

### 2. Direct 模式
- 用户可以直接编辑 `~/.config/clash/config.yaml`
- 使用 `./manage.sh sync-to-system` 同步到系统

### 3. External 模式
- 用户配置直接链接到系统配置
- 修改需要 sudo 权限
- 最简单的方式

## 🔧 重要特性

✅ **完全独立的系统服务**: 无需 dotfiles 即可运行
✅ **TUN 模式**: 透明代理，自动处理所有流量
✅ **自动订阅更新**: 支持定时自动更新
✅ **完整的管理工具**: 系统级和用户级管理命令
✅ **三种配置方式**: 适应不同使用习惯
✅ **备份和恢复**: 自动备份配置文件
✅ **配置验证**: 启动前验证配置文件
✅ **日志管理**: 完整的日志记录
✅ **防火墙集成**: 自动配置防火墙规则

## ⚠️ 注意事项

1. **订阅链接**: 请将配置中的订阅链接替换为你的实际链接
2. **TUN 模式**: 需要 root 权限，已自动配置
3. **防火墙**: 已自动开放相关端口 (7890, 9090)
4. **配置备份**: 更新订阅时会自动备份
5. **服务重启**: 配置更新后会自动重启服务

## 🎉 下一步

现在请提供你的订阅链接，我会帮你更新配置！

提供订阅链接后，你只需要：
1. 运行 `sudo nixos-rebuild switch`
2. 访问 http://localhost:9090 管理代理

就可以开始使用了！
