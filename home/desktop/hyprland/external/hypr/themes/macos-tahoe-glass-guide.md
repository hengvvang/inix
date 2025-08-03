# macOS Tahoe 流体玻璃主题使用指南

## 🎨 主题概述

这个主题旨在重现 macOS Tahoe 的流体玻璃效果，具有以下特点：

### ✨ 主要特性

1. **流体玻璃效果**
   - 高质量背景模糊（16px，3 passes）
   - 动态透明度控制
   - 增强的活力和对比度调节

2. **macOS 风格设计**
   - 12px 圆角窗口
   - 优雅的阴影效果
   - 蓝色玻璃主色调

3. **流畅动画**
   - macOS 风格的贝塞尔曲线
   - 平滑的窗口过渡
   - 流体般的工作区切换

4. **智能透明度**
   - 活动窗口：95% 不透明度
   - 非活动窗口：85% 不透明度
   - 浮动窗口：特殊玻璃效果

## 🎯 颜色方案

```
主色调：
- 玻璃蓝色：#007AFF (半透明)
- 玻璃白色：#FFFFFF (半透明)
- 玻璃灰色：#8E8E93 (半透明)

系统色彩：
- 强调蓝色：#007AFF
- 强调紫色：#AF52DE
- 主文本：#FFFFFF
- 次要文本：#8E8E93
```

## 🖼️ 窗口效果

### 不同应用的特殊效果

- **终端应用** (kitty, alacritty, foot)：85%/75% 透明度，增强玻璃感
- **文件管理器** (thunar, nautilus, dolphin)：90%/85% 透明度
- **应用启动器** (rofi, wofi)：85%/80% 透明度，16px 圆角
- **VSCode**：95%/90% 透明度，保持代码清晰度
- **浏览器**：100%/95% 透明度，确保内容可读性
- **媒体播放器**：90%/85% 透明度

### 浮动窗口增强

- 90%/80% 透明度
- 16px 圆角（比平铺窗口更圆）
- 蓝色边框高亮

## 🎮 手势和交互

### macOS 风格手势

- **三指滑动**：工作区切换
- **自然滚动**：启用
- **轻触点击**：启用
- **拖拽锁定**：禁用（macOS 风格）

### 窗口管理

- **边框调整**：启用，10px 抓取区域
- **悬停图标**：启用
- **智能分割**：Dwindle 布局

## 🔧 配置位置

主题文件位置：
```
~/.config/hypr/themes/macos-tahoe-glass.conf
```

主配置文件：
```
~/.config/hypr/hyprland.conf
```

## 📊 性能优化

### 模糊优化
- 启用新优化算法
- X-ray 模式用于浮动窗口
- 智能透明度忽略

### 硬件要求
- **推荐**：独立显卡 (NVIDIA/AMD)
- **最低**：集成显卡（可能需要降低模糊质量）

### 性能调优

如果遇到性能问题，可以调整以下参数：

```conf
# 在主题文件中修改这些值
blur {
    size = 12        # 降低到 8-12
    passes = 2       # 降低到 1-2
    vibrancy = 0.2   # 降低到 0.1-0.2
}
```

## 🎨 自定义配置

### 更改主色调

在主题文件中修改颜色变量：

```conf
# 将蓝色主题改为其他颜色
$glass_blue = 0x4d007AFF      # 蓝色（默认）
$glass_blue = 0x4dFF3B30      # 红色
$glass_blue = 0x4d30D158      # 绿色
$glass_blue = 0x4dFF9500      # 橙色
```

### 调整透明度

```conf
# 在 decoration 块中
active_opacity = 0.95         # 活动窗口透明度
inactive_opacity = 0.85       # 非活动窗口透明度
```

### 修改圆角

```conf
# 在 decoration 块中
rounding = 12                 # 窗口圆角半径
rounding_power = 2.5         # 圆角平滑度
```

## 🔄 主题切换

### 切换回原主题

编辑 `hyprland.conf`，将第6行改为：
```conf
source = ~/.config/hypr/themes/catppuccin.conf
```

### 临时禁用玻璃效果

```bash
# 临时禁用模糊
hyprctl keyword decoration:blur:enabled false

# 重新启用
hyprctl keyword decoration:blur:enabled true
```

## 🐛 故障排除

### 常见问题

1. **窗口过于透明看不清**
   - 增加 `active_opacity` 和 `inactive_opacity` 值

2. **性能问题/卡顿**
   - 降低 `blur.size` 和 `blur.passes`
   - 禁用 `blur.xray`

3. **特定应用显示异常**
   - 添加自定义窗口规则
   - 调整应用特定的透明度

4. **边框颜色不显示**
   - 检查 `border_size` 是否大于 0
   - 确认颜色格式正确

### 重新加载配置

```bash
# 重新加载 Hyprland 配置
hyprctl reload

# 或者重启 Hyprland
hyprctl dispatch exit
```

## 📝 技术细节

### 模糊算法
- 使用 Kawase 模糊算法
- 三次模糊传递确保平滑效果
- 动态优化减少 GPU 负载

### 动画曲线
- 使用自定义贝塞尔曲线模拟 macOS
- 不同元素使用不同的动画速度
- 边框动画使用线性插值

### 层规则
- Waybar：模糊 + 透明度忽略
- Rofi：模糊 + 环绕调暗
- 通知：模糊处理
- 锁屏：全屏模糊

---

## 💡 提示

- 使用深色壁纸能更好地展现玻璃效果
- 建议配合半透明的状态栏使用
- 某些老旧应用可能不支持透明度
- 在低配置设备上建议降低模糊强度

享受您的 macOS Tahoe 流体玻璃体验！ 🎉
