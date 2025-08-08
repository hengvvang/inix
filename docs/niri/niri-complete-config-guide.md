# Niri 完整配置指南

基于官方文档和Wiki的全面配置参考。本文档涵盖niri的所有配置项、详细的参数说明和使用示例。

> **版本说明**: 本文档基于niri官方Wiki最新版本（2025年1月），涵盖至25.05版本及即将发布的功能。配置文件格式为KDL。

## 目录

1. [配置文件基础](#配置文件基础)
2. [input {}](#input)
3. [output "NAME" {}](#output-name)
4. [binds {}](#binds)
5. [switch-events {}](#switch-events)
6. [layout {}](#layout)
7. [workspace "NAME" {}](#workspace-name)
8. [顶层配置选项](#顶层配置选项)
9. [window-rule {}](#window-rule)
10. [layer-rule {}](#layer-rule)
11. [animations {}](#animations)
12. [gestures {}](#gestures)
13. [debug {}](#debug)
14. [颜色和渐变语法](#颜色和渐变语法)
15. [实用工具和命令](#实用工具和命令)

---

## 配置文件基础

### 加载顺序
1. `$XDG_CONFIG_HOME/niri/config.kdl` 或 `~/.config/niri/config.kdl`
2. `/etc/niri/config.kdl` （备用）
3. 如果都不存在，会创建默认配置文件

### 命令行参数
- `--config` / `-c`: 指定配置文件路径
- `NIRI_CONFIG` 环境变量: 配置文件路径（命令行参数优先）

### 语法特点
- **注释**: `//` 行注释，`/-` 段落注释
- **标志**: 写出即启用，注释或省略即禁用
- **段落**: 大部分不可重复，按设备/输出名区分的可重复
- **默认值**: 多数段落可省略使用默认值，但 `binds {}` 例外
- **实时重载**: 保存后立即生效，可用 `niri validate` 校验

---

## input {}

配置输入设备和通用输入行为。

```kdl
input {
    keyboard {
        xkb {
            layout "us"                    // 布局: 如 "us", "us,ru"
            variant "colemak_dh_ortho"     // 变体: 如 "colemak_dh_ortho"
            options "compose:ralt,ctrl:nocaps" // 选项: 如 "compose:ralt,ctrl:nocaps"
            model ""                       // 型号: 通常为空
            rules ""                       // 规则: 通常为空
            file "~/.config/keymap.xkb"    // 直接指定xkb文件（Since: 25.02）
        }

        repeat-delay 600                   // 键重复延迟（毫秒）
        repeat-rate 25                     // 键重复速率（字符/秒）
        track-layout "global"              // "global" | "window" - 布局跟踪模式
        numlock                           // 启动时开启数字锁定（Since: 25.05）
    }

    touchpad {
        off                               // 禁用设备
        tap                               // 轻触点击
        dwt                               // 打字时禁用触控板
        dwtp                              // 轨迹点使用时禁用触控板
        drag false                        // 轻触拖拽（Since: 25.05）
        drag-lock                         // 拖拽锁定（Since: 25.02）
        natural-scroll                    // 自然滚动
        accel-speed 0.2                   // 加速度 -1.0 到 1.0
        accel-profile "flat"              // "adaptive" | "flat"
        scroll-factor 1.0                 // 滚动速度倍数（Since: 0.1.10）
        scroll-method "two-finger"        // "no-scroll" | "two-finger" | "edge" | "on-button-down"
        scroll-button 273                 // 按钮代码（用于 on-button-down）
        scroll-button-lock                // 滚动按钮锁定（Since: next release）
        tap-button-map "left-middle-right" // "left-right-middle" | "left-middle-right"
        click-method "clickfinger"        // "button-areas" | "clickfinger"
        left-handed                       // 左手模式
        disabled-on-external-mouse        // 外接鼠标时禁用
        middle-emulation                  // 左右键同时按模拟中键
    }

    mouse {
        // 与touchpad相同的选项（除了tap相关）
        off
        natural-scroll
        accel-speed 0.2
        accel-profile "flat"
        scroll-factor 1.0
        scroll-method "no-scroll"
        scroll-button 273
        scroll-button-lock
        left-handed
        middle-emulation
    }

    trackpoint {
        // 与mouse相同的选项，通常使用：
        scroll-method "on-button-down"
        scroll-button 273
    }

    trackball {
        // 与trackpoint相同的选项
    }

    tablet {
        off                               // 禁用设备
        map-to-output "eDP-1"            // 映射到特定输出
        left-handed
        calibration-matrix 1.0 0.0 0.0 0.0 1.0 0.0  // 校准矩阵（Since: 25.02）
    }

    touch {
        off                               // 禁用设备
        map-to-output "eDP-1"            // 映射到特定输出
    }

    // 通用设置
    disable-power-key-handling            // 让位给logind处理电源键
    warp-mouse-to-focus                   // 鼠标跟随焦点
    warp-mouse-to-focus mode="center-xy"  // "center-xy" | "center-xy-always"（Since: 25.05）
    focus-follows-mouse                   // 鼠标悬停聚焦
    focus-follows-mouse max-scroll-amount="0%" // 允许滚动的最大百分比
    workspace-auto-back-and-forth         // 工作区往返切换

    mod-key "Super"                       // Mod键定义（Since: 25.05）
    mod-key-nested "Alt"                  // 嵌套窗口中的Mod键
}
```

### 键盘布局详解
- **空xkb段落**: 从 `systemd-localed` 读取设置
- **多布局**: `layout "us,ru"` 支持多布局切换
- **track-layout**:
  - `"global"`: 全局布局切换
  - `"window"`: 每窗口独立布局
- **xkb文件**: 直接指定完整键盘映射，覆盖其他xkb设置

### 指针设备参数详解
- **scroll-method选项**:
  - `"no-scroll"`: 禁用滚动
  - `"two-finger"`: 双指滚动（触控板默认）
  - `"edge"`: 边缘滚动
  - `"on-button-down"`: 按钮滚动（轨迹点常用）

---

## output "NAME" {}

按连接器名或显示器信息配置输出设备。可使用 `niri msg outputs` 查看可用输出。

```kdl
output "eDP-1" {
    off                                   // 关闭该输出

    mode "1920x1080"                      // 分辨率
    mode "1920x1080@60.000"               // 分辨率@刷新率

    scale 1.5                             // 缩放倍数（0.1-10.0，支持小数）

    transform "normal"                    // 旋转变换
    // "90" | "180" | "270" | "flipped" | "flipped-90" | "flipped-180" | "flipped-270"

    position x=1920 y=0                   // 全局坐标位置

    variable-refresh-rate                 // VRR/自适应同步
    variable-refresh-rate on-demand=true  // 按需VRR

    focus-at-startup                      // 启动时优先聚焦

    background-color "#003300"            // 工作区背景色
    backdrop-color "#333333"              // 工作区间/总览背景色
}

// 使用厂商型号序列号匹配
output "Some Company CoolMonitor 1234" {
    mode "2560x1440@144.000"
}
```

### 输出配置详解
- **连接器名**: `eDP-1`, `HDMI-A-1`, `DP-2` 等（大小写不敏感）
- **厂商信息**: `"厂商 型号 序列号"` 格式，更精确匹配
- **自动定位**: 显式position优先，重叠则右移，其余按名称排序
- **VRR注意**: 可能导致光标低帧率或闪屏，建议配合on-demand使用

---

## binds {}

快捷键绑定配置。**重要**: 该段落不会自动填充默认值，省略会导致无快捷键。

```kdl
binds {
    // 基本格式：修饰符+键名 [属性] { 动作; }
    Mod+Left { focus-column-left; }
    Super+Alt+L { spawn "swaylock"; }

    // 属性示例
    Mod+T repeat=false { spawn "alacritty"; }                    // 禁用重复
    Mod+T cooldown-ms=500 { spawn "alacritty"; }                // 500ms冷却
    XF86AudioMute allow-when-locked=true {                      // 锁屏时生效
        spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    }
    Super+Alt+L allow-inhibiting=false { spawn "swaylock"; }    // 忽略键盘抑制

    // 自定义热键帮助标题（Since: 25.02）
    Mod+Shift+S hotkey-overlay-title="Toggle Dark/Light Style" {
        spawn "some-script.sh";
    }
    Mod+Q hotkey-overlay-title=null { close-window; }           // 隐藏该绑定

    // 滚轮绑定
    Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
    Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
    Mod+WheelScrollRight { focus-column-right; }
    Mod+WheelScrollLeft { focus-column-left; }

    // 触控板滚动绑定
    Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
    Mod+TouchpadScrollUp { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

    // 鼠标点击绑定（Since: 25.01）
    Mod+MouseLeft { close-window; }
    Mod+MouseRight { move-window-to-workspace-down; }
    Mod+MouseMiddle { maximize-column; }
    Mod+MouseForward { focus-workspace-up; }
    Mod+MouseBack { focus-workspace-down; }
}
```

### 修饰符详解
- **支持的修饰符**: `Ctrl`/`Control`, `Shift`, `Alt`, `Super`/`Win`, `ISO_Level3_Shift`/`Mod5`, `ISO_Level5_Shift`, `Mod`
- **Mod键**: TTY下默认为Super，嵌套窗口下默认为Alt，可通过input段自定义

### 主要动作类型

#### spawn（程序启动）
```kdl
// 正确：每个参数单独引号
Mod+T { spawn "alacritty" "-e" "/usr/bin/fish"; }

// 错误：整个命令作为一个字符串
// Mod+D { spawn "alacritty -e /usr/bin/fish"; }

// Shell命令（需要变量展开、管道等）
Mod+D { spawn "sh" "-c" "grim -o $MAIN_OUTPUT ~/screenshot.png"; }

// 特殊：程序名开头的~会展开
Mod+T { spawn "~/scripts/do-something.sh"; }
```

#### 系统控制
```kdl
Mod+Shift+E { quit; }                           // 退出（带确认）
Mod+Shift+E { quit skip-confirmation=true; }    // 退出（无确认）
Mod+Return { do-screen-transition; }             // 屏幕过渡效果
Mod+Return { do-screen-transition delay-ms=100; } // 自定义延迟
```

#### 截图
```kdl
Print { screenshot; }                            // 交互式截图
Ctrl+Print { screenshot-screen; }               // 屏幕截图
Alt+Print { screenshot-window; }                // 窗口截图
Ctrl+Print { screenshot-screen write-to-disk=false; }      // 仅复制到剪贴板
Print { screenshot show-pointer=false; }        // 隐藏鼠标指针（Since: 25.05）
```

#### 窗口和工作区管理
```kdl
// 焦点移动
Mod+Left { focus-column-left; }
Mod+Right { focus-column-right; }
Mod+Up { focus-window-up; }
Mod+Down { focus-window-down; }

// 窗口移动
Mod+Shift+Left { move-column-left; }
Mod+Shift+Right { move-column-right; }
Mod+Shift+Up { move-window-up; }
Mod+Shift+Down { move-window-down; }

// 工作区切换
Mod+1 { focus-workspace 1; }
Mod+2 { focus-workspace 2; }
Mod+Page_Up { focus-workspace-up; }
Mod+Page_Down { focus-workspace-down; }

// 窗口到工作区
Mod+Shift+1 { move-window-to-workspace 1; }
Mod+Shift+Page_Up { move-window-to-workspace-up; }

// 列/窗口尺寸
Mod+R { switch-preset-column-width; }
Mod+Shift+R { switch-preset-window-height; }
Mod+F { maximize-column; }
Mod+Shift+F { fullscreen-window; }
```

#### 特殊功能
```kdl
Mod+O { toggle-window-rule-opacity; }           // 切换窗口透明度（Since: 25.02）
Mod+Escape { toggle-keyboard-shortcuts-inhibit; } // 切换快捷键抑制（Since: 25.02）
```

---

## switch-events {}

系统开关事件绑定，即使会话锁定也会执行。

```kdl
switch-events {
    lid-close { spawn "systemctl" "suspend"; }           // 合盖事件
    lid-open { spawn "systemctl" "--user" "restart" "pipewire"; } // 开盖事件
    tablet-mode-on { spawn "busctl" "call" "--user" "sm.puri.OSK0" "/sm/puri/OSK0" "sm.puri.OSK0" "SetVisible" "b" "true"; }
    tablet-mode-off { spawn "busctl" "call" "--user" "sm.puri.OSK0" "/sm/puri/OSK0" "sm.puri.OSK0" "SetVisible" "b" "false"; }
}
```

---

## layout {}

窗口布局、视觉效果和空间分配设置。

```kdl
layout {
    gaps 16                               // 窗口间隙（逻辑像素，支持小数）

    center-focused-column "never"         // 居中策略
    // "never" | "always" | "on-overflow"

    always-center-single-column           // 单列总是居中（Since: 0.1.9）
    empty-workspace-above-first           // 首个工作区前也添加空工作区（Since: 25.01）
    default-column-display "normal"       // 新列默认显示模式（Since: 25.02）
    // "normal" | "tabbed"

    background-color "#003300"            // 默认背景色（Since: 25.05）

    // 列宽预设
    preset-column-widths {
        proportion 0.33333                // 1/3屏幕宽
        proportion 0.5                    // 1/2屏幕宽
        proportion 0.66667                // 2/3屏幕宽
        fixed 1280                        // 固定1280像素
    }

    // 新窗口默认宽度
    default-column-width { proportion 0.5; }  // 比例
    default-column-width { fixed 800; }       // 固定
    default-column-width {}                   // 由客户端决定

    // 窗口高度预设（Since: 0.1.9）
    preset-window-heights {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        fixed 720
    }

    // 焦点环（仅活动窗口）
    focus-ring {
        off                               // 禁用
        width 4                           // 宽度（逻辑像素，支持小数）
        active-color "#7fc8ff"            // 活动颜色
        inactive-color "#505050"          // 非活动颜色
        urgent-color "#9b0000"            // 紧急颜色

        // 渐变
        active-gradient from="#80c8ff" to="#bbddff" angle=45
        active-gradient from="#80c8ff" to="#bbddff" angle=45 relative-to="workspace-view"
        active-gradient from="#f00f" to="#0f05" angle=45 in="oklch longer hue"
    }

    // 边框（所有窗口，影响尺寸）
    border {
        off                               // 禁用
        width 4
        active-color "#ffc87f"
        inactive-color "#505050"
        urgent-color "#9b0000"
        // 支持相同的渐变选项
    }

    // 阴影（Since: 25.02）
    shadow {
        on                                // 启用
        softness 30                       // 模糊半径（逻辑像素）
        spread 5                          // 扩展距离（逻辑像素，Since: 25.05支持负值）
        offset x=0 y=5                    // 偏移
        draw-behind-window true           // 在窗口后绘制
        color "#00000070"                 // 阴影颜色
        inactive-color "#00000054"        // 非活动窗口阴影颜色
    }

    // 选项卡指示器（Since: 25.02）
    tab-indicator {
        off                               // 禁用
        hide-when-single-tab              // 单选项卡时隐藏
        place-within-column               // 放置在列内
        gap 5                             // 与窗口的间隙（可为负）
        width 4                           // 厚度
        length total-proportion=1.0       // 长度比例
        position "right"                  // 位置: "left" | "right" | "top" | "bottom"
        gaps-between-tabs 2               // 选项卡间隙
        corner-radius 8                   // 圆角半径
        active-color "red"                // 活动颜色
        inactive-color "gray"             // 非活动颜色
        urgent-color "blue"               // 紧急颜色
        // 支持渐变选项
    }

    // 插入提示（Since: 0.1.10）
    insert-hint {
        off                               // 禁用
        color "#ffc87f80"                 // 颜色
        gradient from="#ffbb6680" to="#ffc88080" angle=45 relative-to="workspace-view"
    }

    // 外边距
    struts {
        left 64                           // 左边距（逻辑像素，支持负值）
        right 64                          // 右边距
        top 64                            // 上边距
        bottom 64                         // 下边距
    }
}
```

### 布局详解

#### 居中策略
- **"never"**: 不居中，离屏列滚动到边缘
- **"always"**: 活动列总是居中
- **"on-overflow"**: 仅当列不适合屏幕时居中

#### 尺寸系统
- **proportion**: 相对比例（考虑间隙）
- **fixed**: 固定像素值

#### 颜色和渐变
- **颜色格式**: CSS命名色、十六进制（#rgb, #rgba, #rrggbb, #rrggbbaa）、CSS函数（rgb(), hsl()等）
- **渐变语法**: `from="color1" to="color2" angle=degrees`
- **相对定位**: `relative-to="workspace-view"` 相对工作区而非窗口
- **颜色空间**: `in="srgb"` | `"srgb-linear"` | `"oklab"` | `"oklch longer hue"`等

---

## workspace "NAME" {}

命名工作区配置。

```kdl
workspace "chat" {
    open-on-output "HDMI-A-1"            // 固定到特定输出
    // 或使用厂商信息: "Some Company CoolMonitor 1234"
}

workspace "code" {
    open-on-output "eDP-1"
}
```

### 命名工作区特点
- 始终存在，不会自动销毁
- 更"粘附"原输出（Since: 25.02）
- 可通过IPC动态改名（Since: 25.01）

---

## 顶层配置选项

```kdl
// 启动时运行的程序
spawn-at-startup "waybar"
spawn-at-startup "alacritty" "--class" "startup-terminal"

// 请求无客户端装饰
prefer-no-csd

// 截图保存路径（支持strftime格式）
screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
screenshot-path null                      // 禁止保存到磁盘

// 环境变量
environment {
    QT_QPA_PLATFORM "wayland"             // 设置变量
    DISPLAY null                          // 移除变量
}

// 光标设置
cursor {
    xcursor-theme "breeze_cursors"        // 主题名
    xcursor-size 48                       // 大小
    hide-when-typing                      // 打字时隐藏（Since: 0.1.10）
    hide-after-inactive-ms 1000           // 不活动后隐藏（毫秒）
}

// 总览设置（Since: 25.05）
overview {
    zoom 0.5                              // 缩放级别（0-0.75，越小越缩）
    backdrop-color "#262626"              // 背景色（忽略alpha）

    workspace-shadow {                    // 工作区阴影
        on                                // 启用
        softness 40                       // 模糊半径（需要比窗口阴影更大）
        spread 10                         // 扩展
        offset x=0 y=10                   // 偏移
        color "#00000050"                 // 颜色
    }
}

// Xwayland Satellite集成（Since: next release）
xwayland-satellite {
    off                                   // 禁用集成
    path "xwayland-satellite"             // 二进制路径
}

// 剪贴板设置（Since: 25.02）
clipboard {
    disable-primary                       // 禁用主剪贴板（中键粘贴）
}

// 热键帮助设置
hotkey-overlay {
    skip-at-startup                       // 启动时不显示
    hide-not-bound                        // 隐藏未绑定的动作（Since: next release）
}
```

---

## window-rule {}

按窗口匹配规则应用属性，按出现顺序处理。

```kdl
window-rule {
    // 匹配条件（任一满足即匹配）
    match title="Mozilla Firefox"         // 标题正则匹配
    match app-id="Alacritty"              // 应用ID正则匹配
    match is-active=true                  // 是否为活动窗口
    match is-focused=false                // 是否有键盘焦点
    match is-active-in-column=true        // 列中是否活动（Since: 0.1.6）
    match is-floating=true                // 是否浮动（Since: 25.01）
    match is-window-cast-target=true      // 是否为投屏目标（Since: 25.02）
    match is-urgent=true                  // 是否请求注意（Since: 25.05）
    match at-startup=true                 // 启动60秒内（Since: 0.1.6）

    // 排除条件（任一满足即排除）
    exclude title="^Media viewer$"
    exclude app-id=r#"^org\.telegram\.desktop$"# title="^Media viewer$"

    // 开窗时一次性属性
    default-column-width { proportion 0.75; }    // 默认列宽
    default-window-height { fixed 500; }         // 默认窗口高（Since: 25.01）
    open-on-output "Some Company CoolMonitor 1234" // 在指定输出打开
    open-on-workspace "chat"                     // 在指定工作区打开（Since: 0.1.6）
    open-maximized true                          // 最大化打开
    open-fullscreen false                        // 禁止全屏打开
    open-floating true                           // 浮动打开（Since: 25.01）
    open-focused false                           // 不自动聚焦（Since: 25.01）

    // 持续动态属性
    block-out-from "screencast"                 // 从投屏中遮黑
    // block-out-from "screen-capture"           // 从所有截屏中遮黑
    opacity 0.5                                 // 透明度（0.0-1.0）
    variable-refresh-rate true                  // VRR支持（Since: 0.1.9）
    default-column-display "tabbed"             // 默认列显示模式（Since: 25.02）
    default-floating-position x=100 y=200 relative-to="bottom-left" // 浮动位置（Since: 25.01）
    scroll-factor 0.75                          // 滚动系数（Since: 25.02）

    // 绘制选项
    draw-border-with-background false           // 边框背景绘制

    // 焦点环和边框（Since: 0.1.6）
    focus-ring {
        off                                     // 禁用
        on                                      // 强制启用（优先于off）
        width 4
        active-color "#7fc8ff"
        // ... 其他颜色/渐变选项
    }

    border {
        // 与focus-ring相同的选项
    }

    // 阴影（Since: 25.02）
    shadow {
        off                                     // 禁用
        on                                      // 启用（优先于off）
        softness 40
        // ... 其他阴影选项
    }

    // 选项卡指示器（Since: 25.02）
    tab-indicator {
        active-color "red"
        inactive-color "gray"
        // ... 其他选项
    }

    // 几何和剪裁
    geometry-corner-radius 12               // 圆角半径（Since: 0.1.6）
    geometry-corner-radius 8 8 0 0          // 四角分别设置（顺序：左上、右上、右下、左下）
    clip-to-geometry true                   // 剪裁到几何边界（Since: 0.1.6）
    tiled-state true                        // 通知窗口已平铺（Since: 25.05）
    baba-is-float true                      // 愚人节浮动效果（Since: 25.02）

    // 尺寸限制
    min-width 100                           // 最小宽度（逻辑像素）
    max-width 200                           // 最大宽度
    min-height 300                          // 最小高度
    max-height 300                          // 最大高度（注意：仅在等于min-height时对自动高生效）
}
```

### 窗口规则详解

#### 匹配器详解
- **title/app-id**: 正则表达式，可使用原始字符串 `r#"..."#`
- **is-active**: 每个工作区一个，多显示器时可能多个
- **is-focused**: 全局唯一，layer-shell活动时窗口不匹配
- **is-active-in-column**: 每列一个，最后聚焦的窗口

#### 定位选项
- **relative-to**: `"top-left"` | `"top-right"` | `"bottom-left"` | `"bottom-right"` | `"top"` | `"bottom"` | `"left"` | `"right"`
- 坐标方向根据relative-to改变

#### 实用示例
```kdl
// Firefox画中画窗口
window-rule {
    match app-id="firefox$" title="^Picture-in-Picture$"
    open-floating true
    default-column-width { fixed 480; }
    default-window-height { fixed 270; }
    default-floating-position x=32 y=32 relative-to="bottom-left"
}

// 密码管理器从投屏中隐藏
window-rule {
    match app-id=r#"^org\.keepassxc\.KeePassXC$"#
    match app-id=r#"^org\.gnome\.World\.Secrets$"#
    block-out-from "screencast"
}

// 非活动窗口半透明
window-rule {
    match is-active=false
    opacity 0.95
}
```

---

## layer-rule {}

针对layer-shell表面（通知、启动器、壁纸等）的规则。

```kdl
layer-rule {
    // 匹配条件
    match namespace="waybar"              // 命名空间（用niri msg layers查看）
    match at-startup=true                 // 启动60秒内

    // 属性
    block-out-from "screencast"           // 从投屏中遮黑
    opacity 0.8                           // 透明度

    shadow {                              // 阴影
        on
        softness 20
        spread 2
        offset x=0 y=2
        color "#00000040"
    }

    geometry-corner-radius 8              // 圆角（仅影响阴影）
    place-within-backdrop true            // 嵌入总览背景（Since: 25.05）
    baba-is-float true                    // 浮动效果（Since: 25.05）
}
```

---

## animations {}

动画配置，支持缓动和弹簧两种类型。

```kdl
animations {
    off                                   // 全局禁用所有动画
    slowdown 3.0                          // 全局减速（<1为加速）

    // 工作区切换（建议弹簧）
    workspace-switch {
        spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
    }

    // 窗口打开（支持自定义着色器）
    window-open {
        duration-ms 150
        curve "ease-out-expo"             // "ease-out-quad" | "ease-out-cubic" | "ease-out-expo" | "linear"

        // 自定义着色器示例（Since: 0.1.6）
        custom-shader r"
            vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                vec4 color = vec4(0.0);
                if (0.0 <= coords_geo.x && coords_geo.x <= 1.0
                        && 0.0 <= coords_geo.y && coords_geo.y <= 1.0)
                {
                    vec4 from = vec4(1.0, 0.0, 0.0, 1.0);
                    vec4 to = vec4(0.0, 1.0, 0.0, 1.0);
                    color = mix(from, to, coords_geo.y);
                }
                return color * niri_clamped_progress;
            }
        "
    }

    // 窗口关闭（支持自定义着色器）
    window-close {
        duration-ms 150
        curve "ease-out-quad"

        // 自定义着色器
        custom-shader r"
            vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                // ... 着色器代码
                return color * (1.0 - niri_clamped_progress);
            }
        "
    }

    // 水平视图移动
    horizontal-view-movement {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }

    // 窗口移动
    window-movement {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }

    // 窗口调整大小（支持自定义着色器）
    window-resize {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001

        // 自定义着色器
        custom-shader r"
            vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
                vec3 coords_tex_next = niri_geo_to_tex_next * coords_curr_geo;
                vec4 color = texture2D(niri_tex_next, coords_tex_next.st);
                return color;
            }
        "
    }

    // 配置通知开关（轻微反弹）
    config-notification-open-close {
        spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
    }

    // 截图UI打开
    screenshot-ui-open {
        duration-ms 200
        curve "ease-out-quad"
    }

    // 总览开关（Since: 25.05）
    overview-open-close {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }
}
```

### 动画类型详解

#### 缓动动画（Easing）
- **duration-ms**: 持续时间（毫秒）
- **curve**: 缓动曲线
  - `"ease-out-quad"`: 二次缓出
  - `"ease-out-cubic"`: 三次缓出
  - `"ease-out-expo"`: 指数缓出
  - `"linear"`: 线性

#### 弹簧动画（Spring）
- **damping-ratio**: 阻尼比（0.1-10.0）
  - `< 1.0`: 欠阻尼，会震荡
  - `= 1.0`: 临界阻尼，最快到达无震荡
  - `> 1.0`: 过阻尼，不震荡（不推荐，有数值不稳定问题）
- **stiffness**: 刚度，越低越慢越容易震荡
- **epsilon**: 精度阈值，太高会导致动画"跳跃"

#### 同步动画
相关动作会使用相同配置保持同步，如窗口调整大小导致的视图移动会使用window-resize配置而非horizontal-view-movement配置。

---

## gestures {}

手势配置。

```kdl
gestures {
    // 拖放边缘视图滚动
    dnd-edge-view-scroll {
        trigger-width 10.0                // 触发区宽度（逻辑像素）
        delay-ms 200                      // 延迟触发（毫秒）
        max-speed 1000.0                  // 最大速度（逻辑像素/秒）
    }

    // 拖放边缘工作区切换（Since: 25.05）
    dnd-edge-workspace-switch {
        trigger-height 10.0               // 触发区高度（逻辑像素）
        delay-ms 200                      // 延迟触发
        max-speed 1500.0                  // 最大速度（约每秒一屏高）
    }

    // 热角
    hot-corners {
        off                               // 禁用左上角开启总览
    }
}
```

---

## debug {}

调试选项，仅用于调试和实验，随时可能变更。

```kdl
debug {
    preview-render "screencast"          // 预览渲染模式
    // "screencast" | "screen-capture"

    // 渲染优化
    enable-overlay-planes                 // 启用覆盖平面
    disable-cursor-plane                  // 禁用光标平面
    disable-direct-scanout                // 禁用直接扫描输出
    restrict-primary-scanout-to-matching-format // 限制主平面扫描输出格式匹配

    // 设备和接口
    render-drm-device "/dev/dri/card1"    // 指定渲染DRM设备
    force-pipewire-invalid-modifier       // 强制PipeWire无效修饰符（Since: 25.01）
    dbus-interfaces-in-non-session-instances // 非会话实例中创建D-Bus接口

    // 同步和性能
    wait-for-frame-completion-before-queueing // 等待帧完成后排队
    emulate-zero-presentation-time        // 模拟零呈现时间（NVIDIA）
    disable-resize-throttling             // 禁用窗口调整大小节流（Since: 0.1.9）
    disable-transactions                  // 禁用事务（Since: 0.1.9）

    // 显示器相关
    keep-laptop-panel-on-when-lid-is-closed // 合盖时保持笔记本面板开启
    disable-monitor-names                 // 禁用EDID名称（解决双同型号显示器崩溃）
    keep-max-bpc-unchanged                // 不强制max bpc=8（Since: next release）

    // 窗口管理
    strict-new-window-focus-policy        // 严格新窗口聚焦策略（Since: 25.01）
    honor-xdg-activation-with-invalid-serial // 接受无效序列号的激活（Since: 25.05）
    deactivate-unfocused-windows          // 取消激活未聚焦窗口（Since: next release）

    // VRR相关
    skip-cursor-only-updates-during-vrr   // VRR时跳过仅光标更新（Since: next release）
}
```

### 调试键绑定
```kdl
binds {
    Mod+Shift+D { toggle-debug-tint; }              // 切换直接扫描输出检测着色
    Mod+Shift+O { debug-toggle-opaque-regions; }    // 切换不透明区域着色（Since: 0.1.6）
    Mod+Shift+R { debug-toggle-damage; }            // 切换损伤区域着色（Since: 0.1.6）
}
```

---

## 颜色和渐变语法

### 颜色格式
- **CSS命名颜色**: `"red"`, `"blue"`, `"transparent"`
- **十六进制**: `"#rgb"`, `"#rgba"`, `"#rrggbb"`, `"#rrggbbaa"`
- **CSS函数**: `"rgb(255, 127, 0)"`, `"rgba(255, 127, 0, 0.8)"`, `"hsl(120, 100%, 50%)"`
- **传统格式（已废弃）**: `active-color 127 200 255 255`

### 渐变语法
```kdl
// 基本渐变
active-gradient from="#80c8ff" to="#bbddff"

// 指定角度（CSS linear-gradient风格）
active-gradient from="#80c8ff" to="#bbddff" angle=45

// 相对定位
active-gradient from="#ffbb66" to="#ffc880" angle=45 relative-to="workspace-view"

// 颜色空间
active-gradient from="#f00f" to="#0f05" angle=45 in="oklch longer hue"
```

#### 支持的颜色空间
- `"srgb"`（默认）
- `"srgb-linear"`
- `"oklab"`
- `"oklch"` with `"shorter hue"` | `"longer hue"` | `"increasing hue"` | `"decreasing hue"`

---

## 实用工具和命令

### 配置管理
```bash
# 验证配置文件
niri validate

# 使用自定义配置文件
niri --config /path/to/config.kdl

# 设置配置文件环境变量
export NIRI_CONFIG=/path/to/config.kdl
```

### 信息查询
```bash
# 查看可用输出和模式
niri msg outputs

# 查看当前聚焦窗口信息
niri msg focused-window

# 查看layer-shell表面
niri msg layers

# 查看可用动作
niri msg action

# 执行动作
niri msg action do-screen-transition
niri msg action do-screen-transition --delay-ms 100
```

### 调试工具
```bash
# 键名检测
wev

# 鼠标按钮码检测
libinput debug-events

# 系统日志（systemd服务）
journalctl -ef /usr/bin/niri
```

### Waybar集成
配置Waybar显示窗口信息：
```json
{
    "wlr/taskbar": {
        "tooltip-format": "{title} | {app_id}"
    }
}
```

---

## 示例完整配置

```kdl
// 启动程序
spawn-at-startup "waybar"
spawn-at-startup "swaybg" "-i" "~/Pictures/wallpaper.jpg"

// 无客户端装饰
prefer-no-csd

// 截图路径
screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

// 输入配置
input {
    keyboard {
        xkb {
            layout "us,ru"
            options "grp:alt_shift_toggle,caps:escape"
        }
        repeat-delay 400
        repeat-rate 30
    }

    touchpad {
        tap
        natural-scroll
        accel-speed 0.3
        scroll-method "two-finger"
    }

    focus-follows-mouse max-scroll-amount="10%"
    workspace-auto-back-and-forth
}

// 输出配置
output "eDP-1" {
    scale 1.25
    position x=0 y=0
}

output "HDMI-A-1" {
    mode "1920x1080@60.000"
    position x=1536 y=0
    variable-refresh-rate on-demand=true
}

// 布局配置
layout {
    gaps 12
    center-focused-column "on-overflow"

    preset-column-widths {
        proportion 0.25
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        proportion 0.75
    }

    focus-ring {
        width 3
        active-color "#7fc8ff"
        inactive-color "#505050"
    }

    border {
        off
    }
}

// 键盘绑定
binds {
    // 基本导航
    Mod+Left { focus-column-left; }
    Mod+Right { focus-column-right; }
    Mod+Up { focus-window-up; }
    Mod+Down { focus-window-down; }

    // 移动
    Mod+Shift+Left { move-column-left; }
    Mod+Shift+Right { move-column-right; }
    Mod+Shift+Up { move-window-up; }
    Mod+Shift+Down { move-window-down; }

    // 程序启动
    Mod+T { spawn "alacritty"; }
    Mod+D { spawn "rofi" "-show" "drun"; }

    // 系统控制
    Mod+Shift+E { quit; }
    Mod+L { spawn "swaylock"; }

    // 截图
    Print { screenshot; }
    Ctrl+Print { screenshot-screen; }
    Alt+Print { screenshot-window; }

    // 工作区
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+Shift+1 { move-window-to-workspace 1; }
    Mod+Shift+2 { move-window-to-workspace 2; }

    // 窗口管理
    Mod+Q { close-window; }
    Mod+F { maximize-column; }
    Mod+Shift+F { fullscreen-window; }
    Mod+R { switch-preset-column-width; }
}

// 窗口规则
window-rule {
    match app-id="firefox$"
    open-maximized true
}

window-rule {
    match is-active=false
    opacity 0.95
}

// 动画
animations {
    workspace-switch {
        spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
    }

    window-open {
        duration-ms 200
        curve "ease-out-expo"
    }
}
```

---

## 版本变更注意

### Since 25.05
- `numlock` 键盘选项
- `mod-key` 和 `mod-key-nested` 输入选项
- `drag` 触控板选项（boolean）
- `is-urgent` 窗口匹配器
- `empty-workspace-above-first` 布局选项
- `background-color` 布局选项
- `overview` 顶层配置段
- `tiled-state` 窗口规则
- `show-pointer` 截图选项

### Since 25.02
- `file` XKB选项
- `drag-lock` 触控板选项
- `calibration-matrix` 平板选项
- `default-column-display` 布局和窗口规则选项
- `shadow` 布局和窗口规则段
- `tab-indicator` 布局和窗口规则段
- `hotkey-overlay-title` 绑定属性
- `toggle-window-rule-opacity` 动作
- `toggle-keyboard-shortcuts-inhibit` 动作
- `is-window-cast-target` 窗口匹配器
- `scroll-factor` 窗口规则
- `clipboard` 顶层配置段
- `baba-is-float` 窗口和layer规则

### Since 25.01
- `default-window-height` 窗口规则
- `open-floating` 窗口规则
- `open-focused` 窗口规则
- `default-floating-position` 窗口规则
- `is-floating` 窗口匹配器
- 鼠标点击绑定支持
- `force-pipewire-invalid-modifier` 调试选项
- `strict-new-window-focus-policy` 调试选项

### Next Release
- `scroll-button-lock` 输入选项
- `xwayland-satellite` 顶层配置段
- `hide-not-bound` 热键帮助选项
- 多项调试选项

---

*本文档基于niri官方Wiki编写，涵盖所有配置选项和详细说明。如有疑问请参考[niri官方Wiki](https://github.com/YaLTeR/niri/wiki)或使用`niri msg`命令获取实时信息。*
