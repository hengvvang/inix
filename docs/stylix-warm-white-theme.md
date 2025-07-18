# 🤍 Stylix 简约白色暖色调主题

## 📋 主题概览

你已经成功配置了一个优雅的简约白色暖色调主题！这个主题专为现代开发环境设计，提供舒适的视觉体验。

## 🎨 颜色方案 (Base16)

### 基础颜色 (Background & Foreground)
```
base00: #fefefe  # 背景 - 纯净白色
base01: #f5f5f5  # 较深背景 - 浅灰白
base02: #e8e8e8  # 选择背景 - 中灰白  
base03: #d0d0d0  # 注释 - 柔和灰色
base04: #868686  # 暗前景 - 中等灰色
base05: #444444  # 默认前景 - 深灰色 (主要文本)
base06: #2a2a2a  # 亮前景 - 更深灰色
base07: #1a1a1a  # 最亮前景 - 近黑色
```

### 暖色调强调色
```
base08: #d73027  # 红色 - 温暖的错误红 🔴
base09: #e67e22  # 橙色 - 暖橙色 🟠  
base0A: #f39c12  # 黄色 - 暖黄色 🟡
base0B: #27ae60  # 绿色 - 柔和绿色 🟢
base0C: #16a085  # 青色 - 暖青色 🔵
base0D: #3498db  # 蓝色 - 柔和蓝色 💙
base0E: #8e44ad  # 紫色 - 优雅紫色 💜
base0F: #e74c3c  # 棕色 - 暖棕红色 🟤
```

## ✅ 已启用的应用主题

### 🖥️ 终端
- ✅ **Kitty** - 备用终端主题
- ❌ **Alacritty** - 禁用 (使用 Ghostty)

### ✏️ 编辑器  
- ✅ **Vim** - 传统编辑器主题
- ✅ **Neovim** - 现代编辑器主题

### 🛠️ 开发工具
- ✅ **Tmux** - 终端复用器主题  
- ✅ **Bat** - 代码高亮工具主题
- ✅ **Fzf** - 模糊搜索工具主题

### 🖼️ 桌面环境
- ✅ **GTK** - 系统界面主题统一

### 🌐 浏览器
- ✅ **Firefox** - 浏览器主题

### ⌨️ 输入法
- ✅ **Fcitx5** - 中文输入法主题

## 🔧 配置特点

### 💡 亮色模式优化
- **极性**: `light` - 专为白天使用优化
- **背景**: 纯白色 (`#fefefe`) - 减少眼部疲劳
- **禁用壁纸**: 使用纯色背景，保持简洁

### 🔤 优质字体配置
- **等宽字体**: JetBrainsMono Nerd Font Mono (14pt)
- **无衬线字体**: Noto Sans (12pt)  
- **衬线字体**: Noto Serif (12pt)
- **表情字体**: Noto Color Emoji (12pt)

### 🎯 应用覆盖
所有配置的开发工具和应用程序都将应用这个统一的简约白色暖色调主题。

## 🚀 激活主题

要激活新的主题配置，运行：

```bash
# 方法一：直接激活
./result/activate

# 方法二：Home Manager 切换
home-manager switch --flake .#hengvvang@laptop
```

## 🔄 切换其他主题

如果想要切换到其他预设主题，可以修改 `laptop.nix` 中的 `scheme` 选项：

```nix
colors = {
  enable = true;
  scheme = "catppuccin-latte";  # 其他可选主题
};
```

### 🎨 可用主题选项
- `warm-white` - 当前的简约白色暖色调 (推荐)
- `catppuccin-latte` - Catppuccin 亮色主题
- `solarized-light` - Solarized 亮色主题  
- `one-light` - One Light 主题
- `gruvbox-light` - Gruvbox 亮色主题
- `auto` - 从壁纸自动生成颜色

## 💡 提示

这个简约白色暖色调主题特别适合：
- 📝 长时间编程和文档编写
- 🌞 白天工作环境
- 👁️ 减少眼部疲劳
- 🎨 需要清晰颜色对比的设计工作
