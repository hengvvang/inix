# MPD (Music Player Daemon) 和 rmpc 配置使用指南

## 概述

你的系统现在已经配置好了 MPD (Music Player Daemon) 和 rmpc 客户端。MPD 是一个强大的音乐播放器守护进程，rmpc 是一个现代化的 Rust 编写的 MPD 客户端。

## 配置特点

### 系统级服务
- MPD 服务运行在系统级别
- 自动集成 PipeWire/PulseAudio 音频系统
- 支持多种音频格式 (MP3, FLAC, OGG, 等)
- 提供 HTTP 音频流功能

### 用户级配置
- 用户音乐目录：`~/Music`
- 自动服务管理
- 与现代音频栈集成

## 使用方法

### 1. 应用配置
首先切换配置以启用 MPD：

```bash
# 切换 Home Manager 配置
nix build .#homeConfigurations."hengvvang@laptop".activationPackage
./result/activate
```

### 2. 启动服务

#### 系统级 MPD
```bash
# 启动系统 MPD 服务
sudo systemctl start mpd

# 设置开机自启
sudo systemctl enable mpd

# 查看状态
mpd-ctl status
```

#### 用户级 MPD (推荐)
```bash
# 启动用户 MPD 服务
systemctl --user start mpd

# 设置开机自启
systemctl --user enable mpd

# 查看状态
systemctl --user status mpd
```

### 3. 音乐管理

#### 添加音乐文件
```bash
# 将音乐文件复制到音乐目录
cp /path/to/music/* ~/Music/

# 更新 MPD 数据库
mpc update

# 或使用管理脚本
mpd-ctl update
```

#### 使用 rmpc 客户端
```bash
# 启动 rmpc (终端图形界面)
rmpc

# 或使用包装脚本 (自动启动 MPD)
~/.local/bin/rmpc-wrapper
```

### 4. 基本操作

#### 命令行控制 (mpc)
```bash
# 播放/暂停
mpc toggle

# 下一首
mpc next

# 上一首
mpc prev

# 查看当前播放
mpc current

# 查看播放列表
mpc playlist

# 添加音乐到播放列表
mpc add "artist/album"

# 搜索音乐
mpc search artist "艺术家名称"
```

### 5. 客户端选择

#### rmpc (推荐 - 现代化 TUI)
- 键盘快捷键丰富
- 现代化界面
- 高性能 Rust 实现

#### ncmpcpp (经典 TUI)
```bash
ncmpcpp
```

#### mpc (命令行)
- 适用于脚本和自动化
- 轻量级

## 配置文件位置

### 系统级
- 配置：`/etc/mpd.conf`
- 数据目录：`/var/lib/mpd/`
- 音乐目录：`/home/music/`

### 用户级
- 配置：`~/.config/mpd/mpd.conf`
- 数据目录：`~/.local/share/mpd/`
- 音乐目录：`~/Music/`

## 高级功能

### HTTP 音频流
MPD 提供 HTTP 音频流功能，可以通过浏览器或其他设备访问：
```
http://localhost:8000
```

### 网络访问
默认只监听本地连接 (127.0.0.1:6600)，如需远程访问需要修改配置。

## 故障排除

### MPD 无法启动
```bash
# 检查日志
journalctl -u mpd -f

# 或用户服务
journalctl --user -u mpd -f

# 检查配置
mpd --no-daemon --verbose
```

### 音频无输出
```bash
# 检查音频系统
pavucontrol

# 检查 MPD 音频输出
mpc outputs

# 启用音频输出
mpc enable 1
```

### 权限问题
```bash
# 检查音乐目录权限
ls -la ~/Music/

# 修正权限
sudo chown -R $USER:$USER ~/Music/
```

## 管理脚本

系统提供了便捷的管理脚本：

```bash
# MPD 服务管理
mpd-ctl start    # 启动服务
mpd-ctl stop     # 停止服务
mpd-ctl restart  # 重启服务
mpd-ctl status   # 查看状态
mpd-ctl logs     # 查看日志
mpd-ctl update   # 更新数据库
mpd-ctl config   # 显示配置信息
mpd-ctl clients  # 显示推荐客户端
```

## 快速开始

1. 应用配置：`./result/activate`
2. 启动服务：`systemctl --user start mpd`
3. 添加音乐：`cp music/* ~/Music/ && mpc update`
4. 启动客户端：`rmpc`

享受你的音乐播放体验！🎵
