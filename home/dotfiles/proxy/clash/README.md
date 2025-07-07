# Clash 代理服务配置

## 配置结构

- `system/services/network/proxy/clash/` - 系统服务配置 (完全独立)
- `home/dotfiles/proxy/clash/` - 用户配置文件管理

## 启用配置

### 系统配置 (configuration.nix)

```nix
mySystem.services.network.proxy.clash = {
  enable = true;
  tunMode = true;
  subscriptionUrl = "你的订阅链接";
  autoStart = true;
  updateInterval = "daily";
};
```

### 用户配置 (home.nix)

```nix
myHome.dotfiles.proxy.clash = {
  enable = true;
  configMethod = "homemanager";  # 或 "direct" 或 "external"
};
```

## 使用方法

### 管理服务

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

### Web UI

访问: <http://localhost:9090>

推荐 UI:
- Clash Dashboard: <https://clash.razord.top/>
- Yacd: <http://yacd.haishan.me/>

## 配置方式

### 1. Home Manager 模式 (推荐)
配置由 Nix 管理，修改配置文件后运行 `home-manager switch`

### 2. Direct 模式  
用户可直接编辑 `~/.config/clash/config.yaml`，使用脚本同步到系统

### 3. External 模式
用户配置直接链接到系统配置，修改需要 sudo 权限

## 重要特性

- ✅ TUN 模式透明代理
- ✅ 自动订阅更新
- ✅ 完整的管理工具
- ✅ 三种配置方式
- ✅ 自动备份恢复
- ✅ 防火墙集成
