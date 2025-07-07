# Media 配置简化说明

## ✅ 简化并启用完成

已将复杂的媒体配置简化为单一文件，保持层次化配置风格，并成功启用服务：

### 🚀 当前运行状态

- ✅ **MPV 播放器**: v0.40.0 已安装并配置
- ✅ **FFmpeg**: 完整版已安装，支持全格式编解码
- ✅ **yt-dlp**: 流媒体下载工具已安装
- ✅ **配置文件**: MPV 自动配置硬件加速和字幕支持

### 📁 简化前后对比

**简化前**:
```
system/services/media/
├── default.nix          # 复杂选项定义
└── players/
    ├── default.nix      # 播放器选项
    ├── video.nix        # 视频播放器实现
    ├── audio.nix        # 音频播放器实现
    ├── codecs.nix       # 编解码器实现
    ├── streaming.nix    # 流媒体工具实现
    └── advanced.nix     # 高级功能实现
```

**简化后**:
```
system/services/media/
└── default.nix         # 单文件完整实现
```

### 🎯 配置选项

```nix
mySystem = {
  services = {
    enable = true;
    media = {
      enable = true;                 # 🟢 启用媒体服务
      video = {
        enable = true;               # 启用视频播放器
        mpv = true;                  # MPV 播放器
        vlc = false;                 # VLC 播放器
      };
      audio = {
        enable = true;               # 启用音频播放器
        spotify = false;             # Spotify（需要时启用）
        audacious = false;           # Audacious
      };
      codecs = {
        enable = true;               # 启用编解码器
        ffmpeg = true;               # FFmpeg
        gstreamer = false;           # GStreamer
      };
      streaming = {
        enable = true;               # 启用流媒体工具
        download = true;             # yt-dlp 下载工具
      };
    };
  };
};
```

### 🔧 功能特性

- ✅ **视频播放器**: MPV（默认启用）、VLC（可选）
- ✅ **音频播放器**: Spotify、Audacious（可选）
- ✅ **编解码器**: FFmpeg 完整版（默认）、GStreamer（可选）
- ✅ **流媒体工具**: yt-dlp 下载工具
- ✅ **自动配置**: MPV 硬件加速和字幕支持

### 🚀 当前安装包

```bash
$ which mpv ffmpeg yt-dlp
/run/current-system/sw/bin/mpv      # MPV 播放器
/run/current-system/sw/bin/ffmpeg   # FFmpeg 编解码器
/run/current-system/sw/bin/yt-dlp   # 流媒体下载工具
```

### 📋 使用方式

#### 播放视频文件
```bash
mpv video.mp4                    # 播放本地视频
mpv https://example.com/video    # 播放在线视频
```

#### 下载在线视频
```bash
yt-dlp "https://youtube.com/watch?v=VIDEO_ID"     # 下载 YouTube 视频
yt-dlp -f best "URL"                              # 下载最高质量
yt-dlp --extract-audio "URL"                      # 仅下载音频
```

#### 视频格式转换
```bash
ffmpeg -i input.mp4 output.avi                   # 格式转换
ffmpeg -i input.mp4 -c:v h264 -c:a aac output.mp4 # 重新编码
```

### ⚙️ MPV 配置

自动生成的 `/etc/mpv/mpv.conf`:
```ini
# 基础配置
hwdec=auto                    # 自动硬件解码
vo=gpu                        # GPU 视频输出
profile=gpu-hq                # 高质量 GPU 配置

# 视频质量
scale=ewa_lanczossharp        # 高质量缩放算法
cscale=ewa_lanczossharp       # 色彩缩放算法

# 字幕支持
sub-auto=fuzzy                # 自动加载字幕
sub-file-paths=ass:srt:sub:subs:subtitles  # 字幕文件路径
```

### 🎯 扩展选项

需要额外功能时，可以启用：

```nix
mySystem.services.media = {
  enable = true;
  
  # 启用更多视频播放器
  video = {
    enable = true;
    mpv = true;
    vlc = true;                # 启用 VLC
  };
  
  # 启用音频播放器
  audio = {
    enable = true;
    spotify = true;            # 启用 Spotify
    audacious = true;          # 启用 Audacious
  };
  
  # 启用更多编解码器
  codecs = {
    enable = true;
    ffmpeg = true;
    gstreamer = true;          # 启用 GStreamer
  };
};
```

### 🔒 安全说明

- **开源优先**: 默认使用开源的 MPV 和 FFmpeg
- **最小权限**: 仅安装必要的编解码器
- **用户控制**: 专有软件（如 Spotify）需手动启用

---

**🎉 Media 配置简化完成！** 

从 6 个文件简化为 1 个文件，配置选项精简但功能完整，媒体播放和处理工具已成功安装启用。
