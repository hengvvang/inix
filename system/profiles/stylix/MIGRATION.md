# Stylix 配置重构迁移指南

## 重构内容概述

重新设计了 Stylix 配置，遵循官方最佳实践，简化了配置结构。

## 主要变更

### 1. 简化的系统配置 (`system/profiles/stylix/`)

**之前**：复杂的多层嵌套选项和自定义封装
**现在**：直接映射到 Stylix 原生选项

```nix
# 新的系统配置
mySystem.profiles.stylix = {
  enable = true;
  image = ./wallpapers/sea.jpg;           # 直接指定壁纸
  colorScheme = null;                     # 可选颜色方案，null 时从壁纸生成
  polarity = "dark";                      # 主题极性
  fonts = {                              # 简化的字体配置
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    # ...其他字体
  };
};
```

### 2. 智能的用户配置 (`home/profiles/stylix/`)

**之前**：手动管理复杂的目标应用配置
**现在**：自动检测已启用的程序并设置默认值

```nix
# 新的用户配置
myHome.profiles.stylix = {
  enable = true;
  
  # 可选覆盖（不设置则跟随系统）
  image = null;                          # 用户自定义壁纸
  colorScheme = null;                    # 用户颜色方案
  polarity = null;                       # 用户主题极性
  
  # 目标应用自动检测
  targets = {
    terminals.alacritty.enable = config.programs.alacritty.enable; # 自动跟随
    editors.neovim.enable = config.programs.neovim.enable;
    # 可以手动覆盖
    browsers.firefox.enable = true;      # 强制启用
  };
};
```

### 3. 移除的复杂功能

- ❌ 自定义颜色方案映射系统
- ❌ 复杂的壁纸预设管理
- ❌ 多层嵌套的配置选项
- ❌ 过度封装的目标应用配置

### 4. 新增的便利功能

- ✅ 自动程序检测和目标启用
- ✅ 更直观的 Stylix 原生选项映射
- ✅ 简化的继承机制配置
- ✅ 清晰的系统/用户配置分离

## 迁移步骤

### 1. 更新系统配置

```nix
# 在主机配置中
mySystem.profiles.stylix = {
  enable = true;
  image = ./path/to/wallpaper.jpg;  # 直接指定壁纸路径
  polarity = "dark";                # 或 "light"
};
```

### 2. 更新用户配置

```nix
# 在用户配置中
myHome.profiles.stylix = {
  enable = true;
  # 大部分情况下只需要这样，会自动跟随系统并检测程序
  
  # 可选：用户特定覆盖
  fontSize.terminal = 14;  # 调整终端字体大小
};
```

### 3. 清理旧配置

移除所有旧的复杂配置选项：
- `wallpapers.preset`
- `colors.scheme` 
- `fonts.packages.*`
- `targets.*.enable` (除非需要覆盖自动检测)

## 配置示例

### 基础用户（跟随系统）
```nix
myHome.profiles.stylix.enable = true;
# 就这么简单！
```

### 高级用户（自定义主题）
```nix
myHome.profiles.stylix = {
  enable = true;
  image = ./my-wallpaper.jpg;
  colorScheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  polarity = "light";
  fontSize.terminal = 14;
};
```

## 优势

1. **符合官方设计**：直接使用 Stylix 原生选项
2. **更少配置**：自动检测减少手动设置
3. **更好维护**：简化的结构易于理解和更新
4. **更好性能**：减少了不必要的抽象层
5. **更强兼容**：与 Stylix 更新保持一致
