# Stylix 配置完成 🎨

## ✅ 已完成的配置

### 1. **Flake 配置**
- 在 `flake.nix` 中添加了 Stylix 输入
- 配置了 `commonHomeModules` 统一管理
- 所有用户配置都会自动获得 Stylix 支持

### 2. **主题结构**
```
home/profiles/theme/
├── default.nix      # 主题入口，根据主机选择壁纸
├── stylix.nix       # 应用程序目标配置
├── fonts.nix        # 字体配置
├── colors.nix       # 颜色方案配置
└── wallpapers/      # 壁纸目录
    └── sea.jpg      # 当前使用的壁纸
```

### 3. **已启用的应用程序**
- ✅ Kitty 终端
- ✅ Tmux
- ✅ Vim
- ✅ Neovim
- ✅ GTK
- ✅ Firefox
- ❌ Alacritty (暂时禁用避免冲突)

### 4. **字体配置**
- **等宽字体**: JetBrainsMono Nerd Font
- **无衬线字体**: Noto Sans
- **衬线字体**: Noto Serif
- **表情符号**: Noto Color Emoji

## 🎯 如何使用

### **添加新壁纸**
1. 将壁纸文件放入 `home/profiles/theme/wallpapers/`
2. 在 `default.nix` 中更新路径
3. 重新构建: `home-manager switch --flake '.#hengvvang@laptop'`

### **启用更多应用程序**
编辑 `home/profiles/theme/stylix.nix`，取消注释或添加：
```nix
targets = {
  rofi.enable = true;
  dunst.enable = true;
  waybar.enable = true;
  # 等等...
};
```

### **解决 Alacritty 冲突**
如果要启用 Alacritty 主题，需要在你的 Alacritty 配置中使用 `lib.mkDefault`：
```nix
programs.alacritty.settings.colors.bright.black = lib.mkDefault "#414868";
```

### **自定义颜色**
编辑 `home/profiles/theme/colors.nix` 取消注释并设置自定义颜色。

## 🔄 应用配置
```bash
# 应用配置
home-manager switch --flake '.#hengvvang@laptop'

# 查看新闻
home-manager news
```

## 🎨 主题效果
- 📸 壁纸自动颜色提取
- 🎯 统一的终端、编辑器、浏览器主题  
- 🔤 一致的字体配置
- 🎪 透明度效果支持

配置已成功应用！享受你的统一主题体验吧！
