# Clash 代理服务 - 清理完成

## 📁 最终文件结构

```
system/services/network/proxy/clash/
├── default.nix                 # 完整的系统服务配置

home/dotfiles/proxy/clash/
├── configs/
│   └── config.yaml             # 基础配置模板
├── default.nix                 # 主配置模块
├── homemanager.nix             # Home Manager 配置 (推荐)
├── direct.nix                  # Direct 模式配置
├── external.nix                # External 模式配置
└── README.md                   # 使用说明
```

## 🚀 启用步骤

### 1. 系统配置 (已完成)
在 `configuration.nix` 中：
```nix
mySystem.services.network.proxy.clash = {
  enable = true;
  tunMode = true;
  subscriptionUrl = "你的订阅链接";  # 🔴 请添加真实订阅链接
};
```

### 2. 用户配置 (已完成)
在 `home.nix` 中：
```nix
myHome.dotfiles.proxy.clash = {
  enable = true;
  configMethod = "homemanager";  # 推荐模式
};
```

## 📋 使用命令

### 系统服务管理
```bash
clash-ctl start      # 启动服务
clash-ctl restart    # 重启服务
clash-ctl status     # 查看状态
clash-ctl logs       # 查看日志
clash-ctl update     # 更新订阅
clash-ctl test       # 测试连接
clash-ctl ui         # 显示 Web UI 地址
```

### Web UI
访问: http://localhost:9090

## 🎯 下一步

✅ **构建成功**: `sudo nixos-rebuild switch --flake .#hengvvang` 已完成
✅ **服务运行**: Clash 服务已自动启动
✅ **代理测试**: 连接 Google 成功
✅ **Web UI**: http://localhost:9090 可用

### 🔗 添加你的订阅链接

在 `configuration.nix` 中更新订阅链接：
```nix
services.network.proxy.clash = {
  enable = true;
  tunMode = true;
  subscriptionUrl = "你的真实订阅链接";  # 🔴 请替换
};
```

然后重新构建：`sudo nixos-rebuild switch --flake .#hengvvang`

配置已简化并清理完成，核心功能保持完整！🎉
