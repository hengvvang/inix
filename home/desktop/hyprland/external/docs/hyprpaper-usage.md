# Hyprpaper 壁纸配置使用指南

## 配置文件
- **位置**: `~/config.d/home/desktop/hyprland/external/hypr/hyprpaper.conf`
- **功能**: 预加载多个壁纸，设置默认壁纸，启用IPC控制

## Waybar 壁纸切换按钮

### 使用方法
- **左键点击**: 切换到下一张壁纸
- **右键点击**: 切换到上一张壁纸  
- **中键点击**: 随机切换壁纸
- **悬停显示**: 当前壁纸信息和操作提示

### 按钮功能
- 自动显示当前壁纸名称和进度
- 支持三种切换模式：顺序下一张、顺序上一张、随机
- 点击后自动更新显示状态
- 桌面通知显示切换结果

## 壁纸脚本

### wallpaper.sh - 统一壁纸控制脚本
```bash
# 下一张壁纸
./wallpaper.sh next

# 上一张壁纸  
./wallpaper.sh prev

# 随机壁纸
./wallpaper.sh random
```

### 特点
- 智能索引管理，记住当前位置
- 支持多种图片格式 (jpg, jpeg, png, webp)
- 随机模式避免选择当前壁纸
- 自动发送桌面通知
- 自动更新waybar显示

## 常用命令

### 手动控制
```bash
# 查看当前壁纸
hyprctl hyprpaper listactive

# 直接设置壁纸
hyprctl hyprpaper reload ",~/Pictures/Wallpapers/your-image.jpg"

# 查看显示器
hyprctl monitors
```

### 在 Hyprland 中设置按键绑定（可选）
```conf
# 快捷键切换壁纸
bind = SUPER, W, exec, ~/config.d/home/desktop/hyprland/external/scripts/wallpaper.sh next
bind = SUPER SHIFT, W, exec, ~/config.d/home/desktop/hyprland/external/scripts/wallpaper.sh prev  
bind = SUPER CTRL, W, exec, ~/config.d/home/desktop/hyprland/external/scripts/wallpaper.sh random
```

## 文件结构
```
hyprland/external/
├── hypr/
│   └── hyprpaper.conf          # 主配置文件
├── scripts/
│   ├── wallpaper.sh            # 壁纸切换脚本
│   └── wallpaper-status.sh     # waybar状态脚本
├── waybar/
│   ├── config                  # waybar配置（包含壁纸按钮）
│   └── style.css              # waybar样式（包含按钮美化）
└── docs/
    └── hyprpaper-usage.md      # 使用文档
```

## 故障排除

### waybar按钮不显示
- 重启waybar: `pkill waybar && waybar &`
- 检查脚本权限: `chmod +x wallpaper*.sh`

### 壁纸不切换
- 检查hyprpaper是否运行: `pgrep hyprpaper`
- 重启hyprpaper: `killall hyprpaper && hyprpaper &`

### 通知不显示
- 确保已安装libnotify: `which notify-send`

## 当前预加载壁纸
根据配置文件，已预加载以下7张壁纸：
1. wallhaven.jpg (默认)
2. bright-blue-sky-with-perfect-clouds...
3. macos-15-sequoia-stock-blue...
4. macos-15-sequoia-stock-orange...
5. pexels-maoriginalphotography.jpg
6. sea.jpg  
7. swirl-loop.jpeg

## 提示
- waybar按钮会自动显示当前壁纸进度（如：第3/7张）
- 支持悬停查看详细信息
- 所有操作都有桌面通知反馈
- 配置完全基于Hyprland官方文档标准
