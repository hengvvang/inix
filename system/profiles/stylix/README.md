# 系统级 Stylix 配置 🎨

这是系统级的 Stylix 主题配置模块，与 `home/profiles/stylix` 用户级配置保持一致的结构，但专门处理系统级的主题设置。

## 配置结构 📁

```
system/profiles/stylix/
├── default.nix      # 主配置文件和选项定义
├── colors.nix       # 自定义颜色配置
├── fonts.nix        # 系统字体配置
├── targets.nix      # 系统目标应用配置
├── wallpapers.nix   # 壁纸配置逻辑
├── wallpapers/      # 系统壁纸资源
└── README.md        # 本文档
```

## 主要特性 ✨

### 🎯 系统级配置范围
- **系统启动主题**: GRUB、Plymouth 启动画面
- **登录管理器**: LightDM、GDM、SDDM 登录主题
- **系统级桌面**: 全局 GTK/Qt 主题
- **控制台主题**: 系统控制台配色
- **用户默认值**: 为用户应用提供系统级默认主题

### 🎨 颜色配置
支持与用户级一致的颜色方案：
- `warm-white` - 🤍 简约白色暖色调（推荐亮色主题）
- `cool-blue` - 🩵 冷静蓝色主题
- `forest-green` - 🌿 森林绿色主题
- `sunset-orange` - 🧡 日落橙色主题
- `lavender-purple` - 💜 薰衣草紫色主题
- `dark-elegant` - 🖤 优雅深色主题
- `auto` - 🔄 从壁纸自动生成
- 以及各种热门预设主题

### 🖼️ 壁纸管理
- **预设壁纸**: sea, home, maori, pixabay, blue-sky
- **自定义壁纸**: 支持用户指定壁纸路径
- **壁纸验证**: 自动验证壁纸文件存在性

### 🔤 字体配置
- **系统字体包**: 自动安装和管理字体包
- **字体默认值**: 配置系统级默认字体
- **字体缓存**: fontconfig 缓存配置

## 使用方法 🚀

### 基础配置

在系统配置中启用 Stylix：

```nix
{
  mySystem.profiles.stylix = {
    enable = true;
    polarity = "dark";  # 或 "light"
    
    # 壁纸配置
    wallpapers = {
      enable = true;
      preset = "sea";  # 或其他预设：home, maori, pixabay, blue-sky
      # custom = ./path/to/custom/wallpaper.jpg;  # 可选自定义壁纸
    };
    
    # 字体配置
    fonts = {
      enable = true;
      # 使用默认字体设置，或自定义
    };
    
    # 颜色配置
    colors = {
      enable = true;
      scheme = "warm-white";  # 或其他颜色方案
    };
    
    # 目标应用配置（仅系统级组件）
    targets = {
      enable = true;
      
      # 系统启动
      boot = {
        grub.enable = true;  # 启用 GRUB 引导主题
      };
      
      # 系统级桌面环境
      desktop = {
        gtk.enable = true;   # 启用系统级 GTK 主题
      };
      
      # 系统控制台
      console.enable = true; # 启用控制台主题
    };
  };
}
```

### 高级配置

```nix
{
  mySystem.profiles.stylix = {
    enable = true;
    polarity = "light";
    
    # 自定义颜色覆盖
    colors = {
      enable = true;
      scheme = "cool-blue";
      override = {
        base00 = "f8fafc";  # 自定义背景色
        base05 = "1e293b";  # 自定义前景色
      };
    };
    
    # 自定义字体
    fonts = {
      enable = true;
      packages = {
        monospace = pkgs.nerd-fonts.fira-code;
        sansSerif = pkgs.inter;
      };
      names = {
        monospace = "FiraCode Nerd Font Mono";
        sansSerif = "Inter";
      };
      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 11;
        popups = 10;
      };
    };
    
    # 系统目标配置
    targets = {
      enable = true;
      boot.grub.enable = true;
      desktop.gtk.enable = true;
      console.enable = true;
    };
  };
}
```

## 与用户级配置的关系 🤝

- **系统级配置** 提供全局默认值和系统组件主题
- **用户级配置** 可以覆盖系统默认值并添加用户特定的应用主题
- **优先级**: 用户配置 > 系统配置 > Stylix 默认值

## 注意事项 ⚠️

1. **权限要求**: 系统级配置需要管理员权限
2. **重建系统**: 修改系统级配置需要重建 NixOS 系统
3. **兼容性**: 确保启用的目标应用在系统中已安装
4. **性能影响**: 某些系统级主题可能影响启动性能

## 故障排除 🔧

### 常见问题

1. **壁纸不显示**: 检查壁纸文件路径和权限
2. **字体缺失**: 确保字体包正确安装
3. **主题不生效**: 检查目标应用是否启用且已安装
4. **构建错误**: 检查配置语法和依赖项

### 调试技巧

```bash
# 检查 Stylix 配置
nix-instantiate --eval -E '(import <nixpkgs/nixos> {}).config.mySystem.profiles.stylix'

# 重建系统配置
sudo nixos-rebuild switch

# 查看构建日志
sudo nixos-rebuild switch --show-trace
```

## 参考资料 📚

- [Stylix 官方文档](https://stylix.danth.me/)
- [NixOS 配置指南](https://nixos.org/manual/nixos/stable/)
- [Home Manager 文档](https://nix-community.github.io/home-manager/)
