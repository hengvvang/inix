# 多用户 MPD 配置使用指南

## 🎯 配置概述

你的系统现在配置了用户级 MPD 服务，每个用户都有独立的音乐播放服务：

### 👤 用户配置

| 用户 | 音乐目录 | MPD 端口 | RMPC 配置 |
|------|----------|----------|-----------|
| **hengvvang** | `/home/hengvvang/Music` | 6600 | ✅ 已配置 |
| **zlritsu** | `/home/zlritsu/Music` | 6601 | 待配置 RMPC |

## 📂 音乐目录结构

每个用户的音乐文件应该放在自己的 `Music` 目录下：

```
/home/hengvvang/Music/          # hengvvang 用户的音乐库
├── Artist1/
│   ├── Album1/
│   │   ├── 01 - Song1.mp3
│   │   └── cover.jpg
│   └── Album2/
└── Artist2/

/home/zlritsu/Music/            # zlritsu 用户的音乐库  
├── Artist3/
│   ├── Album3/
│   └── Album4/
└── Artist4/
```

## 🚀 使用方法

### 1. 初始设置

每个用户都需要先创建自己的音乐目录：

```bash
# 创建音乐目录
mkdir -p ~/Music

# 复制音乐文件到目录中
cp -r /path/to/your/music/* ~/Music/
```

### 2. MPD 服务管理

使用 `mpd-user` 脚本管理服务：

```bash
# 启动 MPD 服务
mpd-user start

# 查看服务状态
mpd-user status

# 更新音乐数据库
mpd-user update

# 查看统计信息
mpd-user stats

# 设置开机自启
mpd-user enable
```

### 3. 使用 RMPC 客户端

```bash
# 启动 rmpc（hengvvang 用户）
rmpc

# 对于 zlritsu 用户，需要配置 RMPC 连接到端口 6601
# 编辑 ~/.config/rmpc/config.ron，修改：
# address: "127.0.0.1:6601",
```

## ⚙️ 配置详情

### MPD 配置特点：

- ✅ **用户独立**：每个用户有自己的音乐库和播放列表
- ✅ **权限隔离**：用户只能访问自己的音乐文件
- ✅ **端口分离**：不同用户使用不同端口避免冲突
- ✅ **自动启动**：系统启动后自动启动 MPD 服务
- ✅ **现代音频**：集成 PipeWire 音频系统

### 音频输出：

1. **主输出**：PipeWire（现代 Linux 音频系统）
2. **流媒体**：HTTP 流输出（端口 8000/8001）

## 🔧 配置切换

应用新配置：

```bash
# 构建新配置
nix build .#homeConfigurations."hengvvang@laptop".activationPackage

# 激活配置
./result/activate

# 启动 MPD 服务
mpd-user start

# 更新音乐数据库
mpd-user update
```

## 📊 监控和调试

### 查看服务状态
```bash
# MPD 服务状态
systemctl --user status mpd

# 服务日志
journalctl --user -u mpd -f
```

### 测试连接
```bash
# 测试 MPD 连接
mpc status

# 查看可用输出设备
mpc outputs
```

## 🎵 使用建议

1. **音乐格式**：推荐使用 FLAC、MP3、OGG 等常见格式
2. **目录结构**：按照"艺术家/专辑/歌曲"的结构组织音乐文件
3. **封面图片**：在专辑目录中放置 `cover.jpg` 文件
4. **标签信息**：确保音乐文件有正确的元数据标签

## ❓ 故障排除

### 服务无法启动
```bash
# 检查配置文件
cat ~/.config/mpd/mpd.conf

# 手动启动调试
mpd --no-daemon --verbose ~/.config/mpd/mpd.conf
```

### RMPC 连接失败
```bash
# 检查 MPD 是否运行
mpd-user status

# 测试网络连接
telnet 127.0.0.1 6600
```

### 音乐库无法更新
```bash
# 检查目录权限
ls -la ~/Music/

# 手动更新
mpc update --wait
```

## 🔄 从旧配置迁移

如果你之前使用系统级 MPD，可以迁移音乐文件：

```bash
# 从旧系统目录迁移
sudo cp -r /srv/music/* ~/Music/
chown -R $USER:$USER ~/Music/

# 更新数据库
mpd-user update
```

这样，每个用户都有独立的音乐播放环境，互不干扰！
