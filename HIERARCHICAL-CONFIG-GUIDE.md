# 层次化配置风格 - 配置指南

## 🎯 设计原理

采用层次化的配置结构，先启用上级模块，再启用具体功能：
- `module.enable = true` → `module.feature.enable = true`
- 例如：`localization.enable = true` → `timeZone.enable = true` → `shanghai.enable = true`

## 📋 配置模板

### System Configuration (configuration.nix)

```nix
mySystem = {
  # 桌面环境配置
  desktop = {
    enable = true;                   # 🔑 启用桌面环境模块
    cosmic.enable = true;            # 使用 COSMIC 桌面环境
  };
  
  # 用户管理配置
  users = {
    enable = true;                   # 🔑 启用用户配置模块
  };
  
  # 系统包管理配置
  packages = {
    enable = true;                   # 🔑 启用系统包模块
  };

  # 本地化配置
  localization = {
    enable = true;                   # 🔑 启用本地化模块
    timeZone = {
      enable = true;                 # 🔑 启用时区配置
      shanghai.enable = true;        # 使用上海时区
    };
    inputMethod = {
      enable = true;                 # 🔑 启用输入法配置
      fcitx5.enable = true;          # 使用 fcitx5 输入法
    };
  };
  
  # 服务配置
  services = {
    enable = true;                   # 🔑 启用服务模块
    network = {
      enable = true;                 # 🔑 启用网络服务
      proxy = {
        enable = true;               # 🔑 启用代理服务模块
        
        # 具体代理服务（按需启用）
        clash = {
          enable = false;            # 🔴 禁用 - 需要时设为 true
          tunMode = true;
          subscriptionUrl = "你的订阅链接";
        };
        
        v2ray = {
          enable = false;            # 🔴 禁用 - 需要时设为 true
          httpPort = 8080;
          subscriptionUrl = "你的订阅链接";
        };
      };
    };
  };
};
```

### Home Configuration (home.nix)

```nix
myHome = {
  # 开发环境配置
  development = {
    enable = true;                   # 🔑 启用开发环境模块
    languages = {
      enable = true;                 # 🔑 启用编程语言支持
      rust.enable = true;            # Rust 开发环境
      python.enable = true;          # Python 开发环境
    };
    embedded = {
      enable = true;                 # 🔑 启用嵌入式开发
      toolchain.enable = true;       # 嵌入式工具链
    };
  };
  
  # Dotfiles 配置管理
  dotfiles = {
    enable = true;                   # 🔑 启用 dotfiles 模块
    vim.enable = true;               # Vim 配置
    git.enable = true;               # Git 配置
    proxy = {
      enable = true;                 # 🔑 启用代理配置模块
      clash = {
        enable = false;              # 🔴 禁用 - 需要时设为 true
        configMethod = "homemanager";
      };
    };
  };
  
  # 用户配置档案
  profiles = {
    enable = true;                   # 🔑 启用配置档案模块
    fonts = {
      enable = true;                 # 🔑 启用字体配置
      fonts.enable = true;           # 字体包
    };
  };
  
  # 工具包配置
  toolkits = {
    enable = true;                   # 🔑 启用工具包模块
    system = {
      enable = true;                 # 🔑 启用系统工具包
      hardware.enable = true;        # 硬件工具
      monitor.enable = true;         # 系统监控
    };
    user = {
      enable = true;                 # 🔑 启用用户工具包
      utilities.enable = true;       # 用户工具
    };
  };
};
```

## 🔑 层次化启用规则

### 启用顺序
1. **顶级模块**: `module.enable = true`
2. **子模块**: `module.submodule.enable = true`  
3. **具体功能**: `module.submodule.feature.enable = true`

### 示例流程
```nix
# ❌ 错误：跳过上级模块
timeZone.shanghai.enable = true;

# ✅ 正确：层次化启用
localization = {
  enable = true;              # 1. 启用本地化模块
  timeZone = {
    enable = true;            # 2. 启用时区子模块
    shanghai.enable = true;   # 3. 启用具体时区
  };
};
```

## 📂 模块结构对照

### System 模块
- `desktop.enable` → `desktop.cosmic.enable`
- `users.enable` → 用户配置
- `packages.enable` → 系统包配置
- `localization.enable` → `timeZone.enable` → `shanghai.enable`
- `localization.enable` → `inputMethod.enable` → `fcitx5.enable`
- `services.enable` → `network.enable` → `proxy.enable` → `clash.enable`

### Home 模块
- `development.enable` → `languages.enable` → `rust.enable`
- `development.enable` → `embedded.enable` → `toolchain.enable`
- `dotfiles.enable` → `vim.enable`, `git.enable`
- `dotfiles.enable` → `proxy.enable` → `clash.enable`
- `profiles.enable` → `fonts.enable` → `fonts.enable`
- `toolkits.enable` → `system.enable` → `hardware.enable`
- `toolkits.enable` → `user.enable` → `utilities.enable`

## 🎯 使用优势

1. **清晰的依赖关系**: 显式声明模块启用顺序
2. **灵活的控制粒度**: 可以在任意层级禁用整个分支
3. **更好的可读性**: 配置结构一目了然
4. **统一的配置风格**: 所有模块遵循相同的启用模式
5. **易于维护**: 模块间的依赖关系更明确

## ✅ 验证状态

- ✅ System 配置更新完成
- ✅ Home 配置更新完成  
- ✅ 所有模块 enable 选项添加完成
- ✅ 系统构建测试通过
- ✅ 配置风格统一化完成

**新的层次化配置风格已全面部署并验证可用！** 🎉
