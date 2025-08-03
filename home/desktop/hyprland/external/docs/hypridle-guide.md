# 📋 Hypridle 详解 - Hyprland空闲管理守护程序

## 🎯 Hypridle 是什么？

**hypridle** 是Hyprland生态系统中的空闲检测和管理工具，类似于传统桌面环境中的屏幕保护程序和电源管理功能。它监控用户活动，在指定的空闲时间后执行预定义的操作。

### 🔥 主要功能
- 🕒 **空闲时间检测** - 监控鼠标、键盘活动
- 🔒 **自动锁屏** - 在空闲后自动锁定会话
- 💡 **屏幕管理** - 自动调节亮度、关闭屏幕
- 😴 **电源管理** - 自动睡眠、挂起系统
- 🔄 **恢复处理** - 用户活动恢复后的操作

## ⚙️ 配置文件位置

```bash
~/.config/hypr/hypridle.conf
```

## 📚 配置结构

### 1. **General 全局配置**

| 配置项 | 描述 | 类型 | 默认值 |
|--------|------|------|--------|
| `lock_cmd` | 接收dbus锁定事件时执行的命令 | string | empty |
| `unlock_cmd` | 接收dbus解锁事件时执行的命令 | string | empty |
| `on_lock_cmd` | 锁屏应用锁定会话时执行的命令 | string | empty |
| `on_unlock_cmd` | 锁屏应用解锁会话时执行的命令 | string | empty |
| `before_sleep_cmd` | 接收dbus准备睡眠事件时执行的命令 | string | empty |
| `after_sleep_cmd` | 接收dbus睡眠后事件时执行的命令 | string | empty |
| `ignore_dbus_inhibit` | 是否忽略dbus发送的空闲抑制事件 | bool | false |
| `ignore_systemd_inhibit` | 是否忽略systemd-inhibit抑制器 | bool | false |
| `ignore_wayland_inhibit` | 是否忽略Wayland协议空闲抑制器 | bool | false |
| `inhibit_sleep` | 睡眠抑制模式 (0-禁用,1-正常,2-自动,3-锁定通知) | int | 2 |

### 2. **Listener 监听器配置**

每个listener定义一个空闲时间段和对应的操作：

| 配置项 | 描述 | 类型 | 默认值 |
|--------|------|------|--------|
| `timeout` | 空闲时间（秒） | int | 必须指定 |
| `on-timeout` | 超时时执行的命令 | string | empty |
| `on-resume` | 恢复活动时执行的命令 | string | empty |
| `ignore_inhibit` | 忽略此规则的空闲抑制器 | bool | false |

## 💡 当前配置解析

你的配置实现了一个完整的电源管理方案：

### General 设置
```bash
general {
    lock_cmd = pidof hyprlock || hyprlock       # 锁屏命令（避免重复启动）
    before_sleep_cmd = loginctl lock-session    # 睡眠前锁定
    after_sleep_cmd = hyprctl dispatch dpms on  # 睡眠后唤醒显示器
}
```

### 监听器阶梯式管理
```bash
# 阶段1: 5分钟 - 亮度警告
listener {
    timeout = 300                               # 5分钟
    on-timeout = brightnessctl -s set 10%      # 降低亮度至10%
    on-resume = brightnessctl -r               # 恢复原亮度
}

# 阶段2: 6分钟 - 锁定屏幕
listener {
    timeout = 360                               # 6分钟
    on-timeout = loginctl lock-session          # 锁定会话
}

# 阶段3: 10分钟 - 关闭屏幕
listener {
    timeout = 600                               # 10分钟
    on-timeout = hyprctl dispatch dpms off     # 关闭显示器
    on-resume = hyprctl dispatch dpms on       # 活动时唤醒
}

# 阶段4: 30分钟 - 系统睡眠
listener {
    timeout = 1800                              # 30分钟
    on-timeout = systemctl suspend             # 系统挂起
}
```

## 🔧 常用配置示例

### 1. **简单锁屏配置**
```bash
general {
    lock_cmd = hyprlock
}

listener {
    timeout = 300                    # 5分钟后锁屏
    on-timeout = loginctl lock-session
}
```

### 2. **键盘背光管理**
```bash
listener {
    timeout = 150                                          # 2.5分钟
    on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # 关闭键盘背光
    on-resume = brightnessctl -rd rgb:kbd_backlight        # 恢复键盘背光
}
```

### 3. **多显示器配置**
```bash
listener {
    timeout = 300
    on-timeout = hyprctl dispatch dpms off DP-1    # 关闭特定显示器
    on-resume = hyprctl dispatch dpms on DP-1      # 唤醒特定显示器
}
```

### 4. **无睡眠配置**
```bash
general {
    inhibit_sleep = 0                # 禁用睡眠抑制
}

listener {
    timeout = 600
    on-timeout = hyprctl dispatch dpms off    # 只关屏不睡眠
    on-resume = hyprctl dispatch dpms on
}
```

## 🚀 高级功能

### 1. **抑制器管理**
```bash
general {
    ignore_dbus_inhibit = false        # 尊重Firefox等应用的抑制请求
    ignore_systemd_inhibit = false     # 尊重systemd抑制器
    ignore_wayland_inhibit = false     # 尊重Wayland抑制器
}
```

### 2. **智能睡眠抑制**
```bash
general {
    inhibit_sleep = 2    # 自动模式，根据是否启用hyprlock自动选择
}
```

### 3. **条件执行**
```bash
listener {
    timeout = 300
    on-timeout = [ $(hyprctl activewindow -j | jq -r .class) != "firefox" ] && loginctl lock-session
    ignore_inhibit = true    # 忽略抑制器，强制执行
}
```

## 📊 最佳实践

### 1. **渐进式超时设计**
```
1-2分钟：降低亮度（警告）
5分钟：锁定屏幕（安全）
10分钟：关闭屏幕（节能）
30分钟：系统睡眠（深度节能）
```

### 2. **命令执行策略**
- 使用 `pidof` 检查进程避免重复启动
- 使用 `loginctl` 进行会话管理
- 使用 `brightnessctl -s/-r` 保存/恢复亮度
- 使用 `hyprctl dispatch` 控制Hyprland功能

### 3. **错误处理**
```bash
on-timeout = pidof hyprlock || hyprlock    # 只在未运行时启动
on-timeout = timeout 5 hyprlock            # 5秒超时防止卡死
```

## 🔍 调试和测试

### 查看hypridle状态
```bash
# 检查是否运行
pgrep hypridle

# 查看日志
journalctl --user -u hypridle -f

# 手动启动调试
hypridle -v    # 详细输出
```

### 测试配置
```bash
# 修改超时时间为较短值进行测试
timeout = 10    # 10秒，用于测试

# 测试命令是否有效
loginctl lock-session
hyprctl dispatch dpms off
brightnessctl set 10%
```

## 💡 与其他工具集成

### 与hyprlock集成
```bash
general {
    lock_cmd = hyprlock
    before_sleep_cmd = loginctl lock-session
}
```

### 与waybar集成
```bash
# waybar可以显示空闲状态
on-timeout = pkill -SIGUSR1 waybar    # 通知waybar状态变更
```

### 与dunst集成
```bash
on-timeout = dunstctl set-paused true     # 暂停通知
on-resume = dunstctl set-paused false     # 恢复通知
```

你当前的配置已经非常完善，实现了从警告到睡眠的完整电源管理流程！🎉
