# Mako macOS Tahoe 风格通知 - 快速开始指南

> 🚀 3 分钟内配置出完美的 macOS Tahoe 风格通知系统

## ⚡ 一键应用

### 1. 应用深色主题（推荐）

编辑你的 NixOS 配置文件：

```nix
# 在 services.mako 配置中
services.mako = {
  enable = true;
  configFile = ./path/to/config;  # 深色主题
};
```

### 2. 安装必需字体和图标

```nix
# 在系统配置中添加
fonts.packages = with pkgs; [
  lxgw-wenkai  # LXGW WenKai Mono 字体
];

environment.systemPackages = with pkgs; [
  papirus-icon-theme  # Papirus 图标主题
];
```

### 3. 重建系统

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

## 🎨 主题选择

| 主题文件 | 适用场景 | 特色 |
|----------|----------|------|
| `config` | 深色壁纸、夜间使用 | ⭐ 推荐，深色毛玻璃 |
| `config-light` | 浅色壁纸、白天使用 | 🌞 明亮，浅色毛玻璃 |

## 🔧 快速切换主题

### 使用脚本（推荐）

```bash
# 安装主题切换器
cp theme-switcher.sh ~/.local/bin/mako-theme-switcher
chmod +x ~/.local/bin/mako-theme-switcher

# 切换到深色主题
mako-theme-switcher dark

# 切换到浅色主题
mako-theme-switcher light

# 自动选择（根据时间）
mako-theme-switcher auto

# 发送测试通知
mako-theme-switcher test
```

### 手动切换

```bash
# 复制主题文件到 mako 配置目录
mkdir -p ~/.config/mako
cp config ~/.config/mako/config
makoctl reload
```

## ✅ 验证配置

### 1. 测试通知

```bash
# 基础测试
notify-send "测试通知" "这是一个 macOS Tahoe 风格的测试通知"

# 紧急通知测试
notify-send -u critical "紧急通知" "测试紧急通知的红色样式"

# 成功通知测试
notify-send "任务完成" "测试成功通知的绿色样式"
```

### 2. 预期效果

✅ **正确效果**：
- 右上角显示通知
- 半透明毛玻璃背景
- LXGW WenKai Mono 字体
- 18px 圆角边框
- 应用程序图标显示
- 不同优先级的不同颜色

❌ **常见问题**：
- 不透明背景 → 检查合成器支持
- 方块字体 → 安装 LXGW WenKai 字体
- 无图标显示 → 安装 Papirus 图标主题
- 位置错误 → 检查 anchor 设置

## 🚨 故障排除

### 字体问题
```bash
# 检查字体安装
fc-list | grep -i wenkai

# 如果没有输出，重新安装字体
sudo nixos-rebuild switch
```

### 图标问题
```bash
# 检查图标主题
ls /run/current-system/sw/share/icons/ | grep -i papirus

# 更新图标缓存
gtk-update-icon-cache -f ~/.local/share/icons/
```

### mako 未启动
```bash
# 检查 mako 是否运行
pgrep mako

# 如果未运行，手动启动
mako &

# 检查配置文件语法
mako --help
```

## 🗝️ 常用快捷键设置

在 niri 配置中添加：

```kdl
binds {
    // 通知控制
    Mod+N { spawn "makoctl" "list"; }            // 显示通知
    Mod+Shift+N { spawn "makoctl" "dismiss" "-a"; } // 清除所有
    Escape { spawn "makoctl" "dismiss"; }        // 关闭最新
}
```

## 🎯 基础命令

| 命令 | 功能 |
|------|------|
| `makoctl list` | 显示当前通知 |
| `makoctl dismiss` | 关闭最新通知 |
| `makoctl dismiss -a` | 关闭所有通知 |
| `makoctl reload` | 重新加载配置 |
| `makoctl history` | 显示通知历史 |

## 🎨 主题特色

### 深色主题特点
- 极低透明度深色背景（6%）
- 浅色文本，高对比度
- 白色边框和分隔线
- 适合深色环境

### 浅色主题特点
- 极低透明度浅色背景（8%）
- 深色文本，清晰易读
- 黑色边框和分隔线
- 适合明亮环境

### 通知分类
- 🔵 **系统通知**: 蓝色强调
- 🔴 **错误/紧急**: 红色背景
- 🟢 **成功/完成**: 绿色背景
- 🟡 **音乐播放**: 绿色强调
- 🟣 **聊天消息**: 紫色强调
- 🟠 **邮件通知**: 橙色强调

## 🎵 测试不同类型通知

```bash
# 系统通知
notify-send -a "System" "系统更新" "有可用的系统更新"

# 音乐通知
notify-send -a "Music" "正在播放" "歌曲名称 - 艺术家"

# 聊天通知
notify-send -a "Discord" "新消息" "来自朋友的消息"

# 邮件通知
notify-send -a "Mail" "新邮件" "您有1封新邮件"

# 错误通知
notify-send -u critical "错误" "操作失败，请重试"

# 成功通知
notify-send "下载完成" "文件已成功下载到本地"
```

## 🔄 下一步

- 📖 阅读 [完整文档](./README.md) 了解详细配置
- 🎨 查看 [自定义指南](./README.md#自定义配置) 个性化主题
- 🔧 使用 [主题切换器](./theme-switcher.sh) 动态切换
- ⚙️ 探索 [高级用法](./README.md#高级用法) 扩展功能

## 💡 专业提示

1. **毛玻璃效果最佳实践**：选择有对比度的壁纸
2. **性能优化**：调整 `max-visible` 数量控制同时显示的通知
3. **主题切换**：配置 `mako-theme-switcher auto` 定时任务
4. **勿扰模式**：使用 `makoctl set-mode do-not-disturb` 专注工作

---

🎉 **恭喜！你现在拥有了最美观的 macOS Tahoe 风格通知系统！**

*如有问题，请查看 [README.md](./README.md) 或 [故障排除部分](./README.md#故障排除)*