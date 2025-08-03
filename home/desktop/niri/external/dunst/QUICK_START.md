# Dunst 快速开始指南

快速设置和使用 macOS Tahoe 风格的 Dunst 通知系统。

## 🚀 5分钟快速设置

### 1. 启用配置
确保在你的 NixOS 配置中启用了 Niri 和 Dunst：

```nix
myHome.desktop = {
  enable = true;
  preset = "niri";
  niri.method = "external";
};
```

### 2. 重建系统
```bash
sudo nixos-rebuild switch
```

### 3. 启动 Dunst
```bash
# Dunst 会自动启动，或手动启动
dunst &
```

### 4. 测试通知
```bash
# 发送测试通知
notify-send "欢迎" "Dunst 已成功配置！"

# 测试不同优先级
notify-send -u low "成功" "这是低优先级通知"
notify-send -u normal "信息" "这是普通通知"
notify-send -u critical "警告" "这是紧急通知"
```

## 🎨 主题切换

### 快速切换主题
```bash
# 切换到深色主题
dunst-theme-switcher dark

# 切换到浅色主题
dunst-theme-switcher light

# 自动检测系统主题
dunst-theme-switcher auto

# 在深浅主题间切换
dunst-theme-switcher toggle
```

## ⚡ 常用命令

### 基础控制
```bash
# 显示通知历史
dunst-control show

# 清除所有通知
dunst-control clear

# 重新加载配置
dunst-control reload

# 发送测试通知
dunst-control test
```

### 系统集成
```bash
# 音量通知
volume-notify volume

# 亮度通知
volume-notify brightness

# 媒体播放通知
media-notify

# 检查电池状态
battery-notify

# 检查网络状态
network-notify
```

## ⌨️ 键盘快捷键

- `Ctrl + Space` - 关闭当前通知
- `Ctrl + Shift + Space` - 关闭所有通知
- `Ctrl + \`` - 显示历史记录

## 🎯 通知样式预览

### 普通通知
```bash
notify-send "标题" "这是一个普通通知"
```

### 成功通知（自动为绿色）
```bash
notify-send "Success" "操作成功完成"
```

### 错误通知（自动为红色）
```bash
notify-send "Error" "发生了错误"
```

### 带进度条的通知
```bash
notify-send "下载" "正在下载..." -h int:value:50
```

## 🔧 自定义你的通知

### 1. 编辑配置文件
```bash
vim ~/.config/dunst/dunstrc
```

### 2. 重新加载配置
```bash
dunstctl reload
```

### 3. 测试修改
```bash
notify-send "测试" "配置已更新"
```

## 🐛 常见问题

### Q: 通知不显示？
```bash
# 检查 dunst 是否运行
pgrep dunst

# 重启 dunst
pkill dunst && dunst &
```

### Q: 字体显示异常？
```bash
# 检查字体是否安装
fc-list | grep "LXGW WenKai"
```

### Q: 主题切换不生效？
```bash
# 手动重新加载
dunstctl reload
```

## 📱 移动端风格的交互

- **左键点击** - 关闭通知
- **右键点击** - 关闭所有通知
- **滑动效果** - 通过合成器实现

## 🎉 完成！

现在你已经有了一个美观的 macOS 风格通知系统！

### 下一步
- 🎨 尝试不同的主题
- ⚙️ 自定义应用特定的样式
- 🔗 集成到你的工作流程中

## 📚 更多信息

查看完整的 `README.md` 获取详细配置说明。