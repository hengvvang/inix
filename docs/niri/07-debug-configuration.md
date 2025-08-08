# Niri Debug 调试配置详解

本文档详细介绍niri中 `debug {}` 段落的所有配置选项。调试配置用于排查问题、性能分析和开发测试。

## 概述

`debug {}` 段落包含各种调试和性能分析选项，可以帮助用户诊断问题、优化性能和了解niri的内部工作机制。

## 基本结构

```kdl
debug {
    // 渲染调试
    damage-tracking false            // 关闭损坏区域跟踪
    wait-for-frame-completion-before-queueing-next false

    // 性能监控
    enable-color-transformations-capability-search false

    // VRR调试
    vrr-debug false

    // 外部调试工具
    dbus-interfaces-in-non-session-instances false
}
```

---

## 渲染调试选项

### damage-tracking - 损坏区域跟踪

```kdl
debug {
    damage-tracking false            // 关闭损坏区域跟踪
    damage-tracking true             // 开启损坏区域跟踪（默认）
}
```

- **类型**: 布尔值
- **默认值**: true
- **作用**: 控制是否启用损坏区域跟踪优化
- **false时**: 每帧重绘整个屏幕，可能影响性能但解决某些渲染问题

#### 使用场景
```kdl
// 解决渲染artifact问题
debug {
    damage-tracking false    // 关闭优化，确保完整重绘
}

// 性能优化（默认）
debug {
    damage-tracking true     // 仅重绘变化区域
}
```

### wait-for-frame-completion-before-queueing-next - 帧完成等待

```kdl
debug {
    wait-for-frame-completion-before-queueing-next false    // 不等待帧完成
    wait-for-frame-completion-before-queueing-next true     // 等待帧完成
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 控制是否等待当前帧完成渲染后再开始下一帧
- **true时**: 降低延迟但可能影响流畅度

#### 延迟优化配置
```kdl
debug {
    // 低延迟模式（适合游戏）
    wait-for-frame-completion-before-queueing-next true

    // 流畅度优先（适合日常使用）
    wait-for-frame-completion-before-queueing-next false
}
```

---

## 颜色和显示调试

### enable-color-transformations-capability-search - 颜色转换能力搜索

```kdl
debug {
    enable-color-transformations-capability-search false    // 关闭颜色转换搜索
    enable-color-transformations-capability-search true     // 开启颜色转换搜索
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 启用颜色转换能力的搜索和检测
- **影响**: 可能影响启动时间，但改善色彩管理

#### 颜色管理配置
```kdl
debug {
    // 精确色彩管理
    enable-color-transformations-capability-search true
}

// 配合output配置
output "Dell Inc. U2720Q" {
    // 高端显示器启用色彩管理
}
```

---

## VRR调试选项

### vrr-debug - VRR调试信息

```kdl
debug {
    vrr-debug false                  // 关闭VRR调试（默认）
    vrr-debug true                   // 开启VRR调试信息
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 显示可变刷新率相关的调试信息
- **输出**: VRR状态变化、刷新率切换等信息

#### VRR问题排查
```kdl
debug {
    vrr-debug true                   // 启用VRR调试
}

output "Gaming Monitor" {
    variable-refresh-rate on-demand=true
}

window-rule {
    match app-id="mpv"
    variable-refresh-rate true
}
```

### skip-cursor-only-updates-during-vrr - VRR时跳过光标更新

```kdl
debug {
    skip-cursor-only-updates-during-vrr false    // 不跳过光标更新
    skip-cursor-only-updates-during-vrr true     // 跳过光标更新
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: VRR激活时是否跳过仅光标的更新
- **用途**: 解决VRR环境下光标闪烁问题

#### VRR光标优化
```kdl
debug {
    // 解决VRR光标问题
    skip-cursor-only-updates-during-vrr true
    vrr-debug true                   // 监控VRR状态
}
```

---

## 外部接口调试

### dbus-interfaces-in-non-session-instances - 非会话实例D-Bus接口

```kdl
debug {
    dbus-interfaces-in-non-session-instances false    // 关闭（默认）
    dbus-interfaces-in-non-session-instances true     // 开启D-Bus接口
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 在非会话实例中启用D-Bus接口
- **用途**: 允许调试工具连接到niri实例

#### 开发调试配置
```kdl
debug {
    // 允许外部调试工具连接
    dbus-interfaces-in-non-session-instances true
}
```

---

## 性能分析选项

### render-drm-device - DRM设备渲染

```kdl
debug {
    render-drm-device "/dev/dri/renderD128"      // 指定渲染设备
    render-drm-device "/dev/dri/renderD129"      // 使用第二个GPU
}
```

- **类型**: 字符串（设备路径）
- **默认值**: 自动检测
- **作用**: 强制使用指定的DRM渲染设备
- **用途**: 多GPU系统中选择特定GPU

#### 多GPU配置
```kdl
debug {
    // 使用独立显卡进行渲染
    render-drm-device "/dev/dri/renderD129"
}
```

### disable-cursor-plane - 禁用光标平面

```kdl
debug {
    disable-cursor-plane false               // 使用硬件光标（默认）
    disable-cursor-plane true                // 禁用硬件光标平面
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 禁用硬件光标平面，使用软件光标
- **用途**: 解决某些驱动的光标显示问题

### disable-overlays - 禁用覆盖层

```kdl
debug {
    disable-overlays false                   // 使用硬件覆盖层（默认）
    disable-overlays true                    // 禁用硬件覆盖层
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 禁用硬件覆盖层优化
- **用途**: 解决某些显卡驱动的兼容性问题

---

## 日志和调试输出

### log-level - 日志级别

```kdl
debug {
    log-level "error"                        // 仅错误信息
    log-level "warn"                         // 警告及以上
    log-level "info"                         // 信息及以上（默认）
    log-level "debug"                        // 调试信息
    log-level "trace"                        // 详细跟踪信息
}
```

- **类型**: 字符串
- **默认值**: "info"
- **级别**: error < warn < info < debug < trace

#### 日志级别说明
- **"error"** - 仅显示错误，最少输出
- **"warn"** - 错误和警告信息
- **"info"** - 一般运行信息（推荐）
- **"debug"** - 调试信息，详细运行状态
- **"trace"** - 最详细信息，性能分析用

### debug-layers - 调试层

```kdl
debug {
    debug-layers true                        // 启用调试层
    debug-layers false                       // 禁用调试层（默认）
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 启用额外的调试层和验证
- **影响**: 显著影响性能，仅用于开发调试

---

## 实验性选项

### experimental-threaded-renderer - 多线程渲染器

```kdl
debug {
    experimental-threaded-renderer false     // 单线程渲染（默认）
    experimental-threaded-renderer true      // 实验性多线程渲染
}
```

- **类型**: 布尔值
- **默认值**: false
- **状态**: 实验性功能
- **风险**: 可能导致不稳定，谨慎使用

### experimental-direct-scanout - 直接扫描输出

```kdl
debug {
    experimental-direct-scanout false        // 关闭直接扫描（默认）
    experimental-direct-scanout true         // 启用直接扫描输出
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 启用实验性的直接扫描输出优化
- **收益**: 可能降低延迟，提高性能

---

## 调试配置示例

### 1. 基础调试配置

```kdl
debug {
    // 基本调试信息
    log-level "debug"
    vrr-debug true

    // 保持性能
    damage-tracking true
    wait-for-frame-completion-before-queueing-next false
}
```

### 2. 性能分析配置

```kdl
debug {
    // 详细性能信息
    log-level "trace"
    debug-layers true

    // 性能相关调试
    vrr-debug true
    damage-tracking false    // 确保完整渲染

    // 外部工具支持
    dbus-interfaces-in-non-session-instances true
}
```

### 3. 兼容性调试配置

```kdl
debug {
    // 解决兼容性问题
    disable-cursor-plane true
    disable-overlays true
    damage-tracking false

    // 颜色管理
    enable-color-transformations-capability-search true

    // 日志记录
    log-level "info"
}
```

### 4. VRR问题排查配置

```kdl
debug {
    // VRR专项调试
    vrr-debug true
    skip-cursor-only-updates-during-vrr true

    // 等待帧完成（低延迟）
    wait-for-frame-completion-before-queueing-next true

    // 详细日志
    log-level "debug"
}
```

### 5. 多GPU调试配置

```kdl
debug {
    // 指定GPU
    render-drm-device "/dev/dri/renderD129"

    // 禁用可能有问题的硬件特性
    disable-overlays false
    disable-cursor-plane false

    // 监控渲染
    log-level "debug"
}
```

---

## 调试工具和命令

### niri命令行调试

```bash
# 启动niri并输出调试信息
niri --debug

# 验证配置文件
niri validate

# 查看当前状态
niri msg version
niri msg outputs
niri msg workspaces

# 实时监控
niri msg --watch workspaces
```

### 日志监控

```bash
# systemd日志（如果通过systemd启动）
journalctl -fu niri

# 直接输出到文件
niri 2>&1 | tee niri-debug.log

# 仅错误日志
niri 2>&1 | grep -i error
```

### 性能监控

```bash
# GPU使用监控
watch -n1 'cat /sys/class/drm/card*/engine/*/busy'

# 内存使用
watch -n1 'ps -o pid,vsz,rss,comm -p $(pgrep niri)'

# 帧率监控（如果支持）
niri msg fps-counter
```

---

## 常见调试场景

### 1. 渲染问题排查

```kdl
debug {
    log-level "debug"
    damage-tracking false    // 强制完整重绘
    disable-overlays true    // 禁用硬件覆盖层
}
```

### 2. VRR问题诊断

```kdl
debug {
    vrr-debug true
    skip-cursor-only-updates-during-vrr true
    wait-for-frame-completion-before-queueing-next true
    log-level "debug"
}
```

### 3. 性能问题分析

```kdl
debug {
    log-level "trace"        // 最详细日志
    debug-layers true        // 启用分析层

    // 测试各种优化
    damage-tracking true
    experimental-direct-scanout true
}
```

### 4. 兼容性问题解决

```kdl
debug {
    // 禁用可能有问题的功能
    disable-cursor-plane true
    disable-overlays true
    damage-tracking false

    // 基础配置
    enable-color-transformations-capability-search false
    log-level "warn"
}
```

### 5. 开发和测试

```kdl
debug {
    // 开发友好配置
    log-level "trace"
    debug-layers true
    dbus-interfaces-in-non-session-instances true

    // 实验性功能测试
    experimental-threaded-renderer true
    experimental-direct-scanout true
}
```

---

## 性能影响说明

### 高性能配置（生产环境）

```kdl
debug {
    // 最小调试信息
    log-level "error"

    // 关闭调试功能
    vrr-debug false
    debug-layers false

    // 保持优化
    damage-tracking true
    wait-for-frame-completion-before-queueing-next false
}
```

### 开发调试配置

```kdl
debug {
    // 详细信息
    log-level "debug"
    vrr-debug true
    debug-layers true

    // 外部工具支持
    dbus-interfaces-in-non-session-instances true

    // 可能影响性能但利于调试
    damage-tracking false
}
```

---

## 故障排除指南

### 常见问题和解决方案

1. **屏幕撕裂**
   ```kdl
   debug {
       wait-for-frame-completion-before-queueing-next true
       damage-tracking false
   }
   ```

2. **光标问题**
   ```kdl
   debug {
       disable-cursor-plane true
       skip-cursor-only-updates-during-vrr true
   }
   ```

3. **VRR闪烁**
   ```kdl
   debug {
       vrr-debug true
       skip-cursor-only-updates-during-vrr true
   }
   ```

4. **渲染错误**
   ```kdl
   debug {
       damage-tracking false
       disable-overlays true
   }
   ```

5. **性能问题**
   ```kdl
   debug {
       log-level "trace"  // 查看瓶颈
       experimental-direct-scanout true
   }
   ```

通过合理使用这些调试选项，可以有效诊断和解决niri使用中遇到的各种问题。
