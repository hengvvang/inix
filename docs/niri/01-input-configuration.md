# Niri Input 配置详解

本文档详细介绍niri中 `input {}` 段落的所有配置选项。

## 概述

`input {}` 段落用于配置所有输入设备，包括键盘、触控板、鼠标、轨迹点、平板等设备的行为，以及一些全局输入相关的设置。

## 基本结构

```kdl
input {
    keyboard { /* 键盘配置 */ }
    touchpad { /* 触控板配置 */ }
    mouse { /* 鼠标配置 */ }
    trackpoint { /* 轨迹点配置 */ }
    trackball { /* 轨迹球配置 */ }
    tablet { /* 平板配置 */ }
    touch { /* 触屏配置 */ }

    // 全局输入设置
}
```

---

## keyboard {} - 键盘配置

### xkb {} - 键盘布局设置

```kdl
keyboard {
    xkb {
        layout "us"                    // 键盘布局
        variant "colemak_dh_ortho"     // 布局变体
        options "compose:ralt,ctrl:nocaps" // XKB选项
        model ""                       // 键盘型号
        rules ""                       // XKB规则
        file "~/.config/keymap.xkb"    // 直接指定XKB文件 (Since: 25.02)
    }
}
```

#### layout - 键盘布局
- **类型**: 字符串
- **默认值**: 从 systemd-localed 读取
- **可能的值**:
  - `"us"` - 美式英语
  - `"ru"` - 俄语
  - `"de"` - 德语
  - `"fr"` - 法语
  - `"us,ru"` - 多布局（逗号分隔）
  - 等等（完整列表见 `/usr/share/X11/xkb/rules/base.lst`）
- **作用**: 设置键盘的基础布局

#### variant - 布局变体
- **类型**: 字符串
- **默认值**: 空
- **可能的值**:
  - `"colemak"` - Colemak布局
  - `"dvorak"` - Dvorak布局
  - `"colemak_dh_ortho"` - Colemak DH 正交变体
  - 等等（依赖于选择的布局）
- **作用**: 在基础布局上应用特定变体

#### options - XKB选项
- **类型**: 字符串（逗号分隔的选项列表）
- **默认值**: 空
- **常用选项**:
  - `"compose:ralt"` - 右Alt作为Compose键
  - `"ctrl:nocaps"` - 禁用Caps Lock
  - `"caps:escape"` - Caps Lock作为Escape
  - `"ctrl:swapcaps"` - 交换Ctrl和Caps Lock
  - `"grp:alt_shift_toggle"` - Alt+Shift切换布局
  - `"lv3:ralt_switch"` - 右Alt作为第3层修饰符
- **作用**: 自定义键位映射和行为

#### model - 键盘型号
- **类型**: 字符串
- **默认值**: 空（自动检测）
- **可能的值**: `"pc104"`, `"pc105"`, `"apple"` 等
- **作用**: 指定键盘物理型号（很少需要设置）

#### rules - XKB规则
- **类型**: 字符串
- **默认值**: 空
- **可能的值**: `"base"`, `"evdev"` 等
- **作用**: 指定XKB规则集（很少需要设置）

#### file - 直接XKB文件 (Since: 25.02)
- **类型**: 字符串（文件路径）
- **默认值**: 无
- **作用**: 直接指定完整的XKB键盘映射文件，覆盖上述所有XKB设置
- **示例**: `"~/.config/keymap.xkb"`

### 键盘重复设置

```kdl
keyboard {
    repeat-delay 600    // 重复延迟
    repeat-rate 25      // 重复速率
}
```

#### repeat-delay - 重复延迟
- **类型**: 整数（毫秒）
- **默认值**: 600
- **范围**: 通常 200-2000
- **作用**: 按住键后开始重复的延迟时间

#### repeat-rate - 重复速率
- **类型**: 整数（字符/秒）
- **默认值**: 25
- **范围**: 通常 1-100
- **作用**: 键重复的速度

### 其他键盘设置

```kdl
keyboard {
    track-layout "global"    // 布局跟踪模式
    numlock                  // 启用数字锁定 (Since: 25.05)
}
```

#### track-layout - 布局跟踪模式
- **类型**: 字符串
- **默认值**: `"global"`
- **可能的值**:
  - `"global"` - 全局布局，所有窗口共享当前布局
  - `"window"` - 每窗口布局，每个窗口记住自己的布局
- **作用**: 控制多布局时的切换行为

#### numlock - 数字锁定 (Since: 25.05)
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 启动时自动开启数字锁定
- **注意**: 对于笔记本键盘（数字键覆盖在字母键上）可能不适合

---

## 指针设备通用配置

以下选项适用于 `touchpad`, `mouse`, `trackpoint`, `trackball`：

### 基本开关

```kdl
touchpad {
    off    // 完全禁用设备
}
```

#### off - 禁用设备
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 完全禁用该类型的所有设备，不发送任何事件

### 滚动设置

```kdl
touchpad {
    natural-scroll          // 自然滚动
    scroll-method "two-finger"    // 滚动方法
    scroll-button 273            // 滚动按钮
    scroll-button-lock          // 滚动按钮锁定 (Since: next release)
    scroll-factor 1.5           // 滚动速度系数 (Since: 0.1.10)
}
```

#### natural-scroll - 自然滚动
- **类型**: 标志
- **默认值**: 触控板默认开启，鼠标默认关闭
- **作用**: 反转滚动方向（与移动设备一致的滚动方向）

#### scroll-method - 滚动方法
- **类型**: 字符串
- **可能的值**:
  - `"no-scroll"` - 禁用滚动
  - `"two-finger"` - 双指滚动（触控板默认）
  - `"edge"` - 边缘滚动
  - `"on-button-down"` - 按住按钮滚动（轨迹点默认）
- **作用**: 定义如何触发滚动事件

#### scroll-button - 滚动按钮
- **类型**: 整数（按钮代码）
- **默认值**: 273（通常是中键）
- **作用**: 用于 `"on-button-down"` 滚动方法的按钮
- **如何获取**: 使用 `libinput debug-events` 查看按钮代码

#### scroll-button-lock - 滚动按钮锁定 (Since: next release)
- **类型**: 标志
- **默认值**: 关闭
- **作用**:
  - 启用时：点击一次开启滚动，再点击一次关闭滚动
  - 禁用时：需要按住按钮才能滚动
  - 双击作为原按钮的单击

#### scroll-factor - 滚动速度系数 (Since: 0.1.10)
- **类型**: 浮点数
- **默认值**: 1.0
- **范围**: 通常 0.1-10.0
- **作用**: 缩放滚动速度，>1.0 加速，<1.0 减速

### 指针加速设置

```kdl
mouse {
    accel-speed 0.2        // 加速度
    accel-profile "flat"   // 加速配置文件
}
```

#### accel-speed - 加速度
- **类型**: 浮点数
- **默认值**: 0.0
- **范围**: -1.0 到 1.0
- **作用**:
  - 负值：减慢指针移动
  - 0：默认速度
  - 正值：加快指针移动

#### accel-profile - 加速配置文件
- **类型**: 字符串
- **默认值**: `"adaptive"`
- **可能的值**:
  - `"adaptive"` - 自适应加速（移动越快加速越多）
  - `"flat"` - 线性移动（无加速）
- **作用**: 控制指针移动的加速曲线

### 手感设置

```kdl
touchpad {
    left-handed           // 左手模式
    middle-emulation      // 中键模拟
}
```

#### left-handed - 左手模式
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 交换左右键功能

#### middle-emulation - 中键模拟
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 同时按下左右键模拟中键点击

---

## touchpad {} - 触控板专用配置

### 轻触设置

```kdl
touchpad {
    tap                    // 轻触点击
    tap-button-map "left-middle-right"    // 轻触按钮映射
    drag false             // 轻触拖拽 (Since: 25.05)
    drag-lock              // 拖拽锁定 (Since: 25.02)
}
```

#### tap - 轻触点击
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 启用轻触触控板进行点击

#### tap-button-map - 轻触按钮映射
- **类型**: 字符串
- **默认值**: `"left-right-middle"`
- **可能的值**:
  - `"left-right-middle"` - 1指左键，2指右键，3指中键
  - `"left-middle-right"` - 1指左键，2指中键，3指右键
- **作用**: 定义多指轻触对应的按钮

#### drag - 轻触拖拽 (Since: 25.05)
- **类型**: 布尔值
- **默认值**: true
- **作用**: 是否启用轻触后拖拽功能

#### drag-lock - 拖拽锁定 (Since: 25.02)
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 拖拽时短暂抬起手指不会丢失拖拽状态

### 点击方法

```kdl
touchpad {
    click-method "clickfinger"    // 点击方法
}
```

#### click-method - 点击方法
- **类型**: 字符串
- **默认值**: 依设备而定
- **可能的值**:
  - `"button-areas"` - 按钮区域（底部区域分左中右）
  - `"clickfinger"` - 点击手指（根据手指数量判断按钮）
- **作用**: 定义触控板物理按下的行为

### 智能禁用

```kdl
touchpad {
    dwt                           // 打字时禁用
    dwtp                          // 轨迹点时禁用
    disabled-on-external-mouse    // 外接鼠标时禁用
}
```

#### dwt - 打字时禁用触控板
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 在键盘输入时临时禁用触控板，防止误触

#### dwtp - 轨迹点使用时禁用触控板
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 使用轨迹点时禁用触控板

#### disabled-on-external-mouse - 外接鼠标时禁用
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 检测到外接鼠标时自动禁用触控板

---

## mouse {}, trackpoint {}, trackball {} - 其他指针设备

这些设备支持与触控板相同的通用选项，但不支持轻触相关功能：

```kdl
mouse {
    off
    natural-scroll
    accel-speed 0.2
    accel-profile "flat"
    scroll-factor 1.0
    scroll-method "no-scroll"    // 鼠标通常设为"no-scroll"
    scroll-button 273
    scroll-button-lock
    left-handed
    middle-emulation
}

trackpoint {
    // 轨迹点通常使用：
    scroll-method "on-button-down"
    scroll-button 273
    // ...其他通用选项
}

trackball {
    // 与trackpoint相同的选项
}
```

---

## tablet {} - 数位板/平板配置

```kdl
tablet {
    off                                    // 禁用设备
    map-to-output "eDP-1"                 // 映射到输出
    left-handed                           // 左手模式
    calibration-matrix 1.0 0.0 0.0 0.0 1.0 0.0    // 校准矩阵 (Since: 25.02)
}
```

#### map-to-output - 映射到输出
- **类型**: 字符串（输出名称）
- **默认值**: 无（映射到所有输出的联合区域）
- **可能的值**: 与output配置中相同的输出名称
- **作用**: 将绝对定位设备限制到特定显示器
- **Since**: 0.1.7 - 未映射时会映射到所有输出的联合区域（无长宽比校正）

#### calibration-matrix - 校准矩阵 (Since: 25.02)
- **类型**: 6个浮点数
- **默认值**: `1.0 0.0 0.0 0.0 1.0 0.0`（单位矩阵）
- **作用**: 应用变换矩阵进行校准
- **格式**: `xx xy x0 yx yy y0`（仿射变换矩阵）
- **参考**: 查看 LIBINPUT_CALIBRATION_MATRIX 文档获取示例

---

## touch {} - 触屏配置

```kdl
touch {
    off                    // 禁用设备
    map-to-output "eDP-1"  // 映射到输出
}
```

触屏设备的配置选项与平板设备相似，但更加简单。

---

## 全局输入设置

以下设置不特定于任何设备类型：

### 电源键处理

```kdl
input {
    disable-power-key-handling    // 禁用电源键处理
}
```

#### disable-power-key-handling - 禁用电源键处理
- **类型**: 标志
- **默认值**: 关闭
- **作用**:
  - 默认：niri接管电源键，按下时睡眠而非关机
  - 启用：让systemd logind等其他服务处理电源键

### 鼠标跟随

```kdl
input {
    warp-mouse-to-focus                        // 鼠标跟随焦点
    warp-mouse-to-focus mode="center-xy"       // 鼠标跟随模式 (Since: 25.05)
}
```

#### warp-mouse-to-focus - 鼠标跟随焦点
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 切换焦点时自动移动鼠标指针到新焦点窗口

#### mode - 跟随模式 (Since: 25.05)
- **类型**: 字符串属性
- **默认值**: 默认行为（分别按X/Y轴独立吸附）
- **可能的值**:
  - `"center-xy"` - X和Y坐标一起移动到窗口中心
  - `"center-xy-always"` - 即使鼠标已在窗口内也移动到中心
- **作用**: 控制鼠标跟随的精确行为

### 焦点跟随

```kdl
input {
    focus-follows-mouse                          // 焦点跟随鼠标
    focus-follows-mouse max-scroll-amount="10%"  // 最大滚动量 (Since: 0.1.8)
}
```

#### focus-follows-mouse - 焦点跟随鼠标
- **类型**: 标志
- **默认值**: 关闭
- **作用**: 鼠标悬停时自动切换焦点到该窗口

#### max-scroll-amount - 最大滚动量 (Since: 0.1.8)
- **类型**: 百分比字符串属性
- **默认值**: 无限制
- **可能的值**: `"0%"`, `"10%"`, `"50%"` 等
- **作用**:
  - 限制焦点跟随导致的视图滚动
  - `"0%"` 表示不允许滚动
  - 百分比基于工作区宽度

### 工作区切换

```kdl
input {
    workspace-auto-back-and-forth    // 工作区自动往返
}
```

#### workspace-auto-back-and-forth - 工作区自动往返
- **类型**: 标志
- **默认值**: 关闭
- **作用**:
  - 重复切换到相同工作区索引时，切换回上一个工作区
  - 即使工作区重新排序也能正确切换

### Mod键自定义 (Since: 25.05)

```kdl
input {
    mod-key "Super"        // 主Mod键
    mod-key-nested "Alt"   // 嵌套窗口Mod键
}
```

#### mod-key - 主Mod键
- **类型**: 字符串
- **默认值**: TTY上为`"Super"`，嵌套窗口中为`"Alt"`
- **可能的值**: `"Super"`, `"Alt"`, `"Mod3"`, `"Mod5"`, `"Ctrl"`, `"Shift"`
- **作用**: 定义键绑定中 `Mod` 的具体含义

#### mod-key-nested - 嵌套窗口Mod键
- **类型**: 字符串
- **默认值**: `"Alt"`
- **可能的值**: 与 mod-key 相同
- **作用**: 在嵌套窗口（如使用winit后端）中运行时的Mod键

**注意**: 不建议设置为 `"Ctrl"` 或 `"Shift"`，因为这些键常用于应用程序快捷键和常规输入。

---

## 配置示例

### 基础配置

```kdl
input {
    keyboard {
        xkb {
            layout "us"
            options "caps:escape"
        }
        repeat-delay 400
        repeat-rate 30
        numlock
    }

    touchpad {
        tap
        natural-scroll
        accel-speed 0.3
        scroll-method "two-finger"
        dwt
    }

    mouse {
        accel-speed 0.1
        accel-profile "flat"
    }

    focus-follows-mouse max-scroll-amount="10%"
    workspace-auto-back-and-forth
}
```

### 多布局配置

```kdl
input {
    keyboard {
        xkb {
            layout "us,ru,de"
            options "grp:alt_shift_toggle,caps:escape,compose:ralt"
        }
        track-layout "window"    // 每窗口独立布局
    }
}
```

### 高级指针配置

```kdl
input {
    touchpad {
        tap
        natural-scroll
        tap-button-map "left-middle-right"
        click-method "clickfinger"
        drag-lock
        disabled-on-external-mouse
    }

    trackpoint {
        scroll-method "on-button-down"
        scroll-button 273
        scroll-button-lock
        accel-speed -0.2
    }

    tablet {
        map-to-output "eDP-1"
        calibration-matrix 1.2 0.0 0.0 0.0 1.2 0.0
    }
}
```

---

## 常见问题

### 1. 键盘布局不生效
- 确保系统安装了对应的键盘布局包
- 检查 `localectl` 输出确认系统布局设置
- 空的xkb段落会从systemd-localed读取设置

### 2. 触控板太敏感
- 调整 `accel-speed` 为负值
- 启用 `dwt` 防止打字时误触
- 考虑禁用 `tap` 或调整 `tap-button-map`

### 3. 滚动方向不对
- 切换 `natural-scroll` 标志
- 注意触控板和鼠标可以设置不同的滚动方向

### 4. 多布局切换问题
- 确认设置了正确的 `options`，如 `"grp:alt_shift_toggle"`
- 考虑使用 `track-layout "window"` 为每窗口单独记忆布局

### 5. 外接设备冲突
- 使用 `disabled-on-external-mouse` 自动禁用触控板
- 为不同设备类型设置不同的加速度和滚动设置

---

## 调试工具

- `wev` - 检测键名和键盘事件
- `libinput debug-events` - 检测libinput事件和按钮代码
- `localectl` - 查看和设置系统键盘布局
- `niri validate` - 验证配置文件语法
