# Ironbar 配置说明

## 概述

已将状态栏从 Waybar 切换到 Ironbar。Ironbar 是一个用 Rust 编写的轻量化、高性能状态栏，专为 Wayland 合成器设计。

## 主要变更

### 1. 替换的文件
- `./waybar` → `./ironbar` (模块导入)
- `waybar` → `ironbar` (软件包)
- `exec-once = waybar` → `exec-once = ironbar` (Hyprland 启动)
- 主题配置中的层规则也相应更新

### 2. 配置文件结构
```
ironbar/
├── default.nix      # Nix 配置模块
├── config.toml      # Ironbar 主配置
├── style.css        # CSS 样式文件
└── README.md        # 本说明文件
```

## 功能对比

### 保持的功能
- ✅ 工作区显示与切换
- ✅ 窗口标题显示
- ✅ 时钟模块
- ✅ 系统托盘
- ✅ 音量控制
- ✅ 网络状态
- ✅ CPU/内存监控
- ✅ 温度监控
- ✅ 电池状态
- ✅ 亮度控制
- ✅ 自定义壁纸切换按钮
- ✅ macOS 风格透明玻璃效果

### 优势
- 🚀 **性能更好**: Rust 编写，内存占用更低
- ⚡ **启动更快**: 冷启动时间显著减少
- 🎛️ **配置更灵活**: TOML 格式配置更直观
- 🔧 **热重载**: 支持配置文件热重载
- 📊 **更好的模块系统**: 模块化设计更清晰

## 配置说明

### config.toml
主配置文件使用 TOML 格式，比 JSON 更人性化：

```toml
[bar.main]
position = "top"
height = 17
margin.top = 8

# 模块布局
start = ["workspaces", "focused"]
center = ["clock"]
end = ["custom.wallpaper", "volume", "network", ...]
```

### style.css
样式文件与原 Waybar 样式保持一致：
- macOS 风格透明玻璃效果
- 圆角设计
- 毛玻璃模糊效果
- 动画过渡效果

## 使用方法

### 启动
Ironbar 会在 Hyprland 启动时自动启动，无需手动干预。

### 热重载配置
```bash
# 重载 Ironbar 配置
killall ironbar && ironbar &

# 或者使用 Hyprland 重载
hyprctl reload
```

### 自定义模块
在 `config.toml` 中可以轻松添加新模块：

```toml
[module.custom.my_module]
type = "custom"
exec = "your-command"
interval = 5
```

## 故障排除

### 常见问题

1. **Ironbar 未启动**
   ```bash
   # 检查是否安装
   which ironbar
   
   # 手动启动
   ironbar &
   ```

2. **样式未生效**
   ```bash
   # 检查配置文件路径
   ls ~/.config/ironbar/
   
   # 重载配置
   killall ironbar && ironbar &
   ```

3. **模块不显示**
   - 检查 `config.toml` 中的模块配置
   - 确认依赖程序已安装 (如 `brightnessctl`, `pamixer` 等)

### 调试模式
```bash
# 以调试模式启动
RUST_LOG=debug ironbar
```

## 迁移完成

现在您的 Hyprland 桌面已成功切换到 Ironbar！所有原有功能都已保留，并且性能会有显著提升。

如需恢复 Waybar，可以将 `./ironbar` 改回 `./waybar`，并相应恢复其他配置即可。
