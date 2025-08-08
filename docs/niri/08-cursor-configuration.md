# Niri Cursor 光标配置详解

本文档详细介绍niri中 `cursor {}` 段落的所有配置选项。光标配置控制鼠标指针的外观、大小和行为。

## 概述

`cursor {}` 段落定义鼠标光标的视觉样式和交互行为，包括光标主题、大小、隐藏行为等选项。

## 基本结构

```kdl
cursor {
    // 光标主题
    xcursor-theme "Adwaita"          // X光标主题名称
    xcursor-size 24                  // 光标大小

    // 光标行为
    hide-after-inactivity-ms 3000    // 3秒无活动后隐藏
    hide-when-typing true            // 打字时隐藏光标
}
```

---

## 光标主题设置

### xcursor-theme - X光标主题

```kdl
cursor {
    xcursor-theme "Adwaita"          // GNOME默认主题
    xcursor-theme "breeze_cursors"   // KDE Breeze主题
    xcursor-theme "Vanilla-DMZ"      // 经典主题
    xcursor-theme "Numix-Cursor"     // Numix主题
    xcursor-theme "Oxygen"           // Oxygen主题
}
```

- **类型**: 字符串
- **默认值**: 系统默认（通常是"Adwaita"）
- **位置**: 通常在 `/usr/share/icons/` 或 `~/.icons/` 目录
- **作用**: 设置光标的视觉样式

#### 常见光标主题

**GNOME生态**:
- `"Adwaita"` - GNOME默认，现代简洁
- `"Adwaita-cursors"` - Adwaita变体
- `"gnome"` - 传统GNOME风格

**KDE生态**:
- `"breeze_cursors"` - KDE Plasma默认
- `"Oxygen"` - 旧版KDE主题
- `"Oxygen-Black"` - 黑色Oxygen主题

**第三方主题**:
- `"Numix-Cursor"` - 扁平设计风格
- `"Vanilla-DMZ"` - 经典简洁风格
- `"Bibata-Modern-Classic"` - 现代经典风格
- `"Capitaine"` - macOS风格
- `"Posy_Cursor"` - 小巧精致

#### 获取可用主题

```bash
# 查看系统安装的光标主题
ls /usr/share/icons/
ls ~/.icons/

# 查看主题详情
ls /usr/share/icons/Adwaita/cursors/
```

### xcursor-size - 光标大小

```kdl
cursor {
    xcursor-size 16                  // 小光标
    xcursor-size 24                  // 标准光标（推荐）
    xcursor-size 32                  // 大光标
    xcursor-size 48                  // 超大光标（适合高DPI）
    xcursor-size 64                  // 巨大光标（可访问性）
}
```

- **类型**: 整数
- **默认值**: 24
- **单位**: 像素
- **范围**: 8 到 128（实际依赖主题支持）

#### 大小选择指南

**标准显示器（96 DPI）**:
- **16-18** - 紧凑，适合小屏幕
- **24** - 标准大小，平衡可见性和精确度
- **32** - 较大，易于识别

**高DPI显示器（144+ DPI）**:
- **32** - 高DPI标准大小
- **48** - 高DPI大光标
- **64** - 高DPI超大光标

**可访问性需求**:
- **48+** - 视力辅助
- **64+** - 高对比度需求

---

## 光标隐藏行为

### hide-after-inactivity-ms - 无活动隐藏

```kdl
cursor {
    hide-after-inactivity-ms 3000    // 3秒后隐藏
    hide-after-inactivity-ms 5000    // 5秒后隐藏
    hide-after-inactivity-ms 1000    // 1秒后隐藏（快速）
    hide-after-inactivity-ms 0       // 关闭自动隐藏
}
```

- **类型**: 整数
- **单位**: 毫秒
- **默认值**: 0（不自动隐藏）
- **作用**: 鼠标无活动指定时间后自动隐藏光标

#### 使用场景配置

```kdl
// 观影模式 - 快速隐藏
cursor {
    hide-after-inactivity-ms 1500
}

// 标准桌面使用
cursor {
    hide-after-inactivity-ms 3000
}

// 演示模式 - 较长时间
cursor {
    hide-after-inactivity-ms 8000
}

// 始终显示
cursor {
    hide-after-inactivity-ms 0
}
```

### hide-when-typing - 打字时隐藏

```kdl
cursor {
    hide-when-typing true            // 打字时隐藏光标（推荐）
    hide-when-typing false           // 打字时不隐藏光标
}
```

- **类型**: 布尔值
- **默认值**: false
- **作用**: 键盘输入时自动隐藏光标，避免遮挡文本
- **恢复**: 鼠标移动时光标立即显示

#### 应用场景

**启用打字隐藏** (推荐大多数用户):
```kdl
cursor {
    hide-when-typing true
    hide-after-inactivity-ms 3000
}
```

**禁用打字隐藏** (适合需要光标定位的工作):
```kdl
cursor {
    hide-when-typing false
    hide-after-inactivity-ms 5000    // 较长时间后隐藏
}
```

---

## 光标主题安装和管理

### 安装光标主题

#### 通过包管理器安装

```bash
# Arch Linux
sudo pacman -S xcursor-themes
sudo pacman -S bibata-cursor-theme
sudo pacman -S numix-cursor-theme

# Ubuntu/Debian
sudo apt install dmz-cursor-theme
sudo apt install oxygen-cursor-theme
sudo apt install breeze-cursor-theme

# Fedora
sudo dnf install adwaita-cursor-theme
sudo dnf install oxygen-cursor-theme
```

#### 手动安装

```bash
# 下载主题到用户目录
mkdir -p ~/.icons
cd ~/.icons
wget -O theme.tar.gz "https://example.com/cursor-theme.tar.gz"
tar -xzf theme.tar.gz

# 或系统全局安装（需要root权限）
sudo tar -xzf theme.tar.gz -C /usr/share/icons/
```

### 主题结构

光标主题目录结构：
```
~/.icons/ThemeName/
├── index.theme          # 主题信息
├── cursors/            # 光标文件目录
│   ├── default         # 默认光标
│   ├── pointer         # 指针
│   ├── hand            # 手型
│   ├── text            # 文本光标
│   ├── wait            # 等待光标
│   └── ...
└── cursor.theme        # 配置文件（可选）
```

---

## 高级光标配置

### 环境变量配置

除了niri配置外，还可以通过环境变量设置光标：

```bash
# 在 ~/.profile 或 ~/.bashrc 中设置
export XCURSOR_THEME="Adwaita"
export XCURSOR_SIZE=24

# 临时设置
XCURSOR_THEME="breeze_cursors" XCURSOR_SIZE=32 niri
```

### 应用程序特定配置

某些应用可能需要特殊的光标设置：

```kdl
window-rule {
    match app-id="gimp-.*"
    // GIMP可能需要特定光标行为
    cursor {
        hide-when-typing false       // 设计工作时不隐藏光标
    }
}

window-rule {
    match app-id="mpv"
    cursor {
        hide-after-inactivity-ms 1000  // 视频播放时快速隐藏
    }
}
```

---

## 完整配置示例

### 1. 标准桌面配置

```kdl
cursor {
    xcursor-theme "Adwaita"
    xcursor-size 24
    hide-after-inactivity-ms 3000
    hide-when-typing true
}
```

### 2. 高DPI显示器配置

```kdl
cursor {
    xcursor-theme "Adwaita"
    xcursor-size 48                  // 高DPI适配
    hide-after-inactivity-ms 3000
    hide-when-typing true
}
```

### 3. 现代设计配置

```kdl
cursor {
    xcursor-theme "Bibata-Modern-Classic"
    xcursor-size 32
    hide-after-inactivity-ms 2000    // 较快隐藏
    hide-when-typing true
}
```

### 4. 经典简洁配置

```kdl
cursor {
    xcursor-theme "Vanilla-DMZ"
    xcursor-size 24
    hide-after-inactivity-ms 5000    // 较慢隐藏
    hide-when-typing false           // 始终显示
}
```

### 5. 可访问性配置

```kdl
cursor {
    xcursor-theme "Adwaita"
    xcursor-size 64                  // 大光标便于识别
    hide-after-inactivity-ms 0       // 不自动隐藏
    hide-when-typing false           // 打字时也显示
}
```

### 6. 游戏优化配置

```kdl
cursor {
    xcursor-theme "Adwaita"
    xcursor-size 24
    hide-after-inactivity-ms 0       // 游戏中不隐藏
    hide-when-typing false
}
```

### 7. 内容创作配置

```kdl
cursor {
    xcursor-theme "breeze_cursors"   // 精确的光标形状
    xcursor-size 32
    hide-after-inactivity-ms 10000   // 长时间后才隐藏
    hide-when-typing false           // 保持光标可见性
}
```

---

## 主题推荐

### 现代简约风格

```kdl
cursor {
    xcursor-theme "Adwaita"          // GNOME现代风格
    xcursor-size 24
}
```

### 扁平设计风格

```kdl
cursor {
    xcursor-theme "Numix-Cursor"     // 扁平化设计
    xcursor-size 24
}
```

### 经典风格

```kdl
cursor {
    xcursor-theme "Vanilla-DMZ"      // 经典简洁
    xcursor-size 24
}
```

### macOS风格

```kdl
cursor {
    xcursor-theme "Capitaine"        // 仿macOS风格
    xcursor-size 28
}
```

### 游戏风格

```kdl
cursor {
    xcursor-theme "Posy_Cursor"      // 小巧精准
    xcursor-size 20
}
```

---

## 故障排除

### 常见问题

1. **光标主题不生效**
   ```bash
   # 检查主题是否存在
   ls /usr/share/icons/Adwaita/cursors/
   ls ~/.icons/Adwaita/cursors/

   # 重启niri
   niri msg reload-config
   ```

2. **光标大小不合适**
   ```kdl
   cursor {
       xcursor-size 32  // 尝试不同大小
   }
   ```

3. **光标在某些应用中异常**
   ```bash
   # 设置环境变量
   export XCURSOR_THEME="Adwaita"
   export XCURSOR_SIZE=24
   ```

4. **高DPI显示器光标太小**
   ```kdl
   cursor {
       xcursor-size 48  // 高DPI需要更大光标
   }
   ```

### 调试命令

```bash
# 查看当前光标设置
echo $XCURSOR_THEME
echo $XCURSOR_SIZE

# 测试光标主题
xcursorgen input.cursor output.cursor

# 查看光标主题信息
find /usr/share/icons -name "index.theme" -exec grep -l cursor {} \;
```

---

## 性能考虑

### 光标性能优化

```kdl
cursor {
    xcursor-theme "Adwaita"          // 使用系统默认主题
    xcursor-size 24                  // 适中大小
    hide-after-inactivity-ms 2000    // 减少不必要的光标渲染
    hide-when-typing true            // 减少打字时的光标更新
}
```

### VRR环境下的光标

```kdl
cursor {
    xcursor-theme "Adwaita"
    xcursor-size 24
    hide-after-inactivity-ms 1000    // VRR环境下快速隐藏
}

debug {
    skip-cursor-only-updates-during-vrr true  // 避免VRR光标问题
}
```

---

## 与其他配置的协调

### 与主题系统协调

```kdl
cursor {
    xcursor-theme "Adwaita"          // 与GTK主题保持一致
}

// 在环境变量中也设置
// export GTK_THEME="Adwaita"
// export XCURSOR_THEME="Adwaita"
```

### 与input配置协调

```kdl
input {
    mouse {
        accel-speed 0.0              // 光标移动速度
        accel-profile "flat"         // 光标加速曲线
    }
}

cursor {
    xcursor-theme "Adwaita"
    xcursor-size 24
    hide-after-inactivity-ms 3000
    hide-when-typing true
}
```

### 与窗口规则协调

```kdl
window-rule {
    match app-id="mpv"
    // 视频播放时的光标行为由全局cursor配置控制
    // 但可以考虑应用特定的隐藏时间
}

cursor {
    hide-after-inactivity-ms 1500    // 全局较短隐藏时间
}
```

通过合理配置光标设置，可以获得与系统风格一致且使用舒适的光标体验。
