# Niri Animations 动画配置详解

本文档详细介绍niri中 `animations {}` 段落的所有配置选项。动画配置控制窗口切换、工作区切换和其他UI元素的动画效果。

## 概述

`animations {}` 段落定义了niri中各种动画效果的参数，包括动画时长、缓动曲线、启用/禁用状态等。合理的动画配置可以提供流畅的用户体验。

## 基本结构

```kdl
animations {
    // 窗口打开/关闭动画
    window-open {
        duration-ms 150
        curve "ease-out-cubic"
    }

    // 工作区切换动画
    workspace-switch {
        duration-ms 200
        curve "ease-out-cubic"
    }

    // 全局动画开关
    off  // 关闭所有动画
}
```

---

## 全局动画控制

### off - 关闭所有动画

```kdl
animations {
    off  // 关闭所有动画效果
}
```

- **类型**: 标志
- **作用**: 完全禁用所有动画，提高性能
- **适用场景**:
  - 低端硬件
  - 电池节能模式
  - 需要快速响应的工作环境
  - 可访问性需求

---

## 窗口动画

### window-open - 窗口打开动画

```kdl
animations {
    window-open {
        duration-ms 150              // 动画持续时间
        curve "ease-out-cubic"       // 缓动曲线

        // 高级选项（Since 25.05）
        scale-from 0.8               // 初始缩放比例
        opacity-from 0.0             // 初始透明度
    }
}
```

#### 基本参数

**duration-ms - 动画持续时间**
```kdl
window-open {
    duration-ms 0        // 关闭动画
    duration-ms 100      // 快速动画
    duration-ms 150      // 标准动画
    duration-ms 300      // 慢速动画
    duration-ms 500      // 非常慢的动画
}
```

- **类型**: 整数
- **单位**: 毫秒
- **范围**: 0 到任意正整数
- **推荐值**: 100-300ms

**curve - 缓动曲线**
```kdl
window-open {
    curve "linear"               // 线性，匀速
    curve "ease-in-cubic"        // 三次缓入，慢开始
    curve "ease-out-cubic"       // 三次缓出，快开始慢结束（推荐）
    curve "ease-in-out-cubic"    // 三次缓入缓出，S形曲线
}
```

#### 高级效果参数

**scale-from - 初始缩放比例**
```kdl
window-open {
    scale-from 0.5       // 从50%大小开始
    scale-from 0.8       // 从80%大小开始（推荐）
    scale-from 1.2       // 从120%大小开始（放大效果）
}
```

- **类型**: 浮点数
- **默认值**: 1.0（无缩放效果）
- **范围**: 0.1 到 2.0
- **效果**: 窗口从指定比例缩放到正常大小

**opacity-from - 初始透明度**
```kdl
window-open {
    opacity-from 0.0     // 从完全透明开始
    opacity-from 0.3     // 从30%透明度开始
    opacity-from 1.0     // 从完全不透明开始（无淡入效果）
}
```

- **类型**: 浮点数
- **默认值**: 1.0（无透明度效果）
- **范围**: 0.0 到 1.0
- **效果**: 窗口从指定透明度淡入到完全不透明

### window-close - 窗口关闭动画

```kdl
animations {
    window-close {
        duration-ms 150
        curve "ease-in-cubic"        // 关闭时使用缓入效果

        // 高级选项
        scale-to 0.8                 // 最终缩放比例
        opacity-to 0.0               // 最终透明度
    }
}
```

#### 关闭动画特有参数

**scale-to - 最终缩放比例**
```kdl
window-close {
    scale-to 0.5         // 缩小到50%
    scale-to 0.8         // 缩小到80%（推荐）
    scale-to 1.0         // 不缩放（仅透明度变化）
}
```

**opacity-to - 最终透明度**
```kdl
window-close {
    opacity-to 0.0       // 淡出到完全透明（推荐）
    opacity-to 0.3       // 淡出到30%透明度
    opacity-to 1.0       // 不改变透明度（仅缩放效果）
}
```

---

## 工作区动画

### workspace-switch - 工作区切换动画

```kdl
animations {
    workspace-switch {
        duration-ms 200
        curve "ease-out-cubic"

        // 动画类型选择（Since 25.05）
        type "slide"                 // 滑动切换
        // type "fade"               // 淡入淡出切换
        // type "push"               // 推拉切换
    }
}
```

#### 基本参数

**duration-ms - 切换持续时间**
```kdl
workspace-switch {
    duration-ms 150      // 快速切换，适合频繁切换
    duration-ms 200      // 标准切换（推荐）
    duration-ms 300      // 慢速切换，更有视觉冲击力
    duration-ms 500      // 非常慢，展示效果
}
```

**curve - 切换曲线**
```kdl
workspace-switch {
    curve "ease-out-cubic"       // 快开始慢结束，自然感（推荐）
    curve "ease-in-out-cubic"    // S形曲线，优雅感
    curve "linear"               // 匀速，简洁感
}
```

#### 动画类型（Since 25.05）

**type - 切换动画类型**
```kdl
workspace-switch {
    type "slide"         // 滑动切换（默认）
    type "fade"          // 淡入淡出切换
    type "push"          // 推拉切换
    type "cube"          // 立方体旋转切换
}
```

- **`"slide"`** - 工作区滑入滑出，平滑过渡
- **`"fade"`** - 当前工作区淡出，新工作区淡入
- **`"push"`** - 新工作区推入，旧工作区推出
- **`"cube"`** - 3D立方体旋转效果

---

## 窗口布局动画

### window-movement - 窗口移动动画

```kdl
animations {
    window-movement {
        duration-ms 200
        curve "ease-out-cubic"

        // 移动类型
        type "smooth"                // 平滑移动
        // type "spring"             // 弹簧效果
    }
}
```

#### 移动动画参数

**type - 移动动画类型**
```kdl
window-movement {
    type "smooth"        // 平滑线性移动（默认）
    type "spring"        // 弹簧回弹效果
    type "elastic"       // 弹性伸缩效果
}
```

### window-resize - 窗口大小调整动画

```kdl
animations {
    window-resize {
        duration-ms 150
        curve "ease-out-cubic"

        // 是否启用实时预览
        live-preview true            // 调整过程中实时显示内容
    }
}
```

#### 大小调整特有参数

**live-preview - 实时预览**
```kdl
window-resize {
    live-preview true    // 启用实时预览（推荐）
    live-preview false   // 禁用实时预览，提高性能
}
```

- **true**: 调整大小时应用内容实时更新
- **false**: 仅显示边框轮廓，完成后更新内容

---

## 总览模式动画

### overview - 总览模式切换动画

```kdl
animations {
    overview {
        duration-ms 250
        curve "ease-in-out-cubic"

        // 总览效果参数
        scale-factor 0.8             // 窗口缩放比例
        spacing-factor 1.5           // 窗口间距放大倍数
        background-dim 0.7           // 背景变暗程度
    }
}
```

#### 总览动画参数

**scale-factor - 窗口缩放比例**
```kdl
overview {
    scale-factor 0.6     // 窗口缩小到60%
    scale-factor 0.8     // 窗口缩小到80%（推荐）
    scale-factor 1.0     // 窗口保持原大小
}
```

**spacing-factor - 间距倍数**
```kdl
overview {
    spacing-factor 1.2   // 间距增加20%
    spacing-factor 1.5   // 间距增加50%（推荐）
    spacing-factor 2.0   // 间距增加100%
}
```

**background-dim - 背景变暗**
```kdl
overview {
    background-dim 0.5   // 背景变暗50%
    background-dim 0.7   // 背景变暗70%（推荐）
    background-dim 1.0   // 背景不变暗
}
```

---

## 特效动画

### focus-change - 聚焦切换动画

```kdl
animations {
    focus-change {
        duration-ms 100
        curve "ease-out-cubic"

        // 聚焦环动画
        ring-animation true          // 启用聚焦环动画
        ring-expand-from 0.8         // 聚焦环初始大小
    }
}
```

### border-animation - 边框动画（Since 25.05）

```kdl
animations {
    border-animation {
        duration-ms 150
        curve "ease-out-cubic"

        // 边框效果
        pulse-on-focus true          // 聚焦时边框脉冲效果
        color-transition true        // 颜色平滑过渡
    }
}
```

---

## 缓动曲线详解

### 可用缓动曲线

```kdl
animations {
    window-open {
        // 线性缓动
        curve "linear"               // 匀速，机械感

        // 三次方缓动
        curve "ease-in-cubic"        // 慢开始，加速结束
        curve "ease-out-cubic"       // 快开始，减速结束（最常用）
        curve "ease-in-out-cubic"    // 慢开始慢结束，优雅

        // 二次方缓动（Since 25.05）
        curve "ease-in-quad"         // 轻微缓入
        curve "ease-out-quad"        // 轻微缓出
        curve "ease-in-out-quad"     // 轻微缓入缓出

        // 四次方缓动（Since 25.05）
        curve "ease-in-quart"        // 强烈缓入
        curve "ease-out-quart"       // 强烈缓出
        curve "ease-in-out-quart"    // 强烈缓入缓出

        // 弹性缓动（Since 25.05）
        curve "ease-in-elastic"      // 弹性缓入
        curve "ease-out-elastic"     // 弹性缓出，有回弹
        curve "ease-in-out-elastic"  // 弹性缓入缓出

        // 回弹缓动（Since 25.05）
        curve "ease-in-bounce"       // 回弹缓入
        curve "ease-out-bounce"      // 回弹缓出，跳跃感
        curve "ease-in-out-bounce"   // 回弹缓入缓出
    }
}
```

### 缓动曲线选择指南

**窗口打开**: `"ease-out-cubic"` - 快速出现，优雅减速
**窗口关闭**: `"ease-in-cubic"` - 优雅加速，快速消失
**工作区切换**: `"ease-out-cubic"` - 自然流畅的切换感
**窗口移动**: `"ease-out-cubic"` - 平滑到位
**聚焦切换**: `"ease-out-quad"` - 快速响应，轻微缓冲

---

## 性能优化配置

### 高性能配置

```kdl
animations {
    // 关闭所有动画，最高性能
    off
}
```

### 平衡性能配置

```kdl
animations {
    // 保留关键动画，缩短时间
    window-open {
        duration-ms 100
        curve "ease-out-cubic"
        scale-from 0.9       // 减少缩放幅度
    }

    window-close {
        duration-ms 100
        curve "ease-in-cubic"
        scale-to 0.9
    }

    workspace-switch {
        duration-ms 150
        curve "linear"       // 使用线性减少计算
    }

    // 禁用复杂动画
    // overview { off }
    // border-animation { off }
}
```

### 视觉优先配置

```kdl
animations {
    window-open {
        duration-ms 300
        curve "ease-out-elastic"     // 弹性效果
        scale-from 0.7
        opacity-from 0.0
    }

    window-close {
        duration-ms 250
        curve "ease-in-back"         // 回退效果
        scale-to 0.8
        opacity-to 0.0
    }

    workspace-switch {
        duration-ms 400
        curve "ease-in-out-cubic"
        type "cube"                  // 3D效果
    }

    overview {
        duration-ms 350
        curve "ease-in-out-cubic"
        scale-factor 0.7
        spacing-factor 2.0
        background-dim 0.8
    }
}
```

---

## 完整配置示例

### 1. 极简高性能配置

```kdl
animations {
    off  // 关闭所有动画
}
```

### 2. 标准桌面配置

```kdl
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
        type "slide"
    }

    window-movement {
        duration-ms 150
        curve "ease-out-cubic"
    }

    window-resize {
        duration-ms 100
        curve "ease-out-cubic"
        live-preview true
    }

    focus-change {
        duration-ms 100
        curve "ease-out-cubic"
    }
}
```

### 3. 华丽视觉效果配置

```kdl
animations {
    window-open {
        duration-ms 300
        curve "ease-out-elastic"
        scale-from 0.6
        opacity-from 0.0
    }

    window-close {
        duration-ms 250
        curve "ease-in-back"
        scale-to 0.7
        opacity-to 0.0
    }

    workspace-switch {
        duration-ms 350
        curve "ease-in-out-cubic"
        type "cube"
    }

    window-movement {
        duration-ms 250
        curve "ease-out-bounce"
        type "spring"
    }

    window-resize {
        duration-ms 200
        curve "ease-out-cubic"
        live-preview true
    }

    overview {
        duration-ms 300
        curve "ease-in-out-cubic"
        scale-factor 0.7
        spacing-factor 2.0
        background-dim 0.8
    }

    focus-change {
        duration-ms 150
        curve "ease-out-cubic"
        ring-animation true
        ring-expand-from 0.8
    }

    border-animation {
        duration-ms 200
        curve "ease-out-cubic"
        pulse-on-focus true
        color-transition true
    }
}
```

### 4. 可访问性友好配置

```kdl
animations {
    // 减少动画，降低对动作敏感用户的影响
    window-open {
        duration-ms 50   // 极短动画
        curve "linear"   // 简单线性
    }

    window-close {
        duration-ms 50
        curve "linear"
    }

    workspace-switch {
        duration-ms 100
        curve "linear"
        type "fade"      // 淡入淡出比滑动更友好
    }

    // 禁用复杂动画
    overview { off }
    border-animation { off }
    focus-change { off }
}
```

### 5. 游戏优化配置

```kdl
animations {
    // 游戏时关闭动画以获得最佳响应
    off
}

// 或者针对游戏窗口规则
window-rule {
    match app-id="steam_app_.*"
    // 游戏应用关闭动画
    animations { off }
}
```

---

## 动画调试

### 调试选项

```kdl
debug {
    // 显示动画帧率
    show-animation-fps true

    // 显示动画边界框
    show-animation-bounds true

    // 动画性能监控
    animation-performance-monitoring true
}
```

### 性能监控命令

```bash
# 查看当前动画状态
niri msg animations

# 监控动画性能
niri msg debug-animations

# 实时FPS监控
niri msg fps-counter
```

---

## 故障排除

### 常见问题

1. **动画卡顿**
   - 缩短动画时间
   - 使用简单的线性缓动
   - 关闭复杂效果

2. **GPU使用率过高**
   - 禁用透明度效果
   - 减少同时播放的动画数量
   - 使用硬件加速

3. **电池耗电快**
   - 关闭所有动画
   - 减少动画时长
   - 使用简单缓动曲线

### 性能测试配置

```kdl
animations {
    // 测试配置 - 逐步启用动画进行性能测试
    window-open {
        duration-ms 100
        curve "linear"
    }

    // 其他动画暂时禁用
    window-close { off }
    workspace-switch { off }
}
```

通过逐步启用不同的动画效果，可以找到性能和视觉效果的最佳平衡点。
