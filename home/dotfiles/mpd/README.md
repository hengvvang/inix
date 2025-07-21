# MPD 客户端工具配置说明

此配置专注于 MPD 客户端工具和用户脚本，MPD 服务本身在系统服务中配置。

## 重要说明

- **MPD 服务**: 配置在 `system/services/media/mpd.nix` 
- **客户端工具**: 配置在此模块 (`home/dotfiles/mpd/`)
- **rmpc 客户端**: 单独配置在 `home/dotfiles/rmpc/`

## 配置启用

在 Home Manager 配置中启用：

```nix
myHome.dotfiles.mpd = {
  enable = true;
  method = "homemanager";  # 推荐
};
```

## 系统服务配置

在 NixOS 配置中启用 MPD 系统服务：

```nix
mySystem.services.media.mpd = {
  enable = true;
  musicDirectory = "/srv/music";  # 系统音乐目录
  port = 6600;
  httpPort = 8000;  # HTTP 流端口，可设为 null 禁用
  enablePulseaudio = true;
  enableFileOutput = true;  # 用于音频可视化
};
```

## 客户端工具

### 安装的软件包
- `mpc-cli` - MPD 命令行客户端
- `ncmpcpp` - NCurses 终端客户端
- `cantata` - Qt 图形客户端
- `playerctl` - 通用媒体播放器控制
- `pavucontrol` - 音频控制面板

### 管理脚本

#### `mpd-client` - 主要客户端管理脚本
```bash
# 连接测试
mpd-client connect-test    # 测试 MPD 连接
mpd-client info           # 显示服务器信息

# 播放控制
mpd-client status         # 播放状态
mpd-client playlist       # 显示播放队列

# 音乐库操作
mpd-client search <关键词>      # 搜索音乐
mpd-client add-search <关键词>   # 搜索并添加到队列
mpd-client clear-queue          # 清空播放队列

# 播放列表管理
mpd-client save-playlist <名称>    # 保存当前队列
mpd-client load-playlist <名称>    # 加载播放列表
mpd-client list-playlists          # 列出播放列表

# 图形客户端
mpd-client ncmpcpp        # 启动 ncmpcpp
mpd-client cantata        # 启动 Cantata
```

#### `music-link` - 音乐目录链接管理
```bash
music-link setup          # 设置用户音乐目录链接
music-link remove         # 移除软链接
music-link status         # 显示目录状态
```

### Shell 别名
- `mpc` - 直接调用 mpc-cli
- `mpd-test` - 快速测试连接
- `mpd-info` - 显示 MPD 信息
- `mpd-ncmpcpp` - 启动 ncmpcpp

## 音乐目录管理

### 系统架构
```
/srv/music/           # 系统音乐目录 (MPD 读取)
├── user1/           # 用户1的音乐
├── user2/           # 用户2的音乐
└── shared/          # 共享音乐

/home/user/Music/    # 用户音乐目录 (软链接到 /srv/music/user/)
```

### 目录设置
1. 运行 `music-link setup` 创建用户音乐目录链接
2. 将音乐文件放入 `~/Music/`
3. 运行 `mpc update` 更新 MPD 数据库

## 环境变量

- `MPD_HOST` - MPD 服务器地址 (默认: localhost)
- `MPD_PORT` - MPD 服务器端口 (默认: 6600)

## 客户端使用

### ncmpcpp (终端客户端)
- 强大的 NCurses 界面
- 支持可视化、标签编辑等高级功能
- 键盘快捷键操作

### Cantata (图形客户端)  
- 现代 Qt 界面
- 支持专辑封面、歌词显示
- 适合桌面环境使用

### rmpc (现代终端客户端)
- 现代 Rust 编写的终端客户端
- 支持专辑封面显示（终端图像协议）
- 单独配置在 `home/dotfiles/rmpc/`

## 故障排除

### 无法连接 MPD
1. 检查 MPD 系统服务：`sudo systemctl status mpd`
2. 启动服务：`sudo systemctl start mpd`
3. 测试连接：`mpd-client connect-test`

### 音乐目录问题
1. 检查目录状态：`music-link status`
2. 重新设置链接：`music-link setup`
3. 更新数据库：`mpc update`

### 权限问题
1. 确保用户在 `audio` 组中
2. 检查音乐目录权限
3. 联系系统管理员

## 与系统服务集成

此客户端配置与系统 MPD 服务紧密集成：

1. **服务管理**: 使用 `mpd-admin` (系统脚本) 管理 MPD 服务
2. **客户端连接**: 使用 `mpd-client` (用户脚本) 操作 MPD
3. **音乐管理**: 通过软链接统一管理用户和系统音乐目录

## 相关配置

- MPD 系统服务: `system/services/media/mpd.nix`
- rmpc 客户端: `home/dotfiles/rmpc/`
- 音频系统: `system/services/media/`
