# Niri Layout 布局配置详解

本文档详细介绍niri中 `layout {}` 段落的所有配置选项。布局配置控制工作区、窗口排列和视觉效果。

## 概述

`layout {}` 是niri配置的核心部分，定义了窗口平铺方式、工作区行为、间距、边框等视觉效果。

## 基本结构

```kdl
layout {
    gaps 16                        // 窗口间距
    center-focused-column "never"  // 聚焦列居中

    preset-column-widths {
        proportion 0.33333         // 预设列宽比例
        proportion 0.5
        proportion 0.66667
    }

    default-column-width { proportion 0.5 }  // 默认列宽

    focus-ring {
        width 4                    // 聚焦环宽度
        active-color "#7fc8ff"     // 活动窗口颜色
        inactive-color "#505050"   // 非活动窗口颜色
    }

    border {
        width 2                    // 边框宽度
        active-color "#ffc87f"     // 活动边框颜色
        inactive-color "#505050"   // 非活动边框颜色
    }
}
```

---

## 窗口间距

### gaps - 窗口间距

```kdl
layout {
    gaps 16         // 所有方向16像素间距
    gaps 0          // 无间距
    gaps 32         // 大间距，适合大屏幕
}
```

- **类型**: 整数
- **默认值**: 16
- **单位**: 逻辑像素
- **应用**: 窗口之间、工作区边缘的间距
- **范围**: 0 到任意正整数

#### 推荐设置
- **紧凑型**: 4-8 像素
- **标准型**: 12-16 像素
- **宽敞型**: 20-32 像素
- **演示模式**: 48+ 像素

#### 视觉效果
```kdl
// 无间距 - 经典平铺
layout { gaps 0 }

// 小间距 - 现代感
layout { gaps 8 }

// 标准间距 - 平衡感
layout { gaps 16 }

// 大间距 - 宽敞感
layout { gaps 32 }
```

---

## 列居中配置

### center-focused-column - 聚焦列居中

```kdl
layout {
    center-focused-column "never"        // 从不居中（默认）
    center-focused-column "always"       // 始终居中
    center-focused-column "on-overflow"  // 溢出时居中
}
```

- **类型**: 字符串
- **默认值**: `"never"`

#### 可能的值详解

**`"never"`** - 从不居中
- 聚焦列保持在其自然位置
- 传统平铺窗口管理器行为
- 适合大屏幕多列布局

**`"always"`** - 始终居中
- 聚焦的列始终在屏幕中央
- 其他列在两侧排列
- 适合注重聚焦的工作流

**`"on-overflow"`** - 溢出时居中
- 所有列都能显示完整时不居中
- 有列被屏幕边缘遮挡时才居中
- 智能平衡显示和聚焦

#### 使用场景示例

```kdl
// 程序员模式 - 从不居中，充分利用屏幕
layout {
    center-focused-column "never"
    gaps 8
}

// 写作模式 - 始终居中，减少干扰
layout {
    center-focused-column "always"
    gaps 32
}

// 自适应模式 - 溢出时居中
layout {
    center-focused-column "on-overflow"
    gaps 16
}
```

---

## 预设列宽

### preset-column-widths - 预设列宽度

```kdl
layout {
    preset-column-widths {
        proportion 0.25      // 25% 窄列
        proportion 0.33333   // 33.33% 中窄列
        proportion 0.5       // 50% 中等列
        proportion 0.66667   // 66.67% 宽列
        proportion 0.75      // 75% 最宽列

        fixed 200            // 固定200像素宽度
        fixed 320            // 固定320像素宽度
    }
}
```

#### 宽度类型

**比例宽度 (proportion)**
- **类型**: 浮点数 (0.0 到 1.0)
- **含义**: 工作区宽度的比例
- **示例**: `0.5` = 50%工作区宽度
- **优点**: 适应不同屏幕尺寸

**固定宽度 (fixed)**
- **类型**: 整数
- **单位**: 逻辑像素
- **含义**: 固定像素宽度
- **示例**: `320` = 320逻辑像素宽
- **优点**: 精确控制特定应用宽度

#### 常用预设组合

```kdl
// 黄金比例预设
layout {
    preset-column-widths {
        proportion 0.382     // φ-1 ≈ 38.2%
        proportion 0.5       // 50%
        proportion 0.618     // φ ≈ 61.8%
    }
}

// 标准比例预设
layout {
    preset-column-widths {
        proportion 0.33333   // 1/3
        proportion 0.5       // 1/2
        proportion 0.66667   // 2/3
    }
}

// 应用导向预设
layout {
    preset-column-widths {
        fixed 320            // 侧边栏宽度
        proportion 0.4       // 编辑器
        proportion 0.6       // 主内容
        fixed 280            // 聊天/通知
    }
}

// 超宽屏预设
layout {
    preset-column-widths {
        proportion 0.2       // 边栏
        proportion 0.3       // 辅助内容
        proportion 0.5       // 主内容
    }
}
```

#### 快捷键使用
配置预设后，可以通过快捷键快速切换列宽度：
- `Mod+R` - 切换到下一个预设宽度
- `Mod+Shift+R` - 切换到上一个预设宽度

---

## 默认列宽

### default-column-width - 默认列宽度

```kdl
layout {
    default-column-width { proportion 0.5 }    // 50%比例
    default-column-width { fixed 640 }         // 640像素固定宽度
}
```

- **作用**: 新创建列的默认宽度
- **类型**: 与preset-column-widths相同的宽度格式

#### 选择建议
- **通用场景**: `{ proportion 0.5 }` - 50%宽度
- **代码编辑**: `{ proportion 0.6 }` - 稍宽便于阅读
- **浏览网页**: `{ proportion 0.4 }` - 适中宽度
- **固定布局**: `{ fixed 800 }` - 精确控制

---

## 聚焦环效果

### focus-ring - 聚焦环配置

```kdl
layout {
    focus-ring {
        width 4                    // 环宽度
        active-color "#7fc8ff"     // 活动颜色
        inactive-color "#505050"   // 非活动颜色
        active-gradient from="#ff7f7f" to="#7f7fff" angle=45  // 活动渐变
        inactive-gradient from="#505050" to="#303030"         // 非活动渐变
    }
}
```

#### 基本属性

**width - 环宽度**
```kdl
focus-ring {
    width 0      // 关闭聚焦环
    width 2      // 细环
    width 4      // 标准环
    width 6      // 粗环
    width 10     // 醒目环
}
```

- **类型**: 整数
- **默认值**: 4
- **单位**: 逻辑像素
- **最小值**: 0（关闭聚焦环）

**off - 关闭聚焦环**
```kdl
focus-ring {
    off    // 完全关闭聚焦环效果
}
```

#### 颜色配置

**active-color - 活动窗口颜色**
```kdl
focus-ring {
    active-color "#7fc8ff"      // 蓝色
    active-color "#ff6b6b"      // 红色
    active-color "#51cf66"      // 绿色
    active-color "transparent"   // 透明（隐藏）
}
```

**inactive-color - 非活动窗口颜色**
```kdl
focus-ring {
    inactive-color "#505050"    // 深灰
    inactive-color "#333333"    // 更深灰
    inactive-color "transparent" // 透明（仅显示活动）
}
```

#### 渐变效果 (Since 25.05)

**active-gradient - 活动窗口渐变**
```kdl
focus-ring {
    active-gradient from="#ff7f7f" to="#7f7fff" angle=45
    active-gradient from="#ffd700" to="#ff6347" angle=90
    active-gradient from="#00ff00" to="#0080ff" angle=135
}
```

**inactive-gradient - 非活动窗口渐变**
```kdl
focus-ring {
    inactive-gradient from="#505050" to="#303030" angle=0
}
```

#### 渐变参数说明
- **from**: 起始颜色（字符串）
- **to**: 结束颜色（字符串）
- **angle**: 角度（整数，0-359度）
  - `0` - 从左到右
  - `45` - 对角向上
  - `90` - 从上到下
  - `135` - 对角向下
  - `180` - 从右到左
  - `270` - 从下到上

#### 主题样式示例

```kdl
// 经典蓝色主题
focus-ring {
    width 4
    active-color "#7fc8ff"
    inactive-color "#505050"
}

// 暖色调主题
focus-ring {
    width 3
    active-color "#ffc87f"
    inactive-color "#756559"
}

// 高对比主题
focus-ring {
    width 6
    active-color "#ffffff"
    inactive-color "#000000"
}

// 渐变主题
focus-ring {
    width 4
    active-gradient from="#ff6b6b" to="#4ecdc4" angle=45
    inactive-gradient from="#555555" to="#333333" angle=45
}

// 最小化主题（仅活动窗口）
focus-ring {
    width 2
    active-color "#7fc8ff"
    inactive-color "transparent"
}

// 关闭主题
focus-ring {
    off
}
```

---

## 窗口边框

### border - 窗口边框配置

```kdl
layout {
    border {
        width 2                    // 边框宽度
        active-color "#ffc87f"     // 活动颜色
        inactive-color "#505050"   // 非活动颜色
        active-gradient from="#ff7f7f" to="#7f7fff" angle=45  // 活动渐变
        inactive-gradient from="#505050" to="#303030"         // 非活动渐变
    }
}
```

#### 基本属性

**width - 边框宽度**
```kdl
border {
    width 0      // 关闭边框
    width 1      // 细边框
    width 2      // 标准边框
    width 4      // 粗边框
    width 8      // 醒目边框
}
```

- **类型**: 整数
- **默认值**: 4
- **单位**: 逻辑像素
- **最小值**: 0（关闭边框）

**off - 关闭边框**
```kdl
border {
    off    // 完全关闭边框效果
}
```

#### 颜色和渐变
边框支持与聚焦环相同的颜色和渐变配置：

```kdl
border {
    width 2
    active-color "#ffc87f"
    inactive-color "#505050"

    // 或使用渐变
    active-gradient from="#ffaa00" to="#ff6600" angle=90
    inactive-gradient from="#666666" to="#444444" angle=90
}
```

#### 与聚焦环的区别
- **聚焦环**: 在窗口内容周围，不占用窗口空间
- **边框**: 在窗口内容内部，占用窗口内容空间
- **选择**: 可以同时使用，也可单独使用

#### 主题搭配示例

```kdl
// 统一主题 - 聚焦环和边框同色
layout {
    focus-ring {
        width 4
        active-color "#7fc8ff"
        inactive-color "#505050"
    }
    border {
        width 2
        active-color "#7fc8ff"
        inactive-color "#505050"
    }
}

// 对比主题 - 不同颜色突出层次
layout {
    focus-ring {
        width 3
        active-color "#ff6b6b"
        inactive-color "transparent"
    }
    border {
        width 1
        active-color "#4ecdc4"
        inactive-color "#333333"
    }
}

// 渐变主题
layout {
    focus-ring {
        width 4
        active-gradient from="#ff7f7f" to="#7f7fff" angle=45
        inactive-color "#333333"
    }
    border {
        width 2
        active-gradient from="#ffd700" to="#ff6347" angle=135
        inactive-color "#222222"
    }
}
```

---

## 窗口大小调整

### resize-animation - 大小调整动画

```kdl
layout {
    resize-animation {
        duration-ms 250              // 动画持续时间
        curve "ease-out-cubic"       // 动画曲线
    }
}
```

#### duration-ms - 动画持续时间
```kdl
resize-animation {
    duration-ms 0      // 关闭动画
    duration-ms 150    // 快速动画
    duration-ms 250    // 标准动画
    duration-ms 500    // 慢速动画
}
```

- **类型**: 整数
- **默认值**: 250
- **单位**: 毫秒
- **范围**: 0到任意正整数
- **0值**: 关闭动画，立即调整

#### curve - 动画曲线
```kdl
resize-animation {
    curve "ease-out-cubic"       // 三次缓出（默认）
    curve "linear"               // 线性
    curve "ease-in-cubic"        // 三次缓入
    curve "ease-in-out-cubic"    // 三次缓入缓出
}
```

- **类型**: 字符串
- **默认值**: `"ease-out-cubic"`

**动画曲线特征**:
- **`"linear"`** - 匀速变化，机械感
- **`"ease-in-cubic"`** - 慢开始快结束
- **`"ease-out-cubic"`** - 快开始慢结束，自然感
- **`"ease-in-out-cubic"`** - 慢开始慢结束，优雅感

#### 性能优化设置

```kdl
// 高性能模式 - 关闭动画
resize-animation {
    duration-ms 0
}

// 平衡模式 - 快速动画
resize-animation {
    duration-ms 150
    curve "ease-out-cubic"
}

// 视觉优先模式 - 流畅动画
resize-animation {
    duration-ms 300
    curve "ease-in-out-cubic"
}
```

---

## 悬浮窗口配置

### floating-window - 悬浮窗口设置

```kdl
layout {
    floating-window {
        border {
            width 4                // 悬浮窗边框宽度
            active-color "#ffaa00" // 悬浮窗活动颜色
        }
    }
}
```

悬浮窗口可以有独立的边框设置，与平铺窗口区分。

#### 悬浮窗口边框
```kdl
floating-window {
    border {
        width 3
        active-color "#ff6b6b"     // 红色突出悬浮窗口
        inactive-color "#333333"

        // 或使用渐变
        active-gradient from="#ff0080" to="#0080ff" angle=45
    }
}
```

#### 使用场景
- 区分悬浮窗口和平铺窗口
- 为悬浮窗口提供更醒目的视觉提示
- 创建层次化的视觉体验

---

## 工作区背景

### background-color - 工作区背景色

```kdl
layout {
    background-color "#1a1a1a"    // 深灰背景
    background-color "#ffffff"    // 白色背景
    background-color "#2e3440"    // Nord 主题背景
    background-color "transparent" // 透明背景
}
```

- **类型**: 颜色字符串
- **默认值**: 黑色
- **作用**: 工作区空白区域的背景颜色
- **覆盖**: 可被具体output的background-color覆盖

#### 主题背景示例

```kdl
// 深色主题
layout {
    background-color "#1a1a1a"
    focus-ring {
        active-color "#7fc8ff"
        inactive-color "#505050"
    }
}

// 浅色主题
layout {
    background-color "#f8f9fa"
    focus-ring {
        active-color "#007acc"
        inactive-color "#cccccc"
    }
}

// 护眼主题
layout {
    background-color "#fdf6e3"    // Solarized Light背景
    focus-ring {
        active-color "#268bd2"
        inactive-color "#93a1a1"
    }
}
```

---

## 完整配置示例

### 1. 极简配置

```kdl
layout {
    gaps 0
    center-focused-column "never"

    focus-ring { off }
    border { off }

    background-color "#000000"
}
```

### 2. 标准桌面配置

```kdl
layout {
    gaps 16
    center-focused-column "on-overflow"

    preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
    }

    default-column-width { proportion 0.5 }

    focus-ring {
        width 4
        active-color "#7fc8ff"
        inactive-color "#505050"
    }

    border {
        width 2
        active-color "#ffc87f"
        inactive-color "#505050"
    }

    background-color "#1a1a1a"
}
```

### 3. 现代渐变配置

```kdl
layout {
    gaps 20
    center-focused-column "always"

    preset-column-widths {
        proportion 0.382   // 黄金比例
        proportion 0.618
        fixed 320
    }

    default-column-width { proportion 0.618 }

    focus-ring {
        width 4
        active-gradient from="#ff6b6b" to="#4ecdc4" angle=45
        inactive-gradient from="#555555" to="#333333" angle=45
    }

    border {
        width 1
        active-gradient from="#ffd700" to="#ff6347" angle=90
        inactive-color "#2a2a2a"
    }

    floating-window {
        border {
            width 3
            active-gradient from="#ff0080" to="#0080ff" angle=135
        }
    }

    resize-animation {
        duration-ms 300
        curve "ease-in-out-cubic"
    }

    background-color "#1e1e2e"
}
```

### 4. 高性能配置

```kdl
layout {
    gaps 8
    center-focused-column "never"

    preset-column-widths {
        proportion 0.5
        proportion 0.75
        fixed 400
    }

    focus-ring {
        width 2
        active-color "#00ff00"
        inactive-color "transparent"
    }

    border { off }

    resize-animation {
        duration-ms 0    // 关闭动画提高性能
    }

    background-color "#000000"
}
```

### 5. 写作专用配置

```kdl
layout {
    gaps 32
    center-focused-column "always"

    preset-column-widths {
        proportion 0.6    // 适合阅读的宽度
        proportion 0.8
    }

    default-column-width { proportion 0.6 }

    focus-ring {
        width 3
        active-color "#d4af37"     // 金色，温暖感
        inactive-color "transparent"
    }

    border { off }

    resize-animation {
        duration-ms 400
        curve "ease-in-out-cubic"  // 优雅的动画
    }

    background-color "#fdf6e3"    // 护眼背景色
}
```

---

## 性能注意事项

### 1. 动画性能
- **高刷新率显示器**: 可以使用较长的动画时间
- **低端硬件**: 建议关闭动画（duration-ms 0）
- **多显示器**: 动画可能影响整体流畅度

### 2. 渐变效果
- **GPU加速**: 渐变需要GPU支持
- **性能影响**: 比纯色边框消耗更多资源
- **兼容性**: 某些老硬件可能不支持

### 3. 复杂布局
- **大间距**: 可能影响窗口最大可用面积
- **多预设宽度**: 内存占用略微增加
- **复杂颜色**: HSL等复杂颜色格式解析稍慢

### 4. 优化建议
```kdl
// 性能优先配置
layout {
    gaps 8
    focus-ring {
        width 2
        active-color "#7fc8ff"
        inactive-color "transparent"
    }
    border { off }
    resize-animation { duration-ms 0 }
}

// 视觉优先配置
layout {
    gaps 16
    focus-ring {
        width 4
        active-gradient from="#ff6b6b" to="#4ecdc4" angle=45
    }
    resize-animation {
        duration-ms 250
        curve "ease-out-cubic"
    }
}
```

这样可以根据硬件配置和个人偏好选择合适的配置方案。
