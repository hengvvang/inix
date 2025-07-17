# MPD (Music Player Daemon) 配置模块

## 📁 目录结构

```
mpd/
├── default.nix           # 主配置文件，定义选项和导入
├── homemanager.nix       # Home Manager 集成配置（推荐）
├── direct.nix           # 直接配置文件管理
├── external.nix         # 外部 MPD 服务器连接
└── configs/             # 象征性配置文件
    ├── mpd.conf         # 标准 MPD 配置文件模板
    ├── ncmpcpp_config   # ncmpcpp 客户端配置
    └── client.conf      # 客户端连接配置示例
```

## 🎵 配置方法

### homemanager（推荐）
使用 Home Manager 的内置 MPD 服务支持，提供完整的服务管理和配置。

**特点：**
- 自动服务管理
- 完整的音频输出配置
- 集成的客户端工具
- 便捷脚本和桌面启动器

**适用场景：** 个人桌面环境，需要完整的 MPD 体验

### direct
直接管理 MPD 配置文件，手动控制服务。

**特点：**
- 直接的配置文件控制
- 手动服务管理
- 轻量级配置

**适用场景：** 高级用户，需要精确控制 MPD 配置

### external
连接到外部 MPD 服务器的客户端配置。

**特点：**
- 只安装客户端工具
- 连接外部 MPD 服务
- 多客户端支持

**适用场景：** 连接到网络 MPD 服务器，或系统级 MPD 服务

## ⚙️ 配置选项

```nix
myHome.dotfiles.mpd = {
  enable = true;                    # 启用 MPD 配置
  method = "homemanager";           # 配置方法选择
};
```

### 方法选择
- `"homemanager"` - 使用 Home Manager 服务（推荐）
- `"direct"` - 直接配置文件管理
- `"external"` - 外部服务器客户端

## 🛠️ 提供的工具

### homemanager 方法
- `rmpc-wrapper` - rmpc 客户端包装脚本
- `music-manager` - 音乐库管理脚本
- 桌面启动器

### direct 方法
- `mpd-direct` - 直接启动 MPD 的脚本

### external 方法
- `mpd-connect` - 测试外部 MPD 连接
- `mpd-clients` - 客户端启动器

## 📋 使用示例

### 启用配置
```nix
# 在用户配置中
myHome.dotfiles.mpd = {
  enable = true;
  method = "homemanager";  # 或 "direct", "external"
};
```

### 快速开始
1. 启用配置并重建
2. 启动 MPD 服务（homemanager 方法自动管理）
3. 添加音乐到 `~/Music/` 目录
4. 使用 `rmpc` 或其他客户端播放音乐

## 🎯 设计特点

- **模块化设计：** 支持多种配置方法
- **完整工具链：** 从服务到客户端的完整支持
- **符合规范：** 遵循项目的 dotfiles 设计模式
- **配置文件：** 提供标准配置文件模板
- **便捷工具：** 丰富的管理和使用脚本

## 🔧 自定义配置

可以通过修改 `configs/` 目录下的配置文件来自定义 MPD 行为：

- `mpd.conf` - MPD 主配置
- `ncmpcpp_config` - ncmpcpp 客户端配置
- `client.conf` - 客户端连接配置

这些配置文件作为模板和参考，可以根据需要进行调整。
