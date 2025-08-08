# Niri Environment 环境变量配置详解

本文档详细介绍niri中 `environment {}` 段落的所有配置选项。环境变量配置用于设置影响应用程序行为的系统环境变量。

## 概述

`environment {}` 段落允许在niri启动时设置环境变量，这些变量会影响从niri启动的所有应用程序。这对于配置Wayland、主题、语言等全局设置非常重要。

## 基本结构

```kdl
environment {
    // Wayland相关变量
    WAYLAND_DISPLAY "wayland-1"

    // 主题和外观
    GTK_THEME "Adwaita"
    QT_QPA_PLATFORM "wayland"

    // 语言和区域
    LANG "zh_CN.UTF-8"
    LC_ALL "zh_CN.UTF-8"

    // 输入法
    GTK_IM_MODULE "fcitx"
    QT_IM_MODULE "fcitx"
    XMODIFIERS "@im=fcitx"
}
```

---

## Wayland环境配置

### 基础Wayland变量

```kdl
environment {
    // Wayland显示服务器
    WAYLAND_DISPLAY "wayland-1"           // Wayland显示名称

    // XDG相关
    XDG_SESSION_TYPE "wayland"            // 会话类型
    XDG_CURRENT_DESKTOP "niri"            // 当前桌面环境

    // Wayland安全
    WAYLAND_DISPLAY_SECURE "1"            // 安全模式（可选）
}
```

### 应用程序Wayland支持

```kdl
environment {
    // Qt应用程序
    QT_QPA_PLATFORM "wayland;xcb"         // 优先Wayland，回退X11
    QT_QPA_PLATFORMTHEME "gtk3"           // 使用GTK3主题
    QT_WAYLAND_DISABLE_WINDOWDECORATION "1"  // 禁用Qt窗口装饰

    // GTK应用程序
    GDK_BACKEND "wayland,x11"             // 优先Wayland，回退X11

    // Mozilla应用
    MOZ_ENABLE_WAYLAND "1"                // Firefox Wayland支持
    MOZ_WAYLAND_USE_VAAPI "1"             // 硬件加速

    // Java应用
    _JAVA_AWT_WM_NONREPARENTING "1"       // Java Wayland兼容

    // Electron应用
    ELECTRON_OZONE_PLATFORM_HINT "wayland" // Electron Wayland支持
}
```

---

## 主题和外观配置

### GTK主题设置

```kdl
environment {
    // GTK主题
    GTK_THEME "Adwaita"                   // 浅色主题
    GTK_THEME "Adwaita:dark"              // 深色主题

    // 图标主题
    GTK_ICON_THEME "Adwaita"              // GTK图标主题

    // 字体配置
    GTK_FONT_NAME "Sans 11"               // 默认字体

    // GTK设置
    GTK_USE_PORTAL "1"                    // 使用portals
    GTK_OVERLAY_SCROLLING "0"             // 禁用覆盖滚动条
}
```

### Qt主题设置

```kdl
environment {
    // Qt平台
    QT_QPA_PLATFORM "wayland"             // Qt Wayland平台
    QT_QPA_PLATFORMTHEME "gtk3"           // 使用GTK3主题样式

    // Qt样式
    QT_STYLE_OVERRIDE "Adwaita"           // Qt样式

    // Qt字体
    QT_FONT_DPI "96"                      // 字体DPI

    // Qt行为
    QT_AUTO_SCREEN_SCALE_FACTOR "1"       // 自动缩放
    QT_WAYLAND_DISABLE_WINDOWDECORATION "1"  // 禁用窗口装饰
}
```

### 光标主题

```kdl
environment {
    // X光标主题
    XCURSOR_THEME "Adwaita"               // 光标主题名称
    XCURSOR_SIZE "24"                     // 光标大小

    // Wayland光标
    WAYLAND_CURSOR_THEME "Adwaita"        // Wayland光标主题
    WAYLAND_CURSOR_SIZE "24"              // Wayland光标大小
}
```

---

## 输入法配置

### Fcitx输入法

```kdl
environment {
    // Fcitx输入法
    GTK_IM_MODULE "fcitx"                 // GTK应用输入法
    QT_IM_MODULE "fcitx"                  // Qt应用输入法
    XMODIFIERS "@im=fcitx"                // X11应用输入法

    // Fcitx Wayland支持
    FCITX_ENABLE_WAYLAND "1"              // 启用Wayland支持
}
```

### IBus输入法

```kdl
environment {
    // IBus输入法
    GTK_IM_MODULE "ibus"                  // GTK应用输入法
    QT_IM_MODULE "ibus"                   // Qt应用输入法
    XMODIFIERS "@im=ibus"                 // X11应用输入法

    // IBus Wayland支持
    IBUS_USE_PORTAL "1"                   // 使用portal
}
```

---

## 语言和区域设置

### 本地化配置

```kdl
environment {
    // 主要语言
    LANG "zh_CN.UTF-8"                    // 中文环境
    LANG "en_US.UTF-8"                    // 英文环境

    // 完整区域设置
    LC_ALL "zh_CN.UTF-8"                  // 所有区域设置
    LC_CTYPE "zh_CN.UTF-8"                // 字符分类
    LC_MESSAGES "zh_CN.UTF-8"             // 消息语言
    LC_TIME "zh_CN.UTF-8"                 // 时间格式
    LC_NUMERIC "zh_CN.UTF-8"              // 数字格式
    LC_MONETARY "zh_CN.UTF-8"             // 货币格式
}
```

### 混合语言环境

```kdl
environment {
    // 界面中文，其他英文
    LANG "zh_CN.UTF-8"                    // 基础语言
    LC_MESSAGES "zh_CN.UTF-8"             // 界面中文
    LC_TIME "en_US.UTF-8"                 // 时间英文格式
    LC_NUMERIC "en_US.UTF-8"              // 数字英文格式
    LC_MONETARY "zh_CN.UTF-8"             // 货币中文格式
}
```

---

## 硬件加速配置

### 显卡加速

```kdl
environment {
    // VAAPI硬件加速
    LIBVA_DRIVER_NAME "radeonsi"          // AMD显卡
    LIBVA_DRIVER_NAME "i965"              // Intel显卡
    LIBVA_DRIVER_NAME "nvidia"            // NVIDIA显卡

    // VDPAU加速
    VDPAU_DRIVER "radeonsi"               // AMD VDPAU
    VDPAU_DRIVER "va_gl"                  // 通用VDPAU

    // OpenGL
    MESA_GL_VERSION_OVERRIDE "4.6"        // OpenGL版本

    // Vulkan
    VK_ICD_FILENAMES "/usr/share/vulkan/icd.d/radeon_icd.x86_64.json"  // Vulkan驱动
}
```

### 媒体解码

```kdl
environment {
    // Firefox硬件加速
    MOZ_WAYLAND_USE_VAAPI "1"             // Firefox VAAPI
    MOZ_X11_EGL "1"                       // Firefox EGL

    // Chromium硬件加速
    CHROMIUM_FLAGS "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
}
```

---

## 开发和调试环境

### 调试变量

```kdl
environment {
    // Wayland调试
    WAYLAND_DEBUG "1"                     // Wayland协议调试

    // Mesa调试
    MESA_DEBUG "1"                        // Mesa调试信息
    LIBGL_DEBUG "verbose"                 // OpenGL调试

    // Qt调试
    QT_LOGGING_RULES "*.debug=true"       // Qt日志

    // GTK调试
    GTK_DEBUG "all"                       // GTK调试
    G_MESSAGES_DEBUG "all"                // GLib消息
}
```

### 开发工具

```kdl
environment {
    // 编辑器
    EDITOR "nvim"                         // 默认编辑器
    VISUAL "code"                         // 可视化编辑器

    // 构建工具
    CC "clang"                            // C编译器
    CXX "clang++"                         // C++编译器

    // 路径
    PATH "/home/user/.local/bin:/usr/local/bin:/usr/bin:/bin"
}
```

---

## 应用程序特定配置

### 浏览器优化

```kdl
environment {
    // Firefox优化
    MOZ_ENABLE_WAYLAND "1"                // Wayland支持
    MOZ_WAYLAND_USE_VAAPI "1"             // 硬件解码
    MOZ_X11_EGL "1"                       // EGL支持
    MOZ_USE_XINPUT2 "1"                   // 改进输入

    // Chromium优化
    CHROMIUM_FLAGS "--enable-features=UseOzonePlatform --ozone-platform=wayland"
}
```

### 游戏优化

```kdl
environment {
    // Steam
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES "1"  // 使用系统库

    // Wine/Proton
    WINE_STAGING_USE_VAAPI "1"            // Wine硬件加速
    DXVK_HUD "fps"                        // DXVK FPS显示

    // 游戏性能
    __GL_THREADED_OPTIMIZATIONS "1"       // NVIDIA多线程优化
    RADV_PERFTEST "aco"                   // AMD编译器优化
}
```

---

## 完整配置示例

### 1. 标准中文桌面环境

```kdl
environment {
    // 基础Wayland
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"
    XDG_CURRENT_DESKTOP "niri"

    // 应用程序支持
    QT_QPA_PLATFORM "wayland;xcb"
    QT_QPA_PLATFORMTHEME "gtk3"
    GDK_BACKEND "wayland,x11"
    MOZ_ENABLE_WAYLAND "1"

    // 中文环境
    LANG "zh_CN.UTF-8"
    LC_ALL "zh_CN.UTF-8"

    // 输入法
    GTK_IM_MODULE "fcitx"
    QT_IM_MODULE "fcitx"
    XMODIFIERS "@im=fcitx"

    // 主题
    GTK_THEME "Adwaita"
    XCURSOR_THEME "Adwaita"
    XCURSOR_SIZE "24"
}
```

### 2. 开发环境配置

```kdl
environment {
    // Wayland基础
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"
    XDG_CURRENT_DESKTOP "niri"

    // 应用程序支持
    QT_QPA_PLATFORM "wayland"
    GDK_BACKEND "wayland,x11"
    MOZ_ENABLE_WAYLAND "1"
    ELECTRON_OZONE_PLATFORM_HINT "wayland"

    // 英文环境
    LANG "en_US.UTF-8"
    LC_ALL "en_US.UTF-8"

    // 开发工具
    EDITOR "nvim"
    VISUAL "code"

    // 深色主题
    GTK_THEME "Adwaita:dark"

    // 路径
    PATH "/home/user/.cargo/bin:/home/user/.local/bin:/usr/local/bin:/usr/bin:/bin"
}
```

### 3. 游戏优化配置

```kdl
environment {
    // Wayland基础
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"

    // 硬件加速
    LIBVA_DRIVER_NAME "radeonsi"
    VDPAU_DRIVER "radeonsi"

    // 游戏优化
    RADV_PERFTEST "aco"
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES "1"
    __GL_THREADED_OPTIMIZATIONS "1"

    // 语言
    LANG "en_US.UTF-8"

    // 主题（性能优先）
    GTK_THEME "Adwaita"
}
```

### 4. 多媒体工作站配置

```kdl
environment {
    // Wayland基础
    WAYLAND_DISPLAY "wayland-1"
    XDG_SESSION_TYPE "wayland"
    XDG_CURRENT_DESKTOP "niri"

    // 应用程序支持
    QT_QPA_PLATFORM "wayland;xcb"
    GDK_BACKEND "wayland,x11"
    MOZ_ENABLE_WAYLAND "1"
    MOZ_WAYLAND_USE_VAAPI "1"

    // 硬件加速
    LIBVA_DRIVER_NAME "i965"              // Intel显卡
    VAAPI_MPEG4_ENABLED "true"

    // 高DPI支持
    QT_AUTO_SCREEN_SCALE_FACTOR "1"
    GDK_SCALE "1.5"
    XCURSOR_SIZE "32"

    // 语言
    LANG "zh_CN.UTF-8"
    LC_MESSAGES "zh_CN.UTF-8"
    LC_TIME "en_US.UTF-8"                 // 时间戳使用英文
}
```

---

## 环境变量优先级

### 设置优先级（从高到低）

1. **niri配置文件** (`environment {}`)
2. **systemd用户环境** (`~/.config/systemd/user/default.target.wants/`)
3. **会话启动脚本** (`~/.profile`, `~/.xprofile`)
4. **Shell配置** (`~/.bashrc`, `~/.zshrc`)
5. **系统默认** (`/etc/environment`)

### 避免冲突

```kdl
environment {
    // 在niri配置中设置的变量会覆盖其他来源
    EDITOR "nvim"                         // 覆盖shell设置
    QT_QPA_PLATFORM "wayland"             // 确保Qt使用Wayland
}
```

---

## 调试环境变量

### 查看当前环境

```bash
# 查看所有环境变量
env | sort

# 查看特定变量
echo $WAYLAND_DISPLAY
echo $QT_QPA_PLATFORM

# 从niri启动的应用程序环境
niri msg environment
```

### 测试环境变量

```bash
# 临时设置测试
WAYLAND_DISPLAY=wayland-2 firefox

# 验证应用程序是否使用正确的后端
ldd $(which firefox) | grep wayland
```

---

## 故障排除

### 常见问题

1. **应用程序不使用Wayland**
   ```kdl
   environment {
       GDK_BACKEND "wayland,x11"      // 确保Wayland优先
       QT_QPA_PLATFORM "wayland;xcb"  // Qt Wayland支持
   }
   ```

2. **输入法不工作**
   ```kdl
   environment {
       GTK_IM_MODULE "fcitx"
       QT_IM_MODULE "fcitx"
       XMODIFIERS "@im=fcitx"
       SDL_IM_MODULE "fcitx"          // 游戏输入法支持
   }
   ```

3. **字体渲染问题**
   ```kdl
   environment {
       FREETYPE_PROPERTIES "truetype:interpreter-version=40"
       FONTCONFIG_PATH "/etc/fonts"
   }
   ```

4. **主题不一致**
   ```kdl
   environment {
       GTK_THEME "Adwaita:dark"
       QT_QPA_PLATFORMTHEME "gtk3"    // Qt使用GTK主题
   }
   ```

通过合理配置环境变量，可以确保所有应用程序在niri环境中正常工作并具有一致的外观和行为。
