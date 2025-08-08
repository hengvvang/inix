# Niri Window Rules 窗口规则配置详解

本文档详细介绍niri中 `window-rule {}` 段落的所有配置选项。窗口规则允许为特定应用程序或窗口设置自定义行为。

## 概述

窗口规则基于匹配条件自动应用设置，可以控制窗口的默认大小、位置、行为等特性。每个规则包含匹配条件和要应用的操作。

## 基本结构

```kdl
window-rule {
    // 匹配条件
    match app-id="firefox"

    // 应用的操作
    default-column-width { proportion 0.75 }
    open-maximized true
}

window-rule {
    match title="Picture-in-Picture"
    open-floating true
    min-width 320
    min-height 240
}
```

---

## 匹配条件

### 基本匹配属性

#### app-id - 应用程序ID匹配

```kdl
window-rule {
    match app-id="firefox"                    // 精确匹配
    match app-id="^fire"                      // 正则：以fire开头
    match app-id="fox$"                       // 正则：以fox结尾
    match app-id="^org\.gnome\.Nautilus$"     // 完整应用ID
    match app-id="code|codium"                // 正则：多个值
}
```

- **类型**: 字符串（支持正则表达式）
- **含义**: 匹配应用程序的Wayland app-id
- **获取方法**: 使用 `niri msg focused-window` 查看当前窗口app-id

**常见应用app-id**:
- **Firefox**: `firefox`
- **Chrome**: `google-chrome` 或 `chromium`
- **VSCode**: `code`
- **Nautilus**: `org.gnome.Nautilus`
- **Alacritty**: `Alacritty`
- **GIMP**: `gimp-2.10`

#### title - 窗口标题匹配

```kdl
window-rule {
    match title="Picture-in-Picture"          // 精确匹配
    match title="^New Tab"                    // 正则：以"New Tab"开头
    match title="Settings$"                   // 正则：以"Settings"结尾
    match title="[Ss]ettings"                 // 正则：Settings或settings
    match title=".*编辑器.*"                  // 正则：包含"编辑器"
}
```

- **类型**: 字符串（支持正则表达式）
- **含义**: 匹配窗口的标题栏文本
- **动态性**: 窗口标题可能动态变化
- **获取方法**: 使用 `niri msg focused-window` 查看当前窗口标题

#### class - 窗口类名匹配（X11应用）

```kdl
window-rule {
    match class="Firefox"                     // Firefox类名
    match class="^Code"                       // 以Code开头的类名
    match class="jetbrains-.*"                // JetBrains系列IDE
}
```

- **类型**: 字符串（支持正则表达式）
- **含义**: 匹配X11应用的WM_CLASS
- **适用**: 主要用于X11应用程序
- **Wayland**: Wayland原生应用通常不设置class

### 组合匹配条件

#### 多条件AND逻辑

```kdl
window-rule {
    match app-id="firefox" title="Picture-in-Picture"
    // 同时满足app-id是firefox且标题包含Picture-in-Picture
    open-floating true
}

window-rule {
    match app-id="code" class="Code"
    // VSCode在XWayland下运行时的匹配
    default-column-width { proportion 0.6 }
}
```

#### 正则表达式匹配

```kdl
window-rule {
    // 匹配所有浏览器
    match app-id="firefox|chromium|google-chrome"
    default-column-width { proportion 0.75 }
}

window-rule {
    // 匹配开发相关应用
    match app-id="^(code|vim|emacs|jetbrains-).*"
    open-on-output "DP-2"  // 在指定显示器打开
}

window-rule {
    // 匹配对话框窗口
    match title=".*[Dd]ialog.*|.*设置.*|.*Setting.*"
    open-floating true
    open-centered true
}
```

---

## 窗口大小设置

### 默认列宽

#### default-column-width - 默认列宽度

```kdl
window-rule {
    match app-id="firefox"
    default-column-width { proportion 0.75 }    // 75%宽度
}

window-rule {
    match app-id="thunderbird"
    default-column-width { fixed 1200 }         // 1200像素固定宽度
}
```

- **类型**: 宽度对象（proportion 或 fixed）
- **作用**: 设置窗口所在列的默认宽度
- **继承**: 使用与全局preset-column-widths相同的格式

### 窗口大小约束

#### min-width / max-width - 宽度约束

```kdl
window-rule {
    match title="Picture-in-Picture"
    min-width 320                            // 最小宽度320像素
    max-width 800                            // 最大宽度800像素
}

window-rule {
    match app-id="calculator"
    min-width 300
    max-width 400                            // 限制计算器大小范围
}
```

#### min-height / max-height - 高度约束

```kdl
window-rule {
    match app-id="spotify"
    min-height 600                           // 音乐播放器最小高度
    max-height 1000                          // 最大高度
}

window-rule {
    match title=".*密码.*|.*Password.*"
    min-height 400
    max-height 600                           // 密码管理器合适高度
}
```

- **类型**: 整数（逻辑像素）
- **作用**: 限制窗口可调整的大小范围
- **优先级**: 高于应用程序自身的大小提示

---

## 窗口打开行为

### 打开状态

#### open-maximized - 最大化打开

```kdl
window-rule {
    match app-id="gimp-2.10"
    open-maximized true                      // GIMP启动时最大化
}

window-rule {
    match app-id="libreoffice-.*"
    open-maximized true                      // LibreOffice系列最大化
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 窗口打开时自动最大化（填满可用空间）

#### open-fullscreen - 全屏打开

```kdl
window-rule {
    match app-id="mpv"
    open-fullscreen true                     // 视频播放器全屏打开
}

window-rule {
    match title=".*游戏.*|.*Game.*"
    open-fullscreen true                     // 游戏应用全屏
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 窗口打开时进入全屏模式

### 悬浮窗口设置

#### open-floating - 悬浮打开

```kdl
window-rule {
    match title="Picture-in-Picture"
    open-floating true                       // 画中画悬浮
}

window-rule {
    match app-id="pavucontrol"
    open-floating true                       // 音量控制悬浮
}

window-rule {
    match title=".*[Dd]ialog.*|.*对话框.*"
    open-floating true                       // 对话框悬浮
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 窗口以悬浮模式打开，不参与平铺布局

#### open-centered - 居中打开

```kdl
window-rule {
    match app-id="calculator"
    open-floating true
    open-centered true                       // 计算器居中悬浮
}

window-rule {
    match title=".*设置.*|.*Settings.*"
    open-floating true
    open-centered true                       // 设置窗口居中
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 悬浮窗口在屏幕中央打开
- **前提**: 需要配合 `open-floating true` 使用

---

## 位置和显示器设置

### 输出设备指定

#### open-on-output - 指定显示器

```kdl
window-rule {
    match app-id="firefox"
    open-on-output "HDMI-A-1"               // 在HDMI显示器打开浏览器
}

window-rule {
    match app-id="code"
    open-on-output "Dell Inc. U2720Q EXAMPLE123"  // 在4K显示器打开编辑器
}
```

- **类型**: 字符串（输出名称）
- **格式**: 连接器名称或"厂商 型号 序列号"
- **获取方法**: 使用 `niri msg outputs` 查看可用输出
- **回退**: 如果指定输出不可用，使用默认输出

### 工作区指定

#### open-on-workspace - 指定工作区

```kdl
window-rule {
    match app-id="thunderbird"
    open-on-workspace 2                      // 邮件客户端在工作区2打开
}

window-rule {
    match app-id="spotify"
    open-on-workspace 9                      // 音乐播放器在工作区9
}
```

- **类型**: 整数（工作区编号）
- **范围**: 1-9
- **创建**: 如果工作区不存在会自动创建
- **组合**: 可与 `open-on-output` 组合使用

---

## 特殊功能设置

### 可变刷新率

#### variable-refresh-rate - VRR支持

```kdl
window-rule {
    match app-id="mpv"
    variable-refresh-rate true               // 视频播放启用VRR
}

window-rule {
    match app-id="steam" title=".*游戏中.*"
    variable-refresh-rate true               // 游戏中启用VRR
}
```

- **类型**: 布尔值
- **前提**: 显示器和显卡支持VRR
- **配合**: 需要output配置中启用 `variable-refresh-rate on-demand=true`
- **作用**: 为特定应用启用可变刷新率

### 窗口装饰

#### draw-border-with-background - 边框背景

```kdl
window-rule {
    match app-id="alacritty"
    draw-border-with-background false        // 终端不绘制边框背景
}
```

- **类型**: 布尔值
- **默认值**: true
- **作用**: 控制是否为窗口边框绘制背景色
- **视觉**: false时边框更加简洁

### 阴影效果（Since 25.05）

#### shadow - 窗口阴影

```kdl
window-rule {
    match open-floating=true                 // 匹配所有悬浮窗口
    shadow {
        blur-sigma 8                         // 阴影模糊程度
        color "#00000080"                    // 半透明黑色阴影
        dx 0                                 // 水平偏移
        dy 4                                 // 垂直偏移
    }
}
```

#### 阴影参数详解

**blur-sigma - 模糊程度**
```kdl
shadow {
    blur-sigma 4     // 轻微模糊
    blur-sigma 8     // 标准模糊
    blur-sigma 16    // 强烈模糊
}
```

**color - 阴影颜色**
```kdl
shadow {
    color "#000000"     // 纯黑色
    color "#00000080"   // 50%透明黑色
    color "#333333cc"   // 深灰色，80%透明度
}
```

**dx, dy - 偏移量**
```kdl
shadow {
    dx 0   dy 4     // 向下偏移
    dx 2   dy 2     // 右下偏移
    dx -2  dy -2    // 左上偏移（立体感）
}
```

---

## 条件匹配高级技巧

### 特殊匹配条件（Since 25.05）

#### 匹配窗口状态

```kdl
window-rule {
    match is-focused=true                    // 匹配当前聚焦窗口
    border {
        width 4
        active-color "#ff0000"               // 聚焦窗口红色边框
    }
}

window-rule {
    match is-floating=true                   // 匹配悬浮窗口
    shadow {
        blur-sigma 12
        color "#00000060"
        dx 0 dy 8
    }
}
```

#### 匹配窗口大小

```kdl
window-rule {
    match at-startup=true                    // 匹配启动时的窗口
    open-centered true
    default-column-width { proportion 0.5 }
}
```

### 复杂正则表达式

#### 排除匹配

```kdl
window-rule {
    // 匹配所有浏览器，但排除开发者工具
    match app-id="firefox|chromium" title="^(?!.*[Dd]ev[Tt]ools).*"
    default-column-width { proportion 0.75 }
}
```

#### 多语言支持

```kdl
window-rule {
    // 匹配多语言设置窗口
    match title="Settings|设置|設定|Paramètres|Einstellungen"
    open-floating true
    open-centered true
    min-width 600
    min-height 400
}
```

#### 动态匹配

```kdl
window-rule {
    // 匹配包含特定关键词的任何应用
    match title=".*[Pp]assword.*|.*密码.*|.*パスワード.*"
    open-floating true
    max-width 500
    max-height 300
}
```

---

## 应用场景配置示例

### 1. 开发环境配置

```kdl
// 代码编辑器
window-rule {
    match app-id="code|codium|vim|emacs"
    default-column-width { proportion 0.6 }
    open-on-output "Dell U2720Q"            // 主显示器
    open-maximized true
}

// 终端
window-rule {
    match app-id="alacritty|foot|gnome-terminal"
    default-column-width { proportion 0.4 }
    draw-border-with-background false
}

// 浏览器开发者工具
window-rule {
    match app-id="firefox|chromium" title=".*[Dd]ev[Tt]ools.*"
    open-floating true
    min-width 800
    min-height 600
    open-on-output "DP-2"                   // 副显示器
}

// Git GUI工具
window-rule {
    match app-id="gitg|lazygit|gitk"
    default-column-width { fixed 1000 }
    open-centered true
}
```

### 2. 多媒体配置

```kdl
// 视频播放器
window-rule {
    match app-id="mpv|vlc"
    open-fullscreen true
    variable-refresh-rate true
}

// 音乐播放器
window-rule {
    match app-id="spotify|rhythmbox"
    default-column-width { fixed 400 }
    open-on-workspace 9
    min-width 350
    max-width 500
}

// 画中画
window-rule {
    match title="Picture-in-Picture|画中画"
    open-floating true
    min-width 320
    min-height 240
    shadow {
        blur-sigma 8
        color "#00000060"
        dx 0 dy 4
    }
}

// 图像编辑
window-rule {
    match app-id="gimp-.*|krita|inkscape"
    open-maximized true
    open-on-output "HDMI-A-1"              // 色彩显示器
}
```

### 3. 办公软件配置

```kdl
// 办公套件
window-rule {
    match app-id="libreoffice-.*|onlyoffice"
    open-maximized true
    default-column-width { proportion 0.8 }
}

// PDF阅读器
window-rule {
    match app-id="evince|okular|zathura"
    default-column-width { proportion 0.6 }
    open-centered true
}

// 邮件客户端
window-rule {
    match app-id="thunderbird|evolution"
    open-on-workspace 2
    default-column-width { proportion 0.75 }
    open-maximized true
}

// 日历应用
window-rule {
    match app-id="gnome-calendar|korganizer"
    open-on-workspace 2
    default-column-width { fixed 800 }
}
```

### 4. 系统工具配置

```kdl
// 文件管理器
window-rule {
    match app-id="nautilus|thunar|dolphin"
    default-column-width { proportion 0.5 }
    min-width 600
}

// 系统设置
window-rule {
    match app-id="gnome-control-center|systemsettings5"
    open-floating true
    open-centered true
    min-width 800
    min-height 600
}

// 音量控制
window-rule {
    match app-id="pavucontrol"
    open-floating true
    open-centered true
    min-width 400
    max-width 600
}

// 任务管理器
window-rule {
    match app-id="gnome-system-monitor|htop"
    default-column-width { proportion 0.6 }
    open-on-workspace 8
}
```

### 5. 游戏和娱乐配置

```kdl
// Steam
window-rule {
    match app-id="steam"
    open-on-workspace 9
    default-column-width { fixed 1000 }
}

// 游戏应用
window-rule {
    match app-id="steam_app_.*|lutris"
    open-fullscreen true
    variable-refresh-rate true
}

// 聊天应用
window-rule {
    match app-id="discord|telegram|qq"
    open-on-workspace 3
    default-column-width { fixed 400 }
    max-width 600
}

// 视频会议
window-rule {
    match app-id="zoom|teams|meet"
    open-on-workspace 4
    default-column-width { proportion 0.7 }
    variable-refresh-rate true
}
```

---

## 调试和验证

### 获取窗口信息

使用以下命令获取当前窗口的详细信息：

```bash
# 获取当前聚焦窗口信息
niri msg focused-window

# 输出示例：
# Window { id: 123, app_id: Some("firefox"), title: Some("Mozilla Firefox"), ... }
```

### 测试规则配置

```kdl
window-rule {
    match app-id="test-.*"
    // 添加明显的视觉效果用于测试
    open-floating true
    open-centered true
    min-width 400
    min-height 300
    shadow {
        blur-sigma 16
        color "#ff000080"    // 红色阴影便于识别
        dx 0 dy 8
    }
}
```

### 动态调试

```kdl
binds {
    // 快捷键显示当前窗口信息
    Mod+I { spawn "notify-send" "$(niri msg focused-window)"; }

    // 重新加载配置并测试
    Mod+Shift+C { reload-config; spawn "notify-send" "Config reloaded"; }
}
```

---

## 性能优化

### 避免过度匹配

```kdl
// 推荐：精确匹配
window-rule {
    match app-id="firefox"
    default-column-width { proportion 0.75 }
}

// 避免：过于宽泛的匹配
window-rule {
    match title=".*"    // 匹配所有窗口，影响性能
    // ...
}
```

### 合理使用正则表达式

```kdl
// 推荐：简单的多选匹配
window-rule {
    match app-id="firefox|chromium|chrome"
    default-column-width { proportion 0.75 }
}

// 避免：复杂的正则表达式
window-rule {
    match title="^(?=.*[Bb]rowser)(?=.*[Ww]eb).*(?<!private)$"
    // 过于复杂，影响性能和可维护性
}
```

### 规则优先级

窗口规则按照在配置文件中的顺序应用，后面的规则可能覆盖前面的规则。合理组织规则顺序：

```kdl
// 1. 特殊情况规则（优先级高）
window-rule {
    match app-id="firefox" title="Picture-in-Picture"
    open-floating true
}

// 2. 一般情况规则
window-rule {
    match app-id="firefox"
    default-column-width { proportion 0.75 }
}

// 3. 通用规则（优先级低）
window-rule {
    match title=".*[Dd]ialog.*"
    open-floating true
}
```

这样可以确保特殊情况得到正确处理，同时保持配置的可读性和性能。
