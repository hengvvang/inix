**关键特性**:
```ini
# 核心配色
background-color=#f5f5f715    # 极低透明度浅色背景（8%）
text-color=#1d1d1fff          # 深色文本
border-color=#00000012        # 极淡黑色边框
icon-path=Papirus-Light       # 浅色图标主题
```

**视觉效果**:
- 背景透明度 8%，温和的浅色毛玻璃效果
- 深色文本确保在浅色背景上的清晰度
- 柔和的边框和分隔线
- 适合明亮环境的配色方案


### 1. 应用主题

编辑 `default.nix` 文件：

```nix
# 使用深色主题（推荐）
services.mako = {
  enable = true;
  configFile = ./config;
};

# 或使用浅色主题
# services.mako = {
#   enable = true;
#   configFile = ./config-light;
# };
```

### 2. 安装必需依赖


```nix
# 字体
fonts.packages = with pkgs; [
  lxgw-wenkai  # LXGW WenKai Mono 字体
];

# 图标主题
environment.systemPackages = with pkgs; [
  papirus-icon-theme  # Papirus 图标主题
];
```

### 3. 重新构建系统

```bash
sudo nixos-rebuild switch
```

### 4. 启动 mako

在 niri 配置中添加：

```kdl
spawn-at-startup "mako"
```

或手动启动：

```bash
mako &
```


## ⚙️ 配置详解

### 通知布局

```ini
# 通知尺寸和位置
width=380                     # 通知宽度
height=120                    # 最大高度
margin=16                     # 屏幕边距
padding=20,24                 # 内边距：垂直20px，水平24px
anchor=top-right              # 右上角显示（macOS 风格）
```

### 字体配置

```ini
font=LXGW WenKai Mono 13      # 普通通知：13pt
font=LXGW WenKai Mono 12      # 低优先级：12pt  
font=LXGW WenKai Mono Bold 13 # 紧急通知：13pt 粗体
```

### 图标设置

```ini
icon-size=32                  # 标准图标大小
max-icon-size=48              # 最大图标大小
icon-path=/path/to/icons      # 图标主题路径
```

### 行为配置

```ini
default-timeout=5000          # 默认显示时间：5秒
max-visible=5                 # 最大同时显示数量
max-history=100               # 历史记录数量
group-by=app-name             # 按应用分组
```

## 🎨 优先级样式

### 低优先级通知 (`urgency=low`)
```ini
background-color=#1d1d1f12    # 更淡的背景
text-color=#8e8e93ff          # 较暗的文本
default-timeout=3000          # 3秒自动消失
font=LXGW WenKai Mono 12      # 较小字体
```

### 普通优先级通知 (`urgency=normal`)
- 使用默认样式配置
- 5秒自动消失
- 标准颜色和字体

### 紧急通知 (`urgency=critical`)
```ini
background-color=#ff453a25    # 红色背景
text-color=#ffffffff          # 白色文本
border-color=#ff453a80        # 红色边框
border-size=1.5               # 更粗边框
default-timeout=0             # 不自动消失
font=LXGW WenKai Mono Bold 13 # 粗体字体
```

## 🎯 应用专属样式

### 系统通知
```ini
[app-name="System"]
background-color=#007aff20     # 蓝色背景
border-color=#007aff60         # 蓝色边框
```

### 音乐播放器
```ini
[app-name="Music"]
[app-name="Spotify"]
background-color=#32d74b20     # 绿色背景
icon-size=40                   # 较大图标
```

### 聊天应用
```ini
[app-name="Discord"]
[app-name="Telegram"]
background-color=#5856d620     # 紫色背景
```

### 邮件应用
```ini
[app-name="Mail"]
background-color=#ff950020     # 橙色背景
```

### 错误通知
```ini
[summary~="[Ee]rror"]
[summary~="[Ff]ailed"]
background-color=#ff453a30     # 红色背景
border-size=2                  # 粗边框
```

### 成功通知
```ini
[summary~="[Ss]uccess"]
[summary~="[Cc]omplete"]
background-color=#32d74b25     # 绿色背景
```

## 🛠️ 实用命令

### Makoctl 控制命令

```bash
# 基础控制
makoctl list                  # 列出当前通知
makoctl dismiss               # 关闭最新通知
makoctl dismiss -a            # 关闭所有通知
makoctl history               # 显示通知历史
makoctl reload                # 重新加载配置
makoctl mode                  # 显示当前模式

# 高级控制
makoctl dismiss 123           # 关闭指定ID的通知
makoctl invoke 123            # 触发通知的默认操作
makoctl set-mode do-not-disturb  # 设置勿扰模式
```

### 发送测试通知

```bash
# 基础测试
notify-send "标题" "内容"

# 指定优先级
notify-send -u low "低优先级" "这是低优先级通知"
notify-send -u critical "紧急" "这是紧急通知"

# 指定应用名称
notify-send -a "Music" "正在播放" "歌曲名称"

# 带图标
notify-send -i "dialog-information" "信息" "带图标的通知"

# 持久通知（需要手动关闭）
notify-send -t 0 "持久通知" "不会自动消失"
```

## 🔧 自定义配置

### 调整透明度

如果觉得毛玻璃效果太淡或太重：

```ini
# 更明显的毛玻璃效果（深色主题）
background-color=#1d1d1f25    # 15% 不透明度

# 更淡的毛玻璃效果
background-color=#1d1d1f10    # 6% 不透明度

# 浅色主题调整
background-color=#f5f5f720    # 12% 不透明度（浅色）
```

### 调整通知尺寸

```ini
# 更小的通知
width=320
height=100
padding=16,20

# 更大的通知
width=420
height=140
padding=24,28
```

### 调整字体大小

```ini
# 较小字体
font=LXGW WenKai Mono 12

# 较大字体  
font=LXGW WenKai Mono 14
```

### 调整圆角

```ini
border-radius=12              # 较小圆角，更传统
border-radius=24              # 较大圆角，更现代
```

### 自定义颜色

```ini
# 自定义强调色
background-color=#ff2d9230    # 粉色强调
background-color=#af52de25    # 紫色强调
background-color=#ff950025    # 橙色强调
```

## 🗝️ 建议的快捷键

在 niri 配置中添加：

```kdl
binds {
    // 通知控制
    Mod+N { spawn "makoctl" "list"; }                    // 显示通知列表
    Mod+Shift+N { spawn "makoctl" "dismiss" "-a"; }     // 清除所有通知
    Escape { spawn "makoctl" "dismiss"; }                // 关闭最新通知
    
    // 主题切换
    Mod+Alt+N { spawn "mako-theme-switcher" "toggle"; } // 切换主题
    
    // 测试通知
    Mod+Ctrl+N { spawn "mako-theme-switcher" "test"; }  // 发送测试通知
}
```

## 🚨 故障排除

### 字体显示问题

**问题**: 字体显示为方块或不是预期字体

**解决方案**:
1. 检查字体安装：
   ```bash
   fc-list | grep -i "LXGW\|wenkai"
   ```

2. 确保 NixOS 配置包含字体：
   ```nix
   fonts.packages = with pkgs; [ lxgw-wenkai ];
   ```

3. 重建系统：
   ```bash
   sudo nixos-rebuild switch
   ```

### 透明效果不显示

**问题**: 看起来像普通的不透明窗口

**解决方案**:
1. 确认合成器正在运行（niri 用户通常不会遇到此问题）
2. 检查 mako 版本是否支持透明度
3. 尝试调整背景透明度值

### 图标不显示

**问题**: 只显示文本，没有图标

**解决方案**:
1. 安装 Papirus 图标主题：
   ```nix
   environment.systemPackages = with pkgs; [
     papirus-icon-theme
   ];
   ```

2. 检查图标路径：
   ```bash
   ls /run/current-system/sw/share/icons/ | grep -i papirus
   ```

3. 更新图标缓存：
   ```bash
   gtk-update-icon-cache -f ~/.local/share/icons/
   ```

### mako 无法启动

**问题**: mako 启动失败或崩溃

**解决方案**:
1. 检查配置文件语法：
   ```bash
   mako --help  # 查看配置选项
   ```

2. 使用调试模式启动：
   ```bash
   mako -c ~/.config/mako/config
   ```

3. 查看日志：
   ```bash
   journalctl -u mako --follow
   ```

### 通知位置不正确

**问题**: 通知显示在错误的位置

**解决方案**:
1. 检查 anchor 设置：
   ```ini
   anchor=top-right  # 右上角
   ```

2. 调整边距：
   ```ini
   margin=16  # 增加或减少边距
   ```

3. 检查多显示器设置：
   ```ini
   output=DP-1  # 指定显示器
   ```

## 💡 使用技巧

### 1. 智能过滤

创建过滤规则减少干扰：

```ini
# 隐藏空通知
[summary=""]
invisible=1

# 降低后台应用优先级
[app-name="Background App"]
urgency=low

# 限制重复通知
[app-name="System Monitor"]
max-history=3
```

### 2. 勿扰模式

```bash
# 启用勿扰模式
makoctl set-mode do-not-disturb

# 恢复正常模式
makoctl set-mode default

# 检查当前模式
makoctl mode
```

### 3. 通知历史

```bash
# 查看历史通知
makoctl history

# 以 JSON 格式输出
makoctl list | jq '.'

# 统计通知数量
makoctl list | jq 'length'
```

### 4. 脚本集成

创建智能通知脚本：

```bash
#!/bin/bash
# smart-notify.sh

app_name="$1"
summary="$2"
body="$3"
urgency="normal"

# 根据关键词自动判断优先级
if [[ "$summary" =~ [Ee]rror|[Ff]ailed|[Cc]ritical ]]; then
    urgency="critical"
elif [[ "$summary" =~ [Ss]uccess|[Cc]omplete|[Dd]one ]]; then
    urgency="low"
fi

# 发送通知
notify-send -u "$urgency" -a "$app_name" "$summary" "$body"
```

## 📚 高级用法

### 1. 动态主题切换

根据时间自动切换主题：

```bash
#!/bin/bash
# auto-theme-by-time.sh

hour=$(date +%H)
if [[ $hour -ge 6 && $hour -lt 18 ]]; then
    cp ~/.config/mako/config-light ~/.config/mako/config
else
    cp ~/.config/mako/config ~/.config/mako/config
fi
makoctl reload
```

### 2. 工作状态感知

根据工作状态调整通知：

```bash
#!/bin/bash
# work-mode-notify.sh

# 检查是否在工作时间
if [[ $(date +%H) -ge 9 && $(date +%H) -le 17 ]]; then
    # 工作时间：降低娱乐应用通知
    notify-send -u low -a "$1" "$2" "$3"
else
    # 非工作时间：正常通知
    notify-send -a "$1" "$2" "$3"
fi
```

### 3. 电池状态集成

```bash
#!/bin/bash
# battery-notify.sh

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
charging=$(cat /sys/class/power_supply/BAT0/status)

if [[ $battery_level -le 20 && "$charging" != "Charging" ]]; then
    notify-send -u critical -a "Battery" "电池电量低" "当前电量：${battery_level}%"
elif [[ $battery_level -ge 90 && "$charging" == "Charging" ]]; then
    notify-send -u low -a "Battery" "充电完成" "当前电量：${battery_level}%"
fi
```

## 🎨 配色方案参考

### macOS 标准配色

| 颜色 | 深色模式 | 浅色模式 | 用途 |
|------|----------|----------|------|
| 蓝色 | `#007AFF` | `#007AFF` | 系统通知 |
| 红色 | `#FF453A` | `#FF3B30` | 错误、紧急 |
| 绿色 | `#32D74B` | `#34C759` | 成功、完成 |
| 橙色 | `#FF9F0A` | `#FF9500` | 警告、邮件 |
| 紫色 | `#BF5AF2` | `#AF52DE` | 聊天、社交 |
| 粉色 | `#FF2D92` | `#FF2D55` | 特殊强调 |

### 透明度级别

| 用途 | 深色主题 | 浅色主题 | 效果 |
|------|----------|----------|------|
| 主背景 | `18` (6%) | `15` (8%) | 毛玻璃效果 |
| 低优先级 | `12` (5%) | `10` (4%) | 更淡背景 |
| 紧急通知 | `25` (15%) | `30` (18%) | 更明显背景 |
| 应用专属 | `20` (12%) | `25` (15%) | 中等强调 |

## 📖 参考资料

- [Mako 官方文档](https://github.com/emersion/mako)
- [macOS 设计指南](https://developer.apple.com/design/human-interface-guidelines/)
- [LXGW WenKai 字体](https://github.com/lxgw/LxgwWenKai)
- [Papirus 图标主题](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- [FreeDesktop 通知规范](https://specifications.freedesktop.org/notification-spec/)