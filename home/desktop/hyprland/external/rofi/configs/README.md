# Rofi macOS Tathoe 毛玻璃主题

这个配置提供了两个 macOS Tathoe 风格的毛玻璃主题：

## 主题选项

### 1. macos-tathoe.rasi
基础的 macOS Tathoe 毛玻璃风格，适合大多数用户使用。

### 2. macos-tathoe-enhanced.rasi  
增强版本，包含更多的视觉效果和动画，适合追求更精致体验的用户。

## 切换主题

要切换主题，请编辑 `config.rasi` 文件中的主题导入行：

```rasi
/* 使用基础主题 */
@theme "macos-tathoe";

/* 或使用增强主题 */
@theme "macos-tathoe-enhanced";
```

## 特性

- ✨ macOS Tathoe 配色方案
- 🪟 毛玻璃半透明效果
- 🎨 LXGW WenKai Mono 字体
- 📱 现代化圆角设计
- 🔵 macOS 风格的蓝色强调色
- 🎯 流畅的悬停和选中效果

## 依赖

- rofi-wayland
- LXGW WenKai Mono 字体
- Papirus 图标主题（可选，用于应用图标）

## 使用建议

为了获得最佳的毛玻璃效果，建议在支持透明背景的合成器上使用，如：
- Hyprland
- Sway
- KWin (Wayland)

## 自定义

您可以通过修改主题文件中的颜色变量来自定义外观：

```rasi
* {
    bg0: rgba(22, 22, 22, 0.85);    /* 主背景透明度 */
    accent: rgba(10, 132, 255, 0.95); /* 强调色 */
    /* ... 其他颜色变量 */
}
```
