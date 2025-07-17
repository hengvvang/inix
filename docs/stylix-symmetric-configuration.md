# Stylix 对称配置架构设计

## 🎯 设计理念

这个对称配置架构实现了 `system/profiles/*` 和 `home/profiles/*` 的完美对称设计，其中：

- **系统级配置** (`system/profiles/stylix`) - 为所有用户提供基础配置
- **用户级配置** (`home/profiles/stylix`) - 用户个性化配置，可覆盖系统默认值

## 📁 目录结构对比

```
system/profiles/stylix/          home/profiles/stylix/
├── default.nix          ←→     ├── default.nix
├── wallpapers.nix       ←→     ├── wallpapers.nix  
├── fonts.nix            ←→     ├── fonts.nix
├── targets.nix          ←→     ├── targets.nix
└── wallpapers/          ←→     └── wallpapers/
    (软链接到 home 版本)          (实际壁纸文件)
```

## 🔄 覆盖机制

### 优先级排序
1. **用户配置** (最高优先级)
2. **系统配置** (中等优先级)  
3. **Stylix 默认** (最低优先级)

### 配置继承与覆盖示例

```nix
# 系统级配置 (system/profiles/stylix)
mySystem.profiles.stylix = {
  enable = true;
  polarity = "dark";                    # 系统默认暗色
  fonts.sizes.terminal = 12;            # 系统默认终端字体大小
  targets.userDefaults.firefox.enable = true;  # 系统默认启用 Firefox 主题
};

# 用户级配置 (home/profiles/stylix)  
myHome.profiles.stylix = {
  enable = true;
  polarity = "light";                   # ✅ 覆盖: 用户偏好亮色主题
  fonts.sizes.terminal = 14;            # ✅ 覆盖: 用户偏好大字体
  # firefox 沿用系统配置 (enable = true)
  targets.terminals.alacritty.enable = false;  # ✅ 覆盖: 用户禁用 Alacritty 主题
};

# 最终生效配置
stylix = {
  polarity = "light";                   # 来自用户配置
  fonts.sizes.terminal = 14;            # 来自用户配置
  targets = {
    firefox.enable = true;              # 来自系统配置
    alacritty.enable = false;           # 来自用户配置
  };
};
```

## 🎛️ 系统级配置职责

### 基础设施组件
- ✅ GRUB 引导主题
- ✅ Plymouth 启动画面
- ✅ GDM/LightDM/SDDM 登录界面
- ✅ 系统级 GTK/Qt 主题
- ✅ 系统默认字体配置

### 用户应用默认值
- ✅ 为用户应用提供合理的默认配置
- ✅ 用户可以选择性覆盖这些默认值

## 🏠 用户级配置职责

### 个性化设置
- ✅ 用户偏好的壁纸和主题极性
- ✅ 个人字体偏好和大小调整
- ✅ 应用程序主题的精细控制

### 应用程序主题
- ✅ 终端 (Alacritty, Kitty)
- ✅ 编辑器 (Vim, Neovim)
- ✅ 工具 (Tmux, Bat, Fzf)
- ✅ 浏览器 (Firefox)
- ✅ 输入法 (Fcitx5)

## 📝 配置示例

### 主机配置 (hosts/laptop/system.nix)
```nix
mySystem.profiles.stylix = {
  enable = true;
  polarity = "dark";
  wallpapers = {
    enable = true;
    preset = "sea";
  };
  targets = {
    enable = true;
    boot.grub.enable = true;
    display.gdm.enable = true;
    desktop.gtk.enable = true;
    userDefaults = {
      terminals.alacritty.enable = true;
      browsers.firefox.enable = true;
    };
  };
};
```

### 用户配置 (users/hengvvang/laptop.nix)
```nix
profiles.stylix = {
  enable = true;
  # polarity = "dark";  # 沿用系统配置
  wallpapers = {
    enable = true;
    custom = ./wallpapers/personal.jpg;  # 覆盖系统壁纸
  };
  targets = {
    enable = true;
    terminals.alacritty.enable = false;  # 覆盖系统默认，避免冲突
    browsers.firefox.enable = true;      # 沿用系统默认
    inputMethods.fcitx5.enable = true;   # 用户额外启用
  };
};
```

## 🔧 实际应用场景

### 1. 多用户环境
```
用户 hengvvang:
├── 系统: 暗色主题 + 系统壁纸 + 基础字体
└── 个人: 自定义壁纸 + 大字体 + 完整应用主题

用户 zlritsu:  
├── 系统: 暗色主题 + 系统壁纸 + 基础字体  (相同基础)
└── 个人: 亮色主题 + 系统壁纸 + 最小应用主题  (不同偏好)
```

### 2. 多主机配置
```
laptop 主机:
├── 系统: 完整桌面环境 + 开发工具默认主题
└── 用户: 开发优化配置

work 主机:
├── 系统: 简化桌面 + 办公软件默认主题  
└── 用户: 办公优化配置
```

## ✨ 设计优势

### 1. **配置一致性**
- 系统和用户配置选项结构完全对称
- 减少学习成本和配置错误

### 2. **灵活的覆盖**
- 用户可以选择性覆盖任何系统默认值
- 未配置的选项自动继承系统配置

### 3. **维护简便性**
- 系统管理员维护基础配置
- 用户专注于个性化设置
- 配置逻辑清晰，易于调试

### 4. **可扩展性**
- 新用户自动获得合理默认配置
- 新主机可以定义不同的系统级配置
- 支持未来添加更多配置选项

## 🚀 最佳实践

1. **系统级配置原则**：
   - 提供合理的默认值
   - 启用基础设施组件
   - 避免过度个性化

2. **用户级配置原则**：
   - 只覆盖需要个性化的选项
   - 利用系统默认值减少配置量
   - 在注释中说明覆盖原因

3. **维护建议**：
   - 定期同步系统和用户配置选项结构
   - 使用注释说明配置决策
   - 测试多用户场景确保覆盖正确

这种对称设计提供了最大的灵活性和最佳的用户体验，是 NixOS + Home Manager 环境下的理想配置模式。
