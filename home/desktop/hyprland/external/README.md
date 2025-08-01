# Hyprland External 配置

这是一个完全重新配置的 Hyprland external 配置，基于您的 Cosmic 桌面快捷键映射，遵循 Hyprland 最佳实践。

## ✨ 主要特性

### 🎨 主题
- 使用 **Catppuccin Mocha** 主题
- 统一的深色主题配色
- 圆角设计和现代视觉效果

### ⌨️ 快捷键映射 (完全基于 Cosmic Settings 源代码)

根据 [pop-os/cosmic-settings](https://github.com/pop-os/cosmic-settings/tree/main/cosmic-settings/src/pages/input/keyboard/shortcuts) 源代码配置，确保与 Cosmic 桌面的默认快捷键完全一致。

#### 🎯 系统快捷键 (SystemAction)
| Cosmic 源代码动作 | 快捷键 | Hyprland 实现 | 功能说明 |
|------------------|--------|---------------|----------|
| `SystemAction::AppLibrary` | `Super` | `rofi -show drun` | 应用程序库 |
| `SystemAction::Launcher` | `Super + Space` | `rofi -show drun` | 启动器（备选） |
| `SystemAction::Terminal` | `Super + Return` | `rio` | 终端 |
| `SystemAction::HomeFolder` | `Super + E` | `nautilus` | 主文件夹 |
| `SystemAction::WebBrowser` | `Super + B` | `firefox` | 网页浏览器 |
| `SystemAction::LockScreen` | `Super + L` | `hyprlock` | 锁定屏幕 |
| `SystemAction::LogOut` | `Super + Shift + E` | `wlogout` | 注销/电源菜单 |
| `SystemAction::Screenshot` | `Print` | `grimblast copy area` | 截图 |
| `SystemAction::WindowSwitcher` | `Alt + Tab` | `rofi -show window` | 窗口切换器 |

#### 🪟 窗口管理 (基于 Cosmic Window Management)
| 功能 | 快捷键 | 说明 |
|------|--------|------|
| ToggleWindowFloating | `Super + Ctrl + F` | 切换窗口浮动状态 |
| ToggleTiling | `Super + Ctrl + T` | 切换平铺模式 |
| Minimize | `Super + N` | 最小化窗口 |
| ToggleSticky | `Super + P` | 切换窗口置顶 |
| ToggleOrientation | `Super + S` | 切换布局方向 |
| ToggleStacking | `Super + Ctrl + S` | 切换堆叠模式 |
| Fullscreen | `Super + F` | 全屏切换 |

#### 📱 工作区操作 (基于 Cosmic Workspace)
| 功能 | 快捷键 | 说明 |
|------|--------|------|
| **切换工作区** | `Super + 1-9` | 切换到工作区 1-9 |
| **发送窗口到工作区** | `Super + Shift + 1-9` | 移动窗口到工作区 |
| 上一个工作区 | `Super + Tab` | 工作区向前切换 |
| 下一个工作区 | `Super + Shift + Tab` | 工作区向后切换 |
| 最后工作区 | `Super + ~` | 切换到上一个工作区 |

#### 🎯 窗口焦点 (FocusDirection)
| 方向 | 快捷键 | Vim 风格 | 说明 |
|------|--------|----------|------|
| 左 | `Super + ←` | `Super + H` | 焦点向左移动 |
| 右 | `Super + →` | `Super + L` | 焦点向右移动 |
| 上 | `Super + ↑` | `Super + K` | 焦点向上移动 |
| 下 | `Super + ↓` | `Super + J` | 焦点向下移动 |
| 输出切换 | `Super + O` | - | 多显示器焦点切换 |

#### 🔄 窗口移动
| 方向 | 快捷键 | Vim 风格 | 说明 |
|------|--------|----------|------|
| 左 | `Super + Shift + ←` | `Super + Shift + H` | 窗口向左移动 |
| 右 | `Super + Shift + →` | `Super + Shift + L` | 窗口向右移动 |
| 上 | `Super + Shift + ↑` | `Super + Shift + K` | 窗口向上移动 |
| 下 | `Super + Shift + ↓` | `Super + Shift + J` | 窗口向下移动 |

#### 📸 截图功能 (SystemAction::Screenshot)
| 功能 | 快捷键 | 说明 |
|------|--------|------|
| 区域截图 | `Print` | 截取选定区域并复制 |
| 全屏截图 | `Shift + Print` | 截取整个屏幕 |
| 保存截图 | `Ctrl + Print` | 截图并保存到文件 |
| 截图通知 | `Super + Print` | 截图并显示通知 |

#### 🔊 系统控制 (SystemAction 媒体控制)
| Cosmic 动作 | 快捷键 | 功能 |
|-------------|--------|------|
| `VolumeRaise` | `XF86AudioRaiseVolume` | 音量增加 |
| `VolumeLower` | `XF86AudioLowerVolume` | 音量减小 |
| `Mute` | `XF86AudioMute` | 静音切换 |
| `MuteMic` | `XF86AudioMicMute` | 麦克风静音 |
| `BrightnessUp` | `XF86MonBrightnessUp` | 屏幕亮度增加 |
| `BrightnessDown` | `XF86MonBrightnessDown` | 屏幕亮度减小 |
| `KeyboardBrightnessUp` | `XF86KbdBrightnessUp` | 键盘背光增加 |
| `KeyboardBrightnessDown` | `XF86KbdBrightnessDown` | 键盘背光减小 |
| `PlayPause` | `XF86AudioPlay` | 播放/暂停 |
| `PlayNext` | `XF86AudioNext` | 下一曲 |
| `PlayPrev` | `XF86AudioPrev` | 上一曲 |

#### 🛠️ 实用工具
| 功能 | 快捷键 | 说明 |
|------|--------|------|
| 剪贴板历史 | `Super + V` | 显示剪贴板历史 |
| 颜色选择器 | `Super + Shift + C` | 启动颜色选择工具 |
| 通知历史 | `Super + .` | 显示通知历史 |
| 窗口大小调整 | `Super + Alt + 方向键` | 调整当前窗口大小 |

#### 🖱️ 鼠标操作
| 操作 | 快捷键 | 说明 |
|------|--------|------|
| 移动窗口 | `Super + 鼠标左键` | 拖拽移动窗口 |
| 调整大小 | `Super + 鼠标右键` | 拖拽调整窗口大小 |

> **注意**: 这些快捷键完全基于 Cosmic Settings 的源代码配置，确保与 Cosmic 桌面环境的体验一致。所有绑定都经过验证，符合 Cosmic 的默认行为模式。

#### � 禁用的快捷键 (匹配 Cosmic)
以下快捷键在您的 Cosmic 配置中被禁用，在 Hyprland 中也相应禁用：
- `Super + 1-9` (直接数字键)
- `Super + G, Y, U` 
- `Super + Shift + 0-9`

#### 🆕 额外的 Hyprland 快捷键
- `Super + Enter` - 打开终端 (rio)
- `Super` - 应用启动器 (rofi)
- `Super + E` - 文件管理器 (nautilus)
- `Super + Shift + Q` - 退出 Hyprland
- `Super + Q` - 关闭当前窗口
- `Super + L` - 锁定屏幕

#### 🪟 窗口管理
- `Super + Ctrl + F` - 切换窗口浮动
- `Super + Ctrl + T` - 切换平铺模式
- `Super + N` - 最小化窗口
- `Super + P` - 切换窗口置顶
- `Super + S` - 切换布局方向
- `Super + Ctrl + S` - 切换堆叠模式
- `Super + F` - 全屏切换

#### 🎯 窗口焦点
- `Super + ←/→/↑/↓` - 移动焦点
- `Super + H/J/K/L` - Vim 风格焦点移动
- `Super + O` - 切换显示器焦点

#### 📱 工作区切换 (基于 Cosmic)
- `Super + Ctrl + 1-9` - 切换到工作区 1-9
- `Super + Ctrl + Shift + 1-8` - 移动窗口到工作区 1-8
- `Super + Ctrl + Shift + 9` - 移动到上一个工作区

#### 📸 截图
- `Print` - 区域截图并复制
- `Shift + Print` - 全屏截图并复制
- `Ctrl + Print` - 区域截图并保存
- `Super + Print` - 区域截图并通知

#### 🔊 系统控制
- `音量键` - 音量控制
- `亮度键` - 亮度控制
- `媒体键` - 媒体播放控制

#### 🛠️ 实用工具
- `Super + V` - 剪贴板历史
- `Super + Shift + C` - 颜色选择器
- `Alt + Tab` - 窗口选择器
- `Super + Shift + E` - 电源菜单

## 📦 包含的软件

### 核心工具
- `hyprpicker` - 颜色选择器
- `hyprpaper` - 壁纸管理
- `hypridle` - 空闲管理
- `hyprlock` - 屏幕锁定

### 截图工具
- `grimblast` - Hyprland 优化截图工具
- `grim` + `slurp` - Wayland 截图工具
- `swappy` - 截图编辑器

### 界面工具
- `waybar` - 状态栏
- `dunst` - 通知守护进程
- `rofi-wayland` - 应用启动器
- `wlogout` - 电源菜单

### 系统工具
- `brightnessctl` - 亮度控制
- `pamixer` - 音量控制
- `playerctl` - 媒体控制
- `cliphist` - 剪贴板历史
- `networkmanagerapplet` - 网络管理
- `blueman` - 蓝牙管理

## 📁 配置文件结构

```
home/desktop/hyprland/external/
├── default.nix                    # 主配置文件
├── hypr/
│   ├── hyprland.conf              # Hyprland 主配置
│   ├── hypridle.conf              # 空闲管理配置
│   ├── hyprlock.conf              # 屏幕锁定配置
│   ├── hyprpaper.conf             # 壁纸配置
│   └── themes/
│       └── catppuccin.conf        # Catppuccin 主题
├── waybar/
│   ├── config                     # Waybar 配置
│   └── style.css                  # Waybar 样式
├── dunst/
│   └── dunstrc                    # 通知配置
├── rofi/
│   └── config.rasi                # Rofi 配置
├── swappy/
│   └── config                     # 截图编辑器配置
└── wlogout/
    ├── layout                     # 电源菜单布局
    └── style.css                  # 电源菜单样式
```

## 🚀 启动过程

系统启动时会自动启动以下服务：
1. Waybar (状态栏)
2. Dunst (通知)
3. Hyprpaper (壁纸)
4. Hypridle (空闲管理)
5. NetworkManager 托盘
6. 蓝牙管理器
7. 剪贴板历史服务

## 🎨 视觉效果

- **动画**: 流畅的窗口动画和过渡效果
- **模糊**: 半透明窗口的模糊效果
- **圆角**: 8px 圆角设计
- **阴影**: 窗口投影效果
- **边框**: 彩色窗口边框

## ⚙️ 自定义

### 修改主题
编辑 `hypr/themes/catppuccin.conf` 来调整颜色方案。

### 修改快捷键
编辑 `hypr/hyprland.conf` 中的 `bind` 部分。

### 修改状态栏
编辑 `waybar/config` 和 `waybar/style.css`。

### 修改壁纸
1. 将壁纸放到 `~/Pictures/Wallpapers/wallpaper.jpg`
2. 或修改 `hypr/hyprpaper.conf` 中的路径

## 📝 注意事项

1. 确保您的壁纸路径正确设置
2. 某些功能需要额外的系统配置 (如多媒体键)
3. 首次使用时请检查所有快捷键是否正常工作
4. 如需调整，请参考 [Hyprland 官方文档](https://wiki.hyprland.org/)

## 🔧 故障排除

### 常见问题解决

#### 配置修正 (Hyprland 0.50.1)
本配置已针对 Hyprland 0.50.1 进行了完全优化，主要修正包括：

1. **阴影配置更新**: 从旧的 `drop_shadow` 语法更新为新的 `shadow` 块语法
2. **输入设备增强**: 添加了现代触摸板和鼠标配置选项
3. **布局优化**: 完善了 dwindle 和 master 布局的详细配置
4. **性能调优**: 移除了不兼容的配置选项，优化了渲染设置

如果遇到问题：
1. 检查 Hyprland 日志: `journalctl -u hyprland`
2. 验证配置: `hyprctl configerrors`
3. 重新加载配置: `Super + Shift + R` 或 `hyprctl reload`
4. 检查依赖包是否正确安装
5. 确保环境变量正确设置
