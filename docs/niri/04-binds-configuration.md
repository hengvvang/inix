# Niri Binds 键盘绑定配置详解

本文档详细介绍niri中 `binds {}` 段落的所有配置选项。键盘绑定是niri操作的核心，控制窗口管理、工作区切换、系统操作等功能。

## 概述

`binds {}` 段落定义了所有键盘快捷键绑定。niri使用基于列的平铺窗口管理，键盘绑定反映了这种设计理念。

## 基本结构

```kdl
binds {
    // Mod键通常是Super/Windows键
    Mod+Return { spawn "alacritty"; }
    Mod+Q { close-window; }
    Mod+H { focus-column-left; }
    Mod+L { focus-column-right; }
    Mod+J { focus-window-down; }
    Mod+K { focus-window-up; }
}
```

---

## 按键符号说明

### 修饰键（Modifier Keys）
- **`Mod`** - 通常是Super/Windows键（可配置）
- **`Shift`** - Shift键
- **`Ctrl`** - Ctrl键
- **`Alt`** - Alt键

### 常用按键符号
- **字母**: `A` `B` `C` ... `Z` (大写)
- **数字**: `1` `2` `3` ... `0`
- **功能键**: `F1` `F2` ... `F12`
- **方向键**: `Left` `Right` `Up` `Down`
- **特殊键**:
  - `Return` (回车)
  - `Space` (空格)
  - `Tab` (制表)
  - `Escape` (ESC)
  - `BackSpace` (退格)
  - `Delete` (删除)
  - `Insert` (插入)
  - `Home` `End` `Page_Up` `Page_Down`

### 组合键语法
```kdl
// 单修饰键
Mod+Return { spawn "terminal"; }

// 多修饰键（用+连接）
Mod+Shift+Q { quit; }
Ctrl+Alt+T { spawn "terminal"; }

// 无修饰键（直接按键名）
Print { screenshot; }
XF86AudioMute { spawn "amixer" "set" "Master" "toggle"; }
```

---

## 窗口操作绑定

### 窗口创建和销毁

```kdl
binds {
    // 启动应用程序
    Mod+Return { spawn "alacritty"; }           // 启动终端
    Mod+D { spawn "rofi" "-show" "drun"; }      // 启动应用启动器

    // 关闭窗口
    Mod+Q { close-window; }                     // 关闭当前窗口
    Mod+Shift+Q { quit; }                       // 退出niri
}
```

### 窗口聚焦

```kdl
binds {
    // 列级聚焦
    Mod+H { focus-column-left; }                // 聚焦左列
    Mod+L { focus-column-right; }               // 聚焦右列
    Mod+Left { focus-column-left; }             // 同上，方向键版本
    Mod+Right { focus-column-right; }           // 同上

    // 窗口级聚焦
    Mod+J { focus-window-down; }                // 聚焦下方窗口
    Mod+K { focus-window-up; }                  // 聚焦上方窗口
    Mod+Down { focus-window-down; }             // 同上，方向键版本
    Mod+Up { focus-window-up; }                 // 同上

    // 工作区内聚焦
    Mod+Tab { focus-window-down-or-column-right; }    // 向下或向右聚焦
    Mod+Shift+Tab { focus-window-up-or-column-left; } // 向上或向左聚焦

    // 特殊聚焦
    Mod+Home { focus-column-first; }            // 聚焦第一列
    Mod+End { focus-column-last; }              // 聚焦最后一列
}
```

#### 聚焦命令详解

**列聚焦命令**:
- `focus-column-left` - 聚焦左侧列，到达边界时循环到最右列
- `focus-column-right` - 聚焦右侧列，到达边界时循环到最左列
- `focus-column-first` - 直接聚焦第一列（最左）
- `focus-column-last` - 直接聚焦最后一列（最右）

**窗口聚焦命令**:
- `focus-window-up` - 聚焦列内上方窗口，到达顶部时循环到底部
- `focus-window-down` - 聚焦列内下方窗口，到达底部时循环到顶部

**组合聚焦命令**:
- `focus-window-down-or-column-right` - 优先向下聚焦，列内无下方窗口则向右聚焦列
- `focus-window-up-or-column-left` - 优先向上聚焦，列内无上方窗口则向左聚焦列

### 窗口移动

```kdl
binds {
    // 列内移动
    Mod+Shift+J { move-window-down; }           // 窗口下移
    Mod+Shift+K { move-window-up; }             // 窗口上移
    Mod+Shift+Down { move-window-down; }        // 同上，方向键版本
    Mod+Shift+Up { move-window-up; }            // 同上

    // 跨列移动
    Mod+Shift+H { move-column-left; }           // 整列左移
    Mod+Shift+L { move-column-right; }          // 整列右移
    Mod+Shift+Left { move-column-left; }        // 同上，方向键版本
    Mod+Shift+Right { move-column-right; }      // 同上

    // 窗口移动到新列
    Mod+Ctrl+H { move-window-to-column-left; }  // 移动到左侧列
    Mod+Ctrl+L { move-window-to-column-right; } // 移动到右侧列

    // 特殊移动
    Mod+Shift+Home { move-column-to-first; }    // 移动列到最左
    Mod+Shift+End { move-column-to-last; }      // 移动列到最右

    Mod+Ctrl+J { move-window-down-or-to-workspace-down; }   // 向下移动或移到下方工作区
    Mod+Ctrl+K { move-window-up-or-to-workspace-up; }       // 向上移动或移到上方工作区
}
```

#### 移动命令详解

**窗口级移动**:
- `move-window-up` - 在当前列内向上移动窗口
- `move-window-down` - 在当前列内向下移动窗口
- `move-window-to-column-left` - 移动窗口到左侧列（如无则创建）
- `move-window-to-column-right` - 移动窗口到右侧列（如无则创建）

**列级移动**:
- `move-column-left` - 移动整列向左
- `move-column-right` - 移动整列向右
- `move-column-to-first` - 移动列到第一位置
- `move-column-to-last` - 移动列到最后位置

**跨工作区移动**:
- `move-window-down-or-to-workspace-down` - 列内向下移动，无空间时移动到下方工作区
- `move-window-up-or-to-workspace-up` - 列内向上移动，无空间时移动到上方工作区

---

## 窗口大小调整

### 列宽度调整

```kdl
binds {
    // 基本调整
    Mod+R { switch-preset-column-width; }       // 切换预设列宽
    Mod+Shift+R { reset-window-height; }        // 重置窗口高度

    // 精细调整
    Mod+Minus { set-column-width "-10%"; }      // 列宽减少10%
    Mod+Equal { set-column-width "+10%"; }      // 列宽增加10%

    // 固定宽度设置
    Mod+Shift+Minus { set-column-width "50%"; } // 设为50%宽度
    Mod+Shift+Equal { set-column-width "1920"; } // 设为1920像素宽度
}
```

#### set-column-width 参数详解

**相对调整（推荐）**:
```kdl
Mod+Minus { set-column-width "-10%"; }    // 减少10%
Mod+Equal { set-column-width "+10%"; }    // 增加10%
Mod+Comma { set-column-width "-5%"; }     // 减少5%（精细调整）
Mod+Period { set-column-width "+5%"; }    // 增加5%（精细调整）
```

**绝对百分比**:
```kdl
Mod+1 { set-column-width "25%"; }         // 设为25%宽度
Mod+2 { set-column-width "33%"; }         // 设为33%宽度
Mod+3 { set-column-width "50%"; }         // 设为50%宽度
Mod+4 { set-column-width "66%"; }         // 设为66%宽度
Mod+5 { set-column-width "75%"; }         // 设为75%宽度
```

**固定像素值**:
```kdl
Mod+Ctrl+1 { set-column-width "320"; }    // 320像素（侧边栏）
Mod+Ctrl+2 { set-column-width "640"; }    // 640像素（中等）
Mod+Ctrl+3 { set-column-width "1280"; }   // 1280像素（宽列）
```

### 窗口高度调整

```kdl
binds {
    // 高度调整
    Mod+Shift+Minus { set-window-height "-10%"; }  // 减少高度10%
    Mod+Shift+Equal { set-window-height "+10%"; }  // 增加高度10%

    // 重置高度
    Mod+Shift+R { reset-window-height; }           // 重置为自动高度
}
```

#### set-window-height 参数详解

**相对调整**:
```kdl
Mod+Shift+Minus { set-window-height "-10%"; }    // 减少10%
Mod+Shift+Equal { set-window-height "+10%"; }    // 增加10%
Mod+Ctrl+Minus { set-window-height "-5%"; }      // 减少5%（精细）
Mod+Ctrl+Equal { set-window-height "+5%"; }      // 增加5%（精细）
```

**绝对百分比**:
```kdl
Mod+Ctrl+1 { set-window-height "25%"; }          // 四分之一高度
Mod+Ctrl+2 { set-window-height "50%"; }          // 一半高度
Mod+Ctrl+3 { set-window-height "75%"; }          // 四分之三高度
```

### 预设宽度切换

```kdl
binds {
    Mod+R { switch-preset-column-width; }         // 顺序切换预设宽度

    // 如果配置了多个预设宽度，会按顺序循环
    // 例如: 33% -> 50% -> 66% -> 33% -> ...
}
```

---

## 工作区操作

### 工作区切换

```kdl
binds {
    // 数字工作区切换
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    // ... 继续到 Mod+9

    // 相对工作区切换
    Mod+Page_Down { focus-workspace-down; }         // 下一个工作区
    Mod+Page_Up { focus-workspace-up; }             // 上一个工作区
    Mod+U { focus-workspace-down; }                 // 同上，VI风格
    Mod+I { focus-workspace-up; }                   // 同上，VI风格

    // 工作区创建
    Mod+Shift+Page_Down { move-to-workspace-down; } // 移动到下方工作区（创建如无）
    Mod+Shift+Page_Up { move-to-workspace-up; }     // 移动到上方工作区（创建如无）
}
```

#### 工作区命令详解

**数字工作区**:
- `focus-workspace N` - 切换到工作区N，N为1-9
- 如果工作区不存在会自动创建

**相对工作区**:
- `focus-workspace-up` - 切换到上方工作区
- `focus-workspace-down` - 切换到下方工作区
- `move-to-workspace-up` - 移动当前窗口到上方工作区
- `move-to-workspace-down` - 移动当前窗口到下方工作区

### 窗口移动到工作区

```kdl
binds {
    // 移动到数字工作区
    Mod+Shift+1 { move-to-workspace 1; }
    Mod+Shift+2 { move-to-workspace 2; }
    // ... 继续到 Mod+Shift+9

    // 移动并跟随
    Mod+Ctrl+Shift+1 { move-to-workspace 1; focus-workspace 1; }

    // 移动到相对工作区
    Mod+Ctrl+Page_Down { move-column-to-workspace-down; }  // 移动整列到下方工作区
    Mod+Ctrl+Page_Up { move-column-to-workspace-up; }      // 移动整列到上方工作区
}
```

---

## 显示器操作

### 显示器聚焦

```kdl
binds {
    // 显示器切换
    Mod+Shift+H { focus-monitor-left; }         // 聚焦左侧显示器
    Mod+Shift+L { focus-monitor-right; }        // 聚焦右侧显示器
    Mod+Shift+J { focus-monitor-down; }         // 聚焦下方显示器
    Mod+Shift+K { focus-monitor-up; }           // 聚焦上方显示器

    // 方向键版本
    Mod+Ctrl+Left { focus-monitor-left; }
    Mod+Ctrl+Right { focus-monitor-right; }
    Mod+Ctrl+Down { focus-monitor-down; }
    Mod+Ctrl+Up { focus-monitor-up; }
}
```

### 窗口移动到显示器

```kdl
binds {
    // 移动窗口到其他显示器
    Mod+Shift+Ctrl+H { move-window-to-monitor-left; }    // 移动到左侧显示器
    Mod+Shift+Ctrl+L { move-window-to-monitor-right; }   // 移动到右侧显示器
    Mod+Shift+Ctrl+J { move-window-to-monitor-down; }    // 移动到下方显示器
    Mod+Shift+Ctrl+K { move-window-to-monitor-up; }      // 移动到上方显示器

    // 移动列到其他显示器
    Mod+Ctrl+Alt+H { move-column-to-monitor-left; }      // 移动整列到左侧显示器
    Mod+Ctrl+Alt+L { move-column-to-monitor-right; }     // 移动整列到右侧显示器
}
```

---

## 模式切换

### 总览模式（Overview）

```kdl
binds {
    Mod+Tab { overview-toggle; }               // 切换总览模式
    Mod+Grave { overview-toggle; }             // 同上，使用~键

    // 总览模式内的导航（Since 25.05）
    Mod+H { overview-focus-left; }             // 总览中向左导航
    Mod+L { overview-focus-right; }            // 总览中向右导航
    Mod+J { overview-focus-down; }             // 总览中向下导航
    Mod+K { overview-focus-up; }               // 总览中向上导航
}
```

### 全屏模式

```kdl
binds {
    Mod+F { fullscreen-window; }               // 切换全屏模式
    F11 { fullscreen-window; }                 // 传统全屏键

    Mod+Shift+F { maximize-window; }           // 最大化窗口（伪全屏）
}
```

#### 全屏模式说明
- **`fullscreen-window`** - 真全屏，隐藏所有UI元素
- **`maximize-window`** - 最大化，窗口填满可用空间但保留边框/标题栏

### 悬浮模式

```kdl
binds {
    Mod+Shift+Space { toggle-window-floating; } // 切换窗口悬浮状态

    // 悬浮窗口的移动（Since 25.05）
    Mod+Ctrl+H { move-window-left; }             // 悬浮窗口向左移动
    Mod+Ctrl+L { move-window-right; }            // 悬浮窗口向右移动
    Mod+Ctrl+J { move-window-down; }             // 悬浮窗口向下移动
    Mod+Ctrl+K { move-window-up; }               // 悬浮窗口向上移动
}
```

---

## 系统操作

### 应用启动

```kdl
binds {
    // 常用应用
    Mod+Return { spawn "alacritty"; }                    // 终端
    Mod+E { spawn "nautilus"; }                          // 文件管理器
    Mod+W { spawn "firefox"; }                           // 浏览器

    // 应用启动器
    Mod+D { spawn "rofi" "-show" "drun"; }              // 应用启动器
    Mod+Shift+D { spawn "rofi" "-show" "run"; }         // 命令启动器
    Mod+Period { spawn "rofimoji"; }                     // 表情符号选择器

    // 系统工具
    Mod+V { spawn "cliphist" "list" "|" "rofi" "-dmenu"; }  // 剪贴板历史
    Print { spawn "grimshot" "copy" "area"; }                // 区域截图
    Mod+Print { spawn "grimshot" "copy" "screen"; }         // 全屏截图
}
```

### spawn 命令详解

```kdl
// 单个命令
Mod+Return { spawn "alacritty"; }

// 命令 + 参数
Mod+D { spawn "rofi" "-show" "drun"; }

// 复杂命令（Shell管道等）
Mod+V { spawn "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }

// 带环境变量的命令
Mod+Shift+Return { spawn "env" "TERM=xterm-256color" "alacritty"; }
```

### 屏幕截图

```kdl
binds {
    // 交互式截图
    Print { spawn "grimshot" "copy" "area"; }            // 选择区域截图到剪贴板
    Mod+Print { spawn "grimshot" "copy" "screen"; }      // 全屏截图到剪贴板
    Shift+Print { spawn "grimshot" "save" "area"; }      // 选择区域截图到文件

    // 窗口截图
    Alt+Print { spawn "grimshot" "copy" "active"; }      // 活动窗口截图到剪贴板

    // 延时截图
    Ctrl+Print { spawn "sleep" "3" "&&" "grimshot" "copy" "screen"; }  // 3秒延时全屏截图
}
```

### 音频控制

```kdl
binds {
    // 音量控制
    XF86AudioRaiseVolume { spawn "amixer" "set" "Master" "5%+"; }     // 音量+
    XF86AudioLowerVolume { spawn "amixer" "set" "Master" "5%-"; }     // 音量-
    XF86AudioMute { spawn "amixer" "set" "Master" "toggle"; }         // 静音切换

    // 多媒体控制
    XF86AudioPlay { spawn "playerctl" "play-pause"; }                 // 播放/暂停
    XF86AudioNext { spawn "playerctl" "next"; }                       // 下一首
    XF86AudioPrev { spawn "playerctl" "previous"; }                   // 上一首

    // 麦克风控制
    XF86AudioMicMute { spawn "amixer" "set" "Capture" "toggle"; }     // 麦克风静音
}
```

### 亮度控制

```kdl
binds {
    // 屏幕亮度
    XF86MonBrightnessUp { spawn "brightnessctl" "set" "10%+"; }       // 亮度+
    XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }     // 亮度-

    // 键盘背光
    XF86KbdBrightnessUp { spawn "brightnessctl" "-d" "kbd_backlight" "set" "10%+"; }
    XF86KbdBrightnessDown { spawn "brightnessctl" "-d" "kbd_backlight" "set" "10%-"; }
}
```

### 系统控制

```kdl
binds {
    // 系统操作
    Mod+Shift+E { spawn "systemctl" "poweroff"; }                     // 关机
    Mod+Shift+R { spawn "systemctl" "reboot"; }                       // 重启
    Mod+Shift+S { spawn "systemctl" "suspend"; }                      // 休眠

    // 锁屏
    Mod+Escape { spawn "swaylock"; }                                   // 锁屏

    // niri操作
    Mod+Shift+Q { quit; }                                              // 退出niri
    Mod+Shift+C { reload-config; }                                     // 重新加载配置
}
```

---

## 调试和诊断

### 调试命令

```kdl
binds {
    // niri调试
    Mod+Shift+P { debug-toogle-damage; }                              // 切换损坏区域显示
    Mod+Shift+Ctrl+P { debug-toggle-opaque-regions; }                // 切换不透明区域显示

    // 配置相关
    Mod+Shift+C { reload-config; }                                    // 重新加载配置
    Mod+Shift+Ctrl+T { toggle-debug-tint; }                          // 切换调试着色
}
```

### 实用调试绑定

```kdl
binds {
    // 显示窗口信息
    Mod+Shift+I { spawn "notify-send" "$(niri msg focused-window)"; } // 显示当前窗口信息

    // 显示所有工作区
    Mod+Shift+W { spawn "notify-send" "$(niri msg workspaces)"; }     // 显示工作区状态

    // 显示所有输出
    Mod+Shift+O { spawn "notify-send" "$(niri msg outputs)"; }        // 显示显示器信息
}
```

---

## 完整配置示例

### 1. 基础配置

```kdl
binds {
    // 应用启动
    Mod+Return { spawn "alacritty"; }
    Mod+D { spawn "rofi" "-show" "drun"; }

    // 窗口操作
    Mod+Q { close-window; }
    Mod+H { focus-column-left; }
    Mod+L { focus-column-right; }
    Mod+J { focus-window-down; }
    Mod+K { focus-window-up; }

    // 工作区
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }

    // 基础功能
    Mod+F { fullscreen-window; }
    Mod+R { switch-preset-column-width; }
    Print { spawn "grimshot" "copy" "area"; }

    // 系统
    Mod+Shift+Q { quit; }
    XF86AudioMute { spawn "amixer" "set" "Master" "toggle"; }
}
```

### 2. 高级配置

```kdl
binds {
    // === 应用启动 ===
    Mod+Return { spawn "alacritty"; }
    Mod+Shift+Return { spawn "foot"; }
    Mod+E { spawn "nautilus"; }
    Mod+W { spawn "firefox"; }
    Mod+D { spawn "rofi" "-show" "drun"; }
    Mod+Shift+D { spawn "rofi" "-show" "run"; }
    Mod+Period { spawn "rofimoji"; }
    Mod+V { spawn "cliphist" "list" "|" "rofi" "-dmenu" "|" "cliphist" "decode" "|" "wl-copy"; }

    // === 窗口操作 ===
    // 关闭
    Mod+Q { close-window; }
    Mod+Shift+Q { quit; }

    // 聚焦
    Mod+H { focus-column-left; }
    Mod+L { focus-column-right; }
    Mod+J { focus-window-down; }
    Mod+K { focus-window-up; }
    Mod+Left { focus-column-left; }
    Mod+Right { focus-column-right; }
    Mod+Down { focus-window-down; }
    Mod+Up { focus-window-up; }

    // 移动
    Mod+Shift+H { move-column-left; }
    Mod+Shift+L { move-column-right; }
    Mod+Shift+J { move-window-down; }
    Mod+Shift+K { move-window-up; }
    Mod+Ctrl+H { move-window-to-column-left; }
    Mod+Ctrl+L { move-window-to-column-right; }

    // 大小调整
    Mod+R { switch-preset-column-width; }
    Mod+Shift+R { reset-window-height; }
    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }
    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    // === 工作区操作 ===
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }

    Mod+Shift+1 { move-to-workspace 1; }
    Mod+Shift+2 { move-to-workspace 2; }
    Mod+Shift+3 { move-to-workspace 3; }
    Mod+Shift+4 { move-to-workspace 4; }
    Mod+Shift+5 { move-to-workspace 5; }
    Mod+Shift+6 { move-to-workspace 6; }
    Mod+Shift+7 { move-to-workspace 7; }
    Mod+Shift+8 { move-to-workspace 8; }
    Mod+Shift+9 { move-to-workspace 9; }

    Mod+Page_Down { focus-workspace-down; }
    Mod+Page_Up { focus-workspace-up; }
    Mod+Shift+Page_Down { move-to-workspace-down; }
    Mod+Shift+Page_Up { move-to-workspace-up; }

    // === 模式切换 ===
    Mod+Tab { overview-toggle; }
    Mod+F { fullscreen-window; }
    Mod+Shift+F { maximize-window; }
    Mod+Shift+Space { toggle-window-floating; }

    // === 多显示器 ===
    Mod+Ctrl+Left { focus-monitor-left; }
    Mod+Ctrl+Right { focus-monitor-right; }
    Mod+Shift+Ctrl+H { move-window-to-monitor-left; }
    Mod+Shift+Ctrl+L { move-window-to-monitor-right; }

    // === 屏幕截图 ===
    Print { spawn "grimshot" "copy" "area"; }
    Mod+Print { spawn "grimshot" "copy" "screen"; }
    Shift+Print { spawn "grimshot" "save" "area"; }
    Alt+Print { spawn "grimshot" "copy" "active"; }

    // === 音频控制 ===
    XF86AudioRaiseVolume { spawn "amixer" "set" "Master" "5%+"; }
    XF86AudioLowerVolume { spawn "amixer" "set" "Master" "5%-"; }
    XF86AudioMute { spawn "amixer" "set" "Master" "toggle"; }
    XF86AudioPlay { spawn "playerctl" "play-pause"; }
    XF86AudioNext { spawn "playerctl" "next"; }
    XF86AudioPrev { spawn "playerctl" "previous"; }

    // === 亮度控制 ===
    XF86MonBrightnessUp { spawn "brightnessctl" "set" "10%+"; }
    XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }

    // === 系统控制 ===
    Mod+Shift+E { spawn "systemctl" "poweroff"; }
    Mod+Shift+R { spawn "systemctl" "reboot"; }
    Mod+Escape { spawn "swaylock"; }
    Mod+Shift+C { reload-config; }
}
```

### 3. VI风格配置

```kdl
binds {
    // VI风格导航
    Mod+H { focus-column-left; }
    Mod+J { focus-window-down; }
    Mod+K { focus-window-up; }
    Mod+L { focus-column-right; }

    // VI风格移动
    Mod+Shift+H { move-column-left; }
    Mod+Shift+J { move-window-down; }
    Mod+Shift+K { move-window-up; }
    Mod+Shift+L { move-column-right; }

    // VI风格工作区
    Mod+Ctrl+H { focus-workspace-up; }    // 上方工作区
    Mod+Ctrl+L { focus-workspace-down; }  // 下方工作区

    // VI风格大小调整
    Mod+Minus { set-column-width "-5%"; }   // 精细调整
    Mod+Equal { set-column-width "+5%"; }   // 精细调整

    // 其他保持标准
    Mod+Return { spawn "alacritty"; }
    Mod+Q { close-window; }
    Mod+D { spawn "rofi" "-show" "drun"; }
    Print { spawn "grimshot" "copy" "area"; }
}
```

---

## 自定义技巧

### 1. 应用快速启动

```kdl
binds {
    // 常用应用组合键
    Mod+Ctrl+T { spawn "alacritty"; }               // 终端
    Mod+Ctrl+F { spawn "nautilus"; }               // 文件管理器
    Mod+Ctrl+B { spawn "firefox"; }                // 浏览器
    Mod+Ctrl+C { spawn "code"; }                   // 编辑器
    Mod+Ctrl+M { spawn "thunderbird"; }            // 邮件客户端

    // 系统工具
    Mod+Ctrl+S { spawn "pavucontrol"; }            // 音频控制
    Mod+Ctrl+N { spawn "nm-connection-editor"; }   // 网络管理
    Mod+Ctrl+P { spawn "gnome-system-monitor"; }   // 系统监控
}
```

### 2. 工作流快捷键

```kdl
binds {
    // 开发环境快速启动
    Mod+Alt+D { spawn "sh" "-c" "alacritty & code & firefox"; }  // 开发三件套

    // 会议模式
    Mod+Alt+M { spawn "sh" "-c" "zoom & obs & pavucontrol"; }    // 会议工具

    // 专注模式（关闭通知等）
    Mod+Alt+F { spawn "makoctl" "mode" "-a" "do-not-disturb"; }  // 免打扰模式
    Mod+Alt+Shift+F { spawn "makoctl" "mode" "-r" "do-not-disturb"; } // 取消免打扰
}
```

### 3. 条件操作

```kdl
binds {
    // 智能截图（根据状态选择工具）
    Print { spawn "sh" "-c" "if pgrep rofi; then grimshot copy area; else rofi-screenshot; fi"; }

    // 智能锁屏（检查是否有全屏应用）
    Mod+Escape { spawn "sh" "-c" "if niri msg focused-window | grep -q fullscreen; then echo 'Skip lock'; else swaylock; fi"; }
}
```

### 4. 链式命令

```kdl
binds {
    // 启动应用并切换工作区
    Mod+Alt+1 { spawn "firefox"; focus-workspace 1; }
    Mod+Alt+2 { spawn "code"; focus-workspace 2; }
    Mod+Alt+3 { spawn "alacritty"; focus-workspace 3; }

    // 移动窗口并跟随
    Mod+Ctrl+1 { move-to-workspace 1; focus-workspace 1; }
    Mod+Ctrl+2 { move-to-workspace 2; focus-workspace 2; }
}
```

---

## 故障排除

### 常见问题

1. **快捷键不响应**
   - 检查按键名称是否正确（大小写敏感）
   - 确认没有被其他应用占用
   - 使用 `niri validate` 检查配置语法

2. **应用无法启动**
   - 检查应用是否已安装
   - 确认命令路径是否正确
   - 查看niri日志了解具体错误

3. **修饰键问题**
   - 确认Mod键设置（通常在input配置中）
   - 检查键盘布局设置
   - 测试其他修饰键组合

### 调试方法

```kdl
binds {
    // 测试快捷键是否工作
    Mod+F1 { spawn "notify-send" "Key binding works!"; }

    // 显示当前配置状态
    Mod+F2 { spawn "notify-send" "$(niri msg version)"; }

    // 重新加载配置并提示
    Mod+Shift+C { reload-config; spawn "notify-send" "Config reloaded"; }
}
```

这样可以快速验证绑定是否正常工作，并在出现问题时进行调试。
