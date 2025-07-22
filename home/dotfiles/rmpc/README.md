# RMPC (Rusty Music Player Client) 配置模块

RMPC 是一个现代化的 MPD（Music Player Daemon）客户端，使用 Rust 编写，支持专辑封面显示和可配置的界面主题。

## 功能特性

- 🎵 现代化的 TUI 界面
- 🎨 基于 TokyoNight 主题的配色方案
- 🖼️ 专辑封面显示支持（Kitty 协议）
- ⌨️ Vim 风格的键绑定
- 🎧 完整的 MPD 功能支持

## 配置方式

支持三种配置方式：

### 1. homemanager（推荐）
```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "homemanager";  # 默认值
};
```

### 2. direct（演示用）
```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "direct";
};
```

### 3. external（演示用）
```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "external";
};
```

## 键绑定说明

### 基本播放控制
- `Space`: 播放/暂停
- `n`: 下一首歌曲
- `p`: 上一首歌曲
- `s`: 停止播放
- `r`: 切换重复模式
- `z`: 切换随机播放

### 音量控制
- `+`: 音量增加
- `-`: 音量减少
- `m`: 静音切换

### 界面导航
- `1-6`: 切换标签页（队列、音乐库、搜索、目录、艺术家、专辑）
- `h/l`: 焦点左右移动
- `j/k`: 向上/向下导航
- `g/G`: 跳转到顶部/底部
- `Tab/Shift+Tab`: 切换面板

### 功能操作
- `Enter`: 确认/播放选中项
- `d`: 删除选中项
- `a`: 添加到队列
- `i`: 添加到队列下一个位置
- `/`: 搜索
- `Escape`: 关闭弹窗
- `f`: 切换专辑封面显示
- `F`: 全屏显示专辑封面

### 退出程序
- `Ctrl+C` 或 `q`: 退出 RMPC

## 主题配色

基于 TokyoNight 配色方案：
- 主色调：蓝色系 (#7aa2f7)
- 背景色：深色调 (#1a1b26)
- 文本色：浅色调 (#c0caf5)
- 高亮色：选中高亮 (#364a82)

## 前置条件

确保 MPD 服务正在运行：
```bash
# 检查 MPD 状态
systemctl --user status mpd

# 启动 MPD（如果未运行）
systemctl --user start mpd
```

## 使用方法

1. 启用配置后重新构建 Home Manager
2. 运行 `rmpc` 命令启动客户端
3. 使用键盘导航和控制音乐播放

## 配置文件位置

- 配置文件：`~/.config/rmpc/config.ron`
- 格式：RON (Rusty Object Notation)
