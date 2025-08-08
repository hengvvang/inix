# Niri Output 配置详解

本文档详细介绍niri中 `output "NAME" {}` 段落的所有配置选项。

## 概述

`output "NAME" {}` 段落用于配置显示器输出，包括分辨率、缩放、旋转、位置等设置。每个输出设备需要单独的配置段落。

## 基本结构

```kdl
output "eDP-1" {
    // 显示器配置选项
}

output "HDMI-A-1" {
    // 另一个显示器的配置
}
```

---

## 输出识别

niri支持两种方式识别显示器：

### 1. 连接器名称（推荐用于内置显示器）

```kdl
output "eDP-1" { }      // 内置笔记本显示器
output "HDMI-A-1" { }   // HDMI接口1
output "DP-2" { }       // DisplayPort接口2
output "DVI-D-1" { }    // DVI接口
```

**常见连接器名称**:
- `eDP-1`, `eDP-2` - 内置笔记本显示器
- `HDMI-A-1`, `HDMI-A-2` - HDMI接口
- `DP-1`, `DP-2`, `DP-3` - DisplayPort接口
- `DVI-D-1`, `DVI-I-1` - DVI接口
- `VGA-1` - VGA接口

**特点**:
- 大小写不敏感
- 与物理接口对应
- 内置显示器名称固定

### 2. 厂商型号序列号（推荐用于外接显示器）

```kdl
output "Dell Inc. DELL U2720Q F2XJFR7R" { }
output "Samsung Electric Company CF791 HCPK800000" { }
output "LG Electronics LG HDR 4K" { }
```

**格式**: `"厂商名称 型号 序列号"`
**特点**:
- 更精确识别，不依赖物理接口
- 适合多显示器环境
- 显示器更换接口时配置依然有效

**获取方式**: 使用 `niri msg outputs` 命令查看

---

## 显示器开关

### off - 关闭显示器

```kdl
output "HDMI-A-1" {
    off
}
```

- **类型**: 标志
- **默认值**: 开启
- **作用**: 完全关闭该显示器输出
- **使用场景**: 临时禁用某个显示器

---

## 显示模式配置

### mode - 分辨率和刷新率

```kdl
output "HDMI-A-1" {
    mode "1920x1080"           // 仅设置分辨率
    mode "1920x1080@60.000"    // 设置分辨率和刷新率
    mode "2560x1440@144.000"   // 高分辨率高刷新率
}
```

#### 格式说明
- **分辨率格式**: `"宽度x高度"`
- **刷新率格式**: `"宽度x高度@刷新率"`
- **刷新率精度**: 通常需要3位小数，如 `60.000`

#### 常见分辨率
- **1080p**: `"1920x1080"`
- **1440p**: `"2560x1440"`
- **4K**: `"3840x2160"`
- **超宽**: `"3440x1440"`, `"2560x1080"`

#### 获取可用模式
使用 `niri msg outputs` 查看每个显示器支持的所有模式和刷新率。

#### 示例输出解析
```bash
$ niri msg outputs
eDP-1:
  Available modes:
    1920x1080@60.000 (current)
    1920x1080@48.000
    1680x1050@60.000
```

---

## 缩放配置

### scale - 显示缩放

```kdl
output "eDP-1" {
    scale 1.5      // 150% 缩放
    scale 2.0      // 200% 缩放
    scale 0.8      // 80% 缩放（不推荐小于1.0）
}
```

- **类型**: 浮点数
- **默认值**: 1.0（无缩放）
- **范围**: 0.1 到 10.0
- **支持小数**: 是，如 1.25, 1.5, 1.75
- **作用**: UI元素缩放，适应不同DPI显示器

#### 常用缩放值
- **1.0** - 标准缩放（96 DPI）
- **1.25** - 轻微缩放（120 DPI）
- **1.5** - 中等缩放（144 DPI）
- **2.0** - 高缩放（192 DPI，常用于4K显示器）

#### 选择建议
- **低DPI显示器** (≤100): 1.0
- **中DPI显示器** (100-150): 1.25
- **高DPI显示器** (150-200): 1.5
- **超高DPI显示器** (>200): 2.0或更高

---

## 旋转变换

### transform - 显示旋转

```kdl
output "DP-1" {
    transform "normal"        // 正常方向
    transform "90"           // 顺时针90度
    transform "180"          // 180度
    transform "270"          // 顺时针270度（逆时针90度）
    transform "flipped"      // 水平翻转
    transform "flipped-90"   // 翻转后顺时针90度
    transform "flipped-180"  // 翻转后180度
    transform "flipped-270"  // 翻转后270度
}
```

- **类型**: 字符串
- **默认值**: `"normal"`

#### 可能的值详解
- **`"normal"`** - 正常显示，无变换
- **`"90"`** - 顺时针旋转90度（竖屏）
- **`"180"`** - 旋转180度（倒置）
- **`"270"`** - 顺时针旋转270度（相当于逆时针90度）
- **`"flipped"`** - 水平镜像翻转
- **`"flipped-90"`** - 先翻转再旋转90度
- **`"flipped-180"`** - 先翻转再旋转180度（垂直镜像）
- **`"flipped-270"`** - 先翻转再旋转270度

#### 使用场景
- **竖屏显示器**: 使用 `"90"` 或 `"270"`
- **平板模式**: 根据需要旋转
- **特殊安装**: 倒置安装时使用 `"180"`

---

## 位置布局

### position - 显示器位置

```kdl
output "eDP-1" {
    position x=0 y=0        // 主显示器在原点
}

output "HDMI-A-1" {
    position x=1920 y=0     // 1080p显示器右侧
}

output "DP-1" {
    position x=0 y=1080     // 显示器下方
}
```

- **类型**: 坐标对 `x=整数 y=整数`
- **默认值**: 自动计算
- **单位**: 逻辑像素（考虑缩放）
- **作用**: 定义显示器在虚拟桌面中的位置

#### 坐标系统
- **原点** (0,0): 左上角
- **X轴**: 向右为正
- **Y轴**: 向下为正
- **逻辑坐标**: 已考虑scale设置

#### 自动定位算法
1. **显式position优先**: 手动设置的position首先放置
2. **重叠处理**: 重叠时顺延到最右侧
3. **剩余显示器**: 按名称排序依次向右放置

#### 布局示例

**左右布局**:
```kdl
output "eDP-1" {
    mode "1920x1080"
    scale 1.5
    position x=0 y=0        // 缩放后实际宽度: 1920/1.5 = 1280
}

output "HDMI-A-1" {
    mode "1920x1080"
    position x=1280 y=0     // 紧接第一个显示器
}
```

**上下布局**:
```kdl
output "eDP-1" {
    mode "1920x1080"
    position x=0 y=0
}

output "HDMI-A-1" {
    mode "1920x1080"
    position x=0 y=1080     // 在第一个显示器下方
}
```

---

## 刷新率控制

### variable-refresh-rate - 可变刷新率

```kdl
output "HDMI-A-1" {
    variable-refresh-rate                 // 始终启用VRR
    variable-refresh-rate on-demand=true  // 按需启用VRR
}
```

- **类型**: 标志或带属性的标志
- **默认值**: 关闭
- **要求**: 显示器和显卡都支持VRR/FreeSync/G-Sync

#### 模式说明
- **无属性**: 始终启用VRR
- **`on-demand=true`**: 仅在需要时启用VRR

#### on-demand模式
需要配合窗口规则使用：

```kdl
output "HDMI-A-1" {
    variable-refresh-rate on-demand=true
}

window-rule {
    match app-id="^mpv$"              // 匹配视频播放器
    variable-refresh-rate true        // 为该窗口启用VRR
}
```

#### 注意事项
- **性能影响**: VRR可能导致光标低帧率
- **显示问题**: 某些显示器可能出现闪烁
- **兼容性**: 不是所有显示器都完美支持
- **调试**: 可使用debug选项排查问题

---

## 启动行为

### focus-at-startup - 启动时聚焦

```kdl
output "HDMI-A-1" {
    focus-at-startup
}
```

- **类型**: 标志
- **默认值**: 关闭
- **作用**: niri启动时优先聚焦到该显示器
- **多显示器**: 按配置出现顺序决定优先级

#### 使用场景
- 指定主显示器
- 多显示器环境下的启动行为控制

---

## 颜色配置

### background-color - 工作区背景色

```kdl
output "eDP-1" {
    background-color "#003300"    // 深绿色背景
}
```

- **类型**: 颜色字符串
- **默认值**: 使用layout中的background-color
- **格式**: CSS颜色格式
- **作用**: 该显示器上工作区的背景色

#### 颜色格式
- **十六进制**: `"#rgb"`, `"#rrggbb"`, `"#rrggbbaa"`
- **CSS名称**: `"red"`, `"blue"`, `"black"`
- **CSS函数**: `"rgb(0, 51, 0)"`, `"hsl(120, 100%, 10%)"`

### backdrop-color - 背景幕布色

```kdl
output "eDP-1" {
    backdrop-color "#333333"      // 深灰色幕布
}
```

- **类型**: 颜色字符串
- **默认值**: 使用overview中的backdrop-color
- **作用**: 工作区切换和总览时的背景色
- **Alpha通道**: 被忽略，始终不透明

---

## 配置示例

### 基础单显示器

```kdl
output "eDP-1" {
    mode "1920x1080@60.000"
    scale 1.25
    background-color "#1a1a1a"
}
```

### 双显示器左右布局

```kdl
// 主显示器（笔记本内屏）
output "eDP-1" {
    mode "1920x1080"
    scale 1.5
    position x=0 y=0
    focus-at-startup
}

// 外接显示器
output "Dell Inc. U2720Q F2XJFR7R" {
    mode "3840x2160@60.000"
    scale 2.0
    position x=1280 y=0  // 1920/1.5 = 1280
}
```

### 游戏显示器配置

```kdl
output "ASUS VG27AQ EXAMPLE123" {
    mode "2560x1440@144.000"
    scale 1.0
    variable-refresh-rate on-demand=true
    background-color "#000000"
}
```

### 竖屏副显示器

```kdl
// 主显示器
output "eDP-1" {
    mode "1920x1080"
    position x=0 y=0
    focus-at-startup
}

// 竖屏显示器（用于代码/文档）
output "Dell P2414H EXAMPLE" {
    mode "1920x1080"
    transform "90"
    position x=1920 y=0
}
```

### 三显示器环绕布局

```kdl
// 左侧显示器
output "Left Monitor" {
    mode "1920x1080"
    position x=0 y=0
}

// 中央主显示器
output "Center Monitor" {
    mode "2560x1440"
    position x=1920 y=0
    focus-at-startup
}

// 右侧显示器
output "Right Monitor" {
    mode "1920x1080"
    position x=4480 y=0  // 1920 + 2560
}
```

---

## 常见问题与解决方案

### 1. 显示器检测不到

**问题**: 配置的显示器名称不匹配

**解决方案**:
```bash
# 查看当前连接的显示器
niri msg outputs

# 使用准确的显示器名称
output "显示的确切名称" { }
```

### 2. 分辨率不支持

**问题**: 设置的mode显示器不支持

**解决方案**:
```bash
# 查看支持的模式
niri msg outputs

# 选择列出的可用模式
output "eDP-1" {
    mode "1920x1080@60.000"  # 使用精确的刷新率
}
```

### 3. 缩放模糊

**问题**: 非整数缩放导致界面模糊

**解决方案**:
- 优先使用整数缩放 (1.0, 2.0)
- 调整应用程序设置支持分数缩放
- 考虑调整分辨率而非缩放

### 4. 多显示器位置错乱

**问题**: 显示器位置计算错误

**解决方案**:
```kdl
// 手动计算逻辑位置
output "Monitor1" {
    mode "1920x1080"
    scale 1.5
    position x=0 y=0
    // 逻辑宽度 = 1920 / 1.5 = 1280
}

output "Monitor2" {
    position x=1280 y=0  // 紧接第一个显示器
}
```

### 5. VRR问题

**问题**: VRR导致光标或界面问题

**解决方案**:
```kdl
output "Gaming Monitor" {
    variable-refresh-rate on-demand=true  # 仅按需启用
}

// 配合调试选项
debug {
    skip-cursor-only-updates-during-vrr   // 跳过VRR时的光标更新
}
```

### 6. 颜色显示不正确

**问题**: 显示器颜色配置文件不匹配

**解决方案**:
- 检查系统颜色管理设置
- 调整显示器自身的颜色设置
- 考虑使用外部颜色管理工具

---

## 调试工具

### 1. niri msg outputs
显示所有输出的详细信息：
```bash
niri msg outputs
```

输出包括：
- 连接器名称
- 厂商型号序列号
- 支持的模式和刷新率
- 当前设置
- VRR能力

### 2. 实时配置测试
配置文件支持热重载，修改保存后立即生效，方便调试。

### 3. 日志查看
```bash
# 如果使用systemd
journalctl -ef /usr/bin/niri

# 查看配置错误
niri validate
```

---

## 高级配置技巧

### 1. 条件配置
为不同环境准备不同配置：

```kdl
// 工作环境 - 双显示器
output "Dell Inc. U2720Q OFFICE123" {
    mode "3840x2160@60.000"
    scale 2.0
    position x=1280 y=0
}

// 家庭环境 - 游戏显示器
output "ASUS VG27AQ HOME456" {
    mode "2560x1440@144.000"
    scale 1.0
    variable-refresh-rate on-demand=true
}
```

### 2. 性能优化配置
```kdl
output "Gaming Monitor" {
    mode "1920x1080@240.000"  // 高刷新率
    scale 1.0                 // 无缩放减少GPU负载
    variable-refresh-rate on-demand=true
}
```

### 3. 多工作区布局
```kdl
output "Code Monitor" {
    background-color "#1e1e1e"    // 深色背景适合编程
}

output "Design Monitor" {
    background-color "#f5f5f5"    // 浅色背景适合设计
}
```

这样可以为不同用途的显示器设置合适的背景色，提供更好的视觉体验。
