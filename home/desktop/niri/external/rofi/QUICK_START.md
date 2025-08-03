# Rofi macOS 毛玻璃主题 - 快速开始指南

> 🚀 5 分钟内配置出完美的 macOS 风格 rofi 启动器

## ⚡ 一键应用

### 1. 应用深色毛玻璃主题（推荐）

编辑你的 NixOS 配置文件：

```nix
# 在 programs.rofi 配置中
programs.rofi = {
  enable = true;
  package = pkgs.rofi-wayland;
  theme = ./path/to/macos-glass-dark.rasi;
};
```

### 2. 安装必需字体

```nix
# 在系统配置中添加
fonts.packages = with pkgs; [
  lxgw-wenkai  # LXGW WenKai Mono 字体
];

environment.systemPackages = with pkgs; [
  papirus-icon-theme  # Papirus 图标主题
];
```

### 3. 重建系统

```bash
sudo nixos-rebuild switch
```

### 4. 设置快捷键

在 niri 配置中添加：

```kdl
binds {
    // macOS 风格 Spotlight 快捷键
    Mod+Space { spawn "rofi" "-show" "drun"; }
}
```

## 🎨 主题选择

| 主题文件 | 适用场景 | 特色 |
|----------|----------|------|
| `macos-glass-dark.rasi` | 深色壁纸、夜间使用 | ⭐ 推荐 |
| `macos-glass-light.rasi` | 浅色壁纸、白天使用 | 🌞 明亮 |
| `config.rasi` | 统一配置、支持切换 | 🔄 灵活 |

## 🔧 快速切换主题

### 使用脚本（推荐）

```bash
# 安装主题切换器
cp theme-switcher.sh ~/.local/bin/rofi-theme-switcher
chmod +x ~/.local/bin/rofi-theme-switcher

# 切换到深色主题
rofi-theme-switcher dark

# 切换到浅色主题
rofi-theme-switcher light

# 自动选择（根据时间）
rofi-theme-switcher auto
```

### 手动切换

```bash
# 复制主题文件到 rofi 配置目录
cp macos-glass-dark.rasi ~/.config/rofi/config.rasi
```

## ✅ 验证配置

### 1. 测试启动

```bash
# 测试 rofi 是否正常工作
rofi -show drun

# 检查字体是否正确
fc-list | grep -i "lxgw\|wenkai"
```

### 2. 预期效果

✅ **正确效果**：
- 半透明毛玻璃背景
- LXGW WenKai Mono 字体
- 应用程序图标显示
- 18px 圆角边框
- 蓝色强调色

❌ **常见问题**：
- 不透明背景 → 检查合成器
- 方块字体 → 安装 LXGW WenKai 字体
- 无图标显示 → 安装 Papirus 图标主题

## 🚨 故障排除

### 字体问题
```bash
# 检查字体安装
fc-list | grep -i wenkai

# 如果没有输出，重新安装字体
sudo nixos-rebuild switch
```

### 图标问题
```bash
# 检查图标主题
ls /run/current-system/sw/share/icons/ | grep -i papirus

# 更新图标缓存
gtk-update-icon-cache -f ~/.local/share/icons/
```

### 透明度问题
```bash
# 检查 rofi 版本（需要 Wayland 版本）
rofi -version

# 确保使用正确包
# programs.rofi.package = pkgs.rofi-wayland;
```

## 📱 常用快捷键

| 快捷键 | 功能 |
|--------|------|
| `Super+Space` | 启动应用搜索 |
| `Super+Tab` | 窗口切换 |
| `Super+R` | 运行命令 |
| `Enter` | 启动选中项 |
| `Escape` | 取消 |
| `↑/↓` | 上下选择 |

## 🎯 下一步

- 📖 阅读 [完整文档](./README.md) 了解详细配置
- 🎨 查看 [自定义指南](./README.md#自定义配置) 个性化主题
- 🔧 使用 [主题切换器](./theme-switcher.sh) 动态切换
- ⚙️ 探索 [高级用法](./README.md#高级用法) 扩展功能

## 💡 专业提示

1. **毛玻璃效果最佳实践**：选择有对比度的壁纸
2. **性能优化**：如果感觉慢，减少 `lines` 数量
3. **主题切换**：配置 `rofi-theme-switcher auto` 定时任务
4. **键盘友好**：熟练使用 `Ctrl+P/N` 快速导航

---

🎉 **恭喜！你现在拥有了最美观的 macOS 风格 rofi 启动器！**

*如有问题，请查看 [README.md](./README.md) 或 [故障排除部分](./README.md#故障排除)*