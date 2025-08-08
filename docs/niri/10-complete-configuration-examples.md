# Niri 完整配置示例

本文档提供niri的完整配置示例，涵盖所有主要配置段落，适用于不同使用场景。

## 目录

- [标准桌面配置](#标准桌面配置)
- [高性能配置](#高性能配置)
- [多媒体工作站配置](#多媒体工作站配置)
- [开发环境配置](#开发环境配置)
- [游戏优化配置](#游戏优化配置)
- [最小化配置](#最小化配置)
- [可访问性配置](#可访问性配置)

---

## 标准桌面配置

适用于大多数日常桌面使用场景的完整配置：

```kdl
// 标准桌面 niri 配置
// 适用于: 日常办公、上网、轻度多媒体使用

// ========== 环境变量 ==========
environment {
    // Wayland 基础设置
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"
    XDG_CURRENT_DESKTOP "niri"

    // 应用程序 Wayland 支持
    QT_QPA_PLATFORM "wayland;xcb"
    QT_QPA_PLATFORMTHEME "gtk3"
    GDK_BACKEND "wayland,x11"
    MOZ_ENABLE_WAYLAND "1"
    ELECTRON_OZONE_PLATFORM_HINT "wayland"

    // 中文环境
    LANG "zh_CN.UTF-8"
    LC_ALL "zh_CN.UTF-8"

    // 输入法 (Fcitx)
    GTK_IM_MODULE "fcitx"
    QT_IM_MODULE "fcitx"
    XMODIFIERS "@im=fcitx"

    // 主题设置
    GTK_THEME "Adwaita"
    XCURSOR_THEME "Adwaita"
    XCURSOR_SIZE "24"
}

// ========== 输入设备 ==========
input {
    // 键盘配置
    keyboard {
        xkb {
            layout "us"
            options "caps:escape"        // Caps Lock 作为 Escape
        }
        repeat-delay 500
        repeat-rate 25
        track-layout "global"
    }

    // 触摸板配置
    touchpad {
        tap true                         // 轻触点击
        dwt true                         // 打字时禁用
        natural-scroll true              // 自然滚动
        accel-speed 0.2
        accel-profile "adaptive"

        scroll-method "two-finger"
        click-method "button-areas"
    }

    // 鼠标配置
    mouse {
        accel-speed 0.0                  // 无鼠标加速
        accel-profile "flat"
        natural-scroll false
        scroll-method "on-button-down"
    }

    // 全局输入设置
    focus-follows-mouse max-scroll-amount="0%"
    workspace-auto-back-and-forth true
}

// ========== 输出显示器 ==========
// 笔记本内屏
output "eDP-1" {
    mode "1920x1080@60.000"
    scale 1.25                           // 适合高DPI
    position x=0 y=0
    focus-at-startup
    background-color "#2e3440"
}

// 外接显示器 (如果有)
output "HDMI-A-1" {
    mode "1920x1080@60.000"
    scale 1.0
    position x=1536 y=0                  // 1920/1.25 = 1536
    variable-refresh-rate on-demand=true
}

// ========== 布局配置 ==========
layout {
    gaps 16
    center-focused-column "on-overflow"

    // 预设列宽
    preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        fixed 400
    }

    default-column-width { proportion 0.5 }

    // 聚焦环
    focus-ring {
        width 4
        active-color "#7fc8ff"
        inactive-color "#505050"
    }

    // 窗口边框
    border {
        width 2
        active-color "#ffc87f"
        inactive-color "#505050"
    }

    // 悬浮窗口
    floating-window {
        border {
            width 3
            active-color "#ff6b6b"
        }
    }

    background-color "#1e1e2e"
}

// ========== 键盘绑定 ==========
binds {
    // === 应用启动 ===
    Mod+Return { spawn "alacritty"; }
    Mod+E { spawn "nautilus"; }
    Mod+W { spawn "firefox"; }
    Mod+D { spawn "rofi" "-show" "drun"; }
    Mod+Shift+D { spawn "rofi" "-show" "run"; }
    Mod+V { spawn "cliphist" "list" "|" "rofi" "-dmenu" "|" "cliphist" "decode" "|" "wl-copy"; }

    // === 窗口操作 ===
    Mod+Q { close-window; }
    Mod+Shift+Q { quit; }

    // 聚焦
    Mod+H { focus-column-left; }
    Mod+L { focus-column-right; }
    Mod+J { focus-window-down; }
    Mod+K { focus-window-up; }

    // 移动
    Mod+Shift+H { move-column-left; }
    Mod+Shift+L { move-column-right; }
    Mod+Shift+J { move-window-down; }
    Mod+Shift+K { move-window-up; }

    // 大小调整
    Mod+R { switch-preset-column-width; }
    Mod+Shift+R { reset-window-height; }
    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }

    // === 工作区 ===
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }

    Mod+Shift+1 { move-to-workspace 1; }
    Mod+Shift+2 { move-to-workspace 2; }
    Mod+Shift+3 { move-to-workspace 3; }
    Mod+Shift+4 { move-to-workspace 4; }
    Mod+Shift+5 { move-to-workspace 5; }

    Mod+Page_Down { focus-workspace-down; }
    Mod+Page_Up { focus-workspace-up; }

    // === 模式切换 ===
    Mod+Tab { overview-toggle; }
    Mod+F { fullscreen-window; }
    Mod+Shift+Space { toggle-window-floating; }

    // === 屏幕截图 ===
    Print { spawn "grimshot" "copy" "area"; }
    Mod+Print { spawn "grimshot" "copy" "screen"; }
    Shift+Print { spawn "grimshot" "save" "area"; }

    // === 音频控制 ===
    XF86AudioRaiseVolume { spawn "amixer" "set" "Master" "5%+"; }
    XF86AudioLowerVolume { spawn "amixer" "set" "Master" "5%-"; }
    XF86AudioMute { spawn "amixer" "set" "Master" "toggle"; }
    XF86AudioPlay { spawn "playerctl" "play-pause"; }
    XF86AudioNext { spawn "playerctl" "next"; }
    XF86AudioPrev { spawn "playerctl" "previous"; }

    // === 系统控制 ===
    Mod+Escape { spawn "swaylock"; }
    Mod+Shift+E { spawn "systemctl" "poweroff"; }
    Mod+Shift+R { spawn "systemctl" "reboot"; }
    Mod+Shift+C { reload-config; }

    // === 亮度控制 ===
    XF86MonBrightnessUp { spawn "brightnessctl" "set" "10%+"; }
    XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }
}

// ========== 窗口规则 ==========
// 浏览器
window-rule {
    match app-id="firefox|chromium"
    default-column-width { proportion 0.75 }
}

// 文件管理器
window-rule {
    match app-id="nautilus|thunar"
    default-column-width { proportion 0.6 }
    min-width 600
}

// 终端
window-rule {
    match app-id="alacritty|gnome-terminal"
    default-column-width { proportion 0.4 }
}

// 系统设置
window-rule {
    match app-id="gnome-control-center" title=".*设置.*|.*Settings.*"
    open-floating true
    open-centered true
    min-width 800
    min-height 600
}

// 画中画
window-rule {
    match title="Picture-in-Picture|画中画"
    open-floating true
    min-width 320
    min-height 240
}

// 对话框
window-rule {
    match title=".*[Dd]ialog.*|.*对话框.*"
    open-floating true
    open-centered true
}

// ========== 动画配置 ==========
animations {
    window-open {
        duration-ms 150
        curve "ease-out-cubic"
        scale-from 0.8
        opacity-from 0.0
    }

    window-close {
        duration-ms 150
        curve "ease-in-cubic"
        scale-to 0.8
        opacity-to 0.0
    }

    workspace-switch {
        duration-ms 200
        curve "ease-out-cubic"
    }

    window-movement {
        duration-ms 150
        curve "ease-out-cubic"
    }

    focus-change {
        duration-ms 100
        curve "ease-out-cubic"
    }
}

// ========== 光标配置 ==========
cursor {
    xcursor-theme "Adwaita"
    xcursor-size 24
    hide-after-inactivity-ms 3000
    hide-when-typing true
}

// ========== 调试配置 ==========
debug {
    // 基础调试 (生产环境建议关闭)
    log-level "warn"
    damage-tracking true
    wait-for-frame-completion-before-queueing-next false
}
```

---

## 高性能配置

针对低端硬件或追求最高性能的配置：

```kdl
// 高性能 niri 配置
// 适用于: 低端硬件、电池节能、最大性能需求

environment {
    // 基础 Wayland
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"
    XDG_CURRENT_DESKTOP "niri"

    // 应用程序支持 (最小化)
    QT_QPA_PLATFORM "wayland"
    GDK_BACKEND "wayland"

    // 语言 (英文减少处理开销)
    LANG "C.UTF-8"

    // 主题 (最小化)
    GTK_THEME "Adwaita"
    XCURSOR_THEME "Adwaita"
    XCURSOR_SIZE "24"
}

input {
    keyboard {
        xkb {
            layout "us"
        }
        repeat-delay 300
        repeat-rate 50
    }

    touchpad {
        tap true
        natural-scroll true
        accel-speed 0.0
        accel-profile "flat"        // 减少计算
    }

    mouse {
        accel-speed 0.0
        accel-profile "flat"
    }
}

output "eDP-1" {
    mode "1920x1080@60.000"
    scale 1.0                       // 避免缩放计算
    background-color "#000000"      // 纯黑色
}

layout {
    gaps 4                          // 最小间距
    center-focused-column "never"   // 避免重新布局

    preset-column-widths {
        proportion 0.5              // 单一预设减少选择
    }

    default-column-width { proportion 0.5 }

    focus-ring {
        width 2                     // 细边框减少渲染
        active-color "#7fc8ff"
        inactive-color "transparent" // 透明减少渲染
    }

    border { off }                  // 完全关闭边框

    background-color "#000000"
}

binds {
    // 仅基础绑定
    Mod+Return { spawn "alacritty"; }
    Mod+D { spawn "rofi" "-show" "drun"; }
    Mod+Q { close-window; }
    Mod+Shift+Q { quit; }

    // 聚焦 (仅箭头键)
    Mod+Left { focus-column-left; }
    Mod+Right { focus-column-right; }
    Mod+Up { focus-window-up; }
    Mod+Down { focus-window-down; }

    // 工作区 (仅数字键)
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }

    Mod+Shift+1 { move-to-workspace 1; }
    Mod+Shift+2 { move-to-workspace 2; }
    Mod+Shift+3 { move-to-workspace 3; }

    // 基础功能
    Mod+F { fullscreen-window; }
    Print { spawn "grimshot" "copy" "area"; }
}

// 最小化窗口规则
window-rule {
    match app-id=".*"
    default-column-width { proportion 0.5 }
}

// 关闭动画
animations {
    off
}

cursor {
    xcursor-theme "Adwaita"
    xcursor-size 24
    hide-after-inactivity-ms 1000   // 快速隐藏
    hide-when-typing true
}

debug {
    log-level "error"               // 最少日志
    damage-tracking true            // 保持优化
}
```

---

## 多媒体工作站配置

适用于音视频编辑、图形设计等多媒体工作：

```kdl
// 多媒体工作站配置
// 适用于: 视频编辑、图形设计、音乐制作

environment {
    // Wayland + 硬件加速
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"
    XDG_CURRENT_DESKTOP "niri"

    // 应用程序支持
    QT_QPA_PLATFORM "wayland;xcb"
    QT_QPA_PLATFORMTHEME "gtk3"
    GDK_BACKEND "wayland,x11"
    MOZ_ENABLE_WAYLAND "1"
    MOZ_WAYLAND_USE_VAAPI "1"

    // 硬件加速
    LIBVA_DRIVER_NAME "radeonsi"    // 根据显卡调整
    VDPAU_DRIVER "radeonsi"

    // 中文支持
    LANG "zh_CN.UTF-8"
    LC_ALL "zh_CN.UTF-8"

    // 输入法
    GTK_IM_MODULE "fcitx"
    QT_IM_MODULE "fcitx"
    XMODIFIERS "@im=fcitx"

    // 高DPI支持
    GDK_SCALE "1.5"
    QT_AUTO_SCREEN_SCALE_FACTOR "1"
    XCURSOR_SIZE "32"

    // 专业软件优化
    MESA_GL_VERSION_OVERRIDE "4.6"

    // 音频优化
    PULSE_RUNTIME_PATH "/run/user/1000/pulse"
}

input {
    keyboard {
        xkb {
            layout "us"
            options "caps:escape,compose:ralt"
        }
        repeat-delay 400
        repeat-rate 30
    }

    touchpad {
        tap true
        dwt false                   // 设计时不禁用触摸板
        natural-scroll true
        accel-speed 0.3
        accel-profile "adaptive"

        scroll-method "two-finger"
        click-method "clickfinger"  // 更精确的点击
    }

    mouse {
        accel-speed -0.2            // 精确的鼠标移动
        accel-profile "adaptive"
        natural-scroll false
    }

    tablet {
        map-to-output "Dell Inc. U2720Q"  // 数位板映射到专业显示器
    }
}

// 主显示器 (专业显示器)
output "Dell Inc. U2720Q SERIAL123" {
    mode "3840x2160@60.000"
    scale 1.5                       // 4K + 150% 缩放
    position x=0 y=0
    focus-at-startup
    background-color "#1a1a1a"
}

// 副显示器 (参考/工具面板)
output "eDP-1" {
    mode "1920x1080@60.000"
    scale 1.25
    position x=2560 y=500           // 右侧稍低位置
    transform "90"                  // 竖屏用于时间线
    background-color "#2d2d2d"
}

layout {
    gaps 20                         // 宽敞的间距
    center-focused-column "on-overflow"

    preset-column-widths {
        proportion 0.25             // 工具面板
        proportion 0.5              // 预览窗口
        proportion 0.75             // 时间线/编辑器
        fixed 300                   // 属性面板
        fixed 400                   // 素材库
    }

    default-column-width { proportion 0.6 }

    focus-ring {
        width 4
        active-color "#ff6b6b"      // 醒目的红色
        inactive-color "#404040"
    }

    border {
        width 3
        active-color "#4ecdc4"      // 青色边框
        inactive-color "#2a2a2a"
    }

    floating-window {
        border {
            width 4
            active-color "#ffd700"  // 金色悬浮窗口
        }
    }

    background-color "#1e1e2e"
}

binds {
    // === 专业应用启动 ===
    Mod+Return { spawn "alacritty"; }
    Mod+E { spawn "nautilus"; }
    Mod+W { spawn "firefox"; }
    Mod+D { spawn "rofi" "-show" "drun"; }

    // 多媒体应用
    Mod+Shift+V { spawn "davinci-resolve"; }    // 视频编辑
    Mod+Shift+G { spawn "gimp"; }               // 图像编辑
    Mod+Shift+B { spawn "blender"; }            // 3D建模
    Mod+Shift+A { spawn "audacity"; }           // 音频编辑
    Mod+Shift+K { spawn "kdenlive"; }           // 轻量视频编辑

    // 设计工具
    Mod+Ctrl+I { spawn "inkscape"; }            // 矢量图形
    Mod+Ctrl+K { spawn "krita"; }               // 数字绘画
    Mod+Ctrl+F { spawn "figma-linux"; }         // UI设计

    // === 窗口操作 (保持标准) ===
    Mod+Q { close-window; }
    Mod+Shift+Q { quit; }

    Mod+H { focus-column-left; }
    Mod+L { focus-column-right; }
    Mod+J { focus-window-down; }
    Mod+K { focus-window-up; }

    Mod+Shift+H { move-column-left; }
    Mod+Shift+L { move-column-right; }
    Mod+Shift+J { move-window-down; }
    Mod+Shift+K { move-window-up; }

    // 精确大小调整
    Mod+R { switch-preset-column-width; }
    Mod+Minus { set-column-width "-5%"; }       // 精细调整
    Mod+Equal { set-column-width "+5%"; }
    Mod+Shift+Minus { set-window-height "-5%"; }
    Mod+Shift+Equal { set-window-height "+5%"; }

    // === 多显示器 ===
    Mod+Ctrl+H { focus-monitor-left; }
    Mod+Ctrl+L { focus-monitor-right; }
    Mod+Shift+Ctrl+H { move-window-to-monitor-left; }
    Mod+Shift+Ctrl+L { move-window-to-monitor-right; }

    // === 工作区 (更多工作区) ===
    Mod+1 { focus-workspace 1; }               // 项目管理
    Mod+2 { focus-workspace 2; }               // 视频编辑
    Mod+3 { focus-workspace 3; }               // 音频处理
    Mod+4 { focus-workspace 4; }               // 图像设计
    Mod+5 { focus-workspace 5; }               // 3D建模
    Mod+6 { focus-workspace 6; }               // 渲染输出
    Mod+7 { focus-workspace 7; }               // 文档资料
    Mod+8 { focus-workspace 8; }               // 通信协作
    Mod+9 { focus-workspace 9; }               // 系统监控

    // 对应的移动绑定
    Mod+Shift+1 { move-to-workspace 1; }
    Mod+Shift+2 { move-to-workspace 2; }
    Mod+Shift+3 { move-to-workspace 3; }
    Mod+Shift+4 { move-to-workspace 4; }
    Mod+Shift+5 { move-to-workspace 5; }
    Mod+Shift+6 { move-to-workspace 6; }
    Mod+Shift+7 { move-to-workspace 7; }
    Mod+Shift+8 { move-to-workspace 8; }
    Mod+Shift+9 { move-to-workspace 9; }

    // === 专业功能 ===
    Mod+Tab { overview-toggle; }
    Mod+F { fullscreen-window; }
    Mod+Shift+F { maximize-window; }
    Mod+Shift+Space { toggle-window-floating; }

    // 屏幕截图/录制
    Print { spawn "grimshot" "copy" "area"; }
    Mod+Print { spawn "grimshot" "copy" "screen"; }
    Shift+Print { spawn "grimshot" "save" "area"; }
    Mod+Shift+Print { spawn "obs" "--startrecording"; }  // OBS录制

    // === 音频专业控制 ===
    XF86AudioRaiseVolume { spawn "amixer" "set" "Master" "2%+"; }  // 精细音量
    XF86AudioLowerVolume { spawn "amixer" "set" "Master" "2%-"; }
    XF86AudioMute { spawn "amixer" "set" "Master" "toggle"; }
    Mod+Shift+M { spawn "pavucontrol"; }        // 音频控制面板

    // 多媒体控制
    XF86AudioPlay { spawn "playerctl" "play-pause"; }
    XF86AudioNext { spawn "playerctl" "next"; }
    XF86AudioPrev { spawn "playerctl" "previous"; }

    // === 系统控制 ===
    Mod+Escape { spawn "swaylock"; }
    Mod+Shift+E { spawn "systemctl" "suspend"; }
    Mod+Shift+C { reload-config; }

    // GPU/系统监控
    Mod+Ctrl+T { spawn "alacritty" "-e" "htop"; }
    Mod+Ctrl+G { spawn "alacritty" "-e" "nvtop"; }      // GPU监控
}

// ========== 专业应用窗口规则 ==========
// 视频编辑软件
window-rule {
    match app-id="com.blackmagicdesign.resolve|kdenlive"
    open-maximized true
    open-on-output "Dell Inc. U2720Q"
    variable-refresh-rate true
}

// 图像编辑软件
window-rule {
    match app-id="gimp-.*|org.inkscape.Inkscape|krita"
    open-maximized true
    open-on-output "Dell Inc. U2720Q"
    default-column-width { proportion 0.8 }
}

// 3D软件
window-rule {
    match app-id="blender|org.blender.Blender"
    open-maximized true
    variable-refresh-rate true
}

// 音频软件
window-rule {
    match app-id="audacity|reaper"
    open-on-workspace 3
    default-column-width { proportion 0.9 }
}

// 浏览器 (参考资料)
window-rule {
    match app-id="firefox|chromium"
    default-column-width { proportion 0.6 }
    open-on-output "eDP-1"              // 副显示器
}

// 文件管理器 (素材管理)
window-rule {
    match app-id="nautilus|thunar"
    default-column-width { fixed 400 }
    min-width 350
}

// OBS Studio
window-rule {
    match app-id="com.obsproject.Studio"
    open-on-workspace 6
    default-column-width { proportion 0.8 }
}

// 系统监控
window-rule {
    match app-id="gnome-system-monitor" title=".*System Monitor.*"
    open-on-workspace 9
    default-column-width { fixed 500 }
}

animations {
    // 流畅的专业动画
    window-open {
        duration-ms 200
        curve "ease-out-cubic"
        scale-from 0.85
        opacity-from 0.0
    }

    window-close {
        duration-ms 180
        curve "ease-in-cubic"
        scale-to 0.85
        opacity-to 0.0
    }

    workspace-switch {
        duration-ms 250
        curve "ease-in-out-cubic"
    }

    window-movement {
        duration-ms 200
        curve "ease-out-cubic"
    }

    window-resize {
        duration-ms 150
        curve "ease-out-cubic"
        live-preview true           // 实时预览重要
    }
}

cursor {
    xcursor-theme "Adwaita"
    xcursor-size 32                     // 高DPI适配
    hide-after-inactivity-ms 5000       // 较长隐藏时间
    hide-when-typing false              // 设计工作时不隐藏
}

debug {
    log-level "info"
    vrr-debug false
    damage-tracking true
    enable-color-transformations-capability-search true  // 色彩管理
}
```

## 其他配置示例说明

由于篇幅限制，以上提供了三个主要的完整配置示例。其他场景的配置可以基于这些示例进行调整：

### 开发环境配置要点
- 深色主题 (`GTK_THEME "Adwaita:dark"`)
- 英文环境 (`LANG "en_US.UTF-8"`)
- 代码编辑器优化的窗口规则
- 多个终端和编辑器的预设宽度
- Git工具的特殊处理

### 游戏优化配置要点
- 关闭动画 (`animations { off }`)
- VRR支持 (`variable-refresh-rate on-demand=true`)
- 硬件加速环境变量
- Steam和游戏应用的全屏规则
- 性能监控工具快捷键

### 最小化配置要点
- 仅基础环境变量
- 简化的输入配置
- 最少的键盘绑定
- 无动画和特效
- 基础窗口规则

### 可访问性配置要点
- 大光标和字体
- 高对比度主题
- 减少动画或关闭动画
- 简化的键盘绑定
- 语音输出支持的环境变量

---

## 配置文件组织建议

### 模块化配置
可以将配置拆分为多个文件：

```bash
~/.config/niri/
├── config.kdl              # 主配置文件
├── input.kdl               # 输入设备配置
├── outputs.kdl             # 显示器配置
├── binds.kdl               # 键盘绑定
├── window-rules.kdl        # 窗口规则
└── themes/
    ├── dark.kdl            # 深色主题
    └── light.kdl           # 浅色主题
```

### 条件配置
可以为不同环境准备不同的配置文件：
- `config-desktop.kdl` - 桌面环境
- `config-laptop.kdl` - 笔记本环境
- `config-work.kdl` - 工作环境
- `config-gaming.kdl` - 游戏环境

通过软链接或脚本切换配置：
```bash
ln -sf ~/.config/niri/config-work.kdl ~/.config/niri/config.kdl
niri msg reload-config
```

这样可以根据不同的使用场景快速切换最优配置。
