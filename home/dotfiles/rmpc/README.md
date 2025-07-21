# rmpc 配置说明

rmpc 是一个现代化的终端音乐播放器客户端，用于连接 MPD (Music Player Daemon)。

## 配置方法

本配置提供了三种不同的配置方法：

### 1. Home Manager 配置 (推荐)
- **方法**: `homemanager`
- **描述**: 使用 Home Manager 自动管理配置文件
- **优点**: 配置声明式管理，与 NixOS 集成良好
- **适用**: 大多数用户

### 2. 直接配置
- **方法**: `direct`  
- **描述**: 通过激活脚本直接写入配置文件
- **优点**: 配置生成后可独立使用
- **适用**: 需要手动调整配置的用户

### 3. 外部配置
- **方法**: `external`
- **描述**: 引用外部手动创建的配置文件
- **优点**: 完全手动控制配置
- **适用**: 高级用户或需要复杂自定义的场景

## 启用配置

在你的 Home Manager 配置中添加：

```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "homemanager";  # 或 "direct" 或 "external"
};
```

## 配置文件示例

提供了三种预设配置：

### 基础配置 (`configs/basic.ron`)
- 适合新用户
- 包含基本功能
- 简单的键位绑定
- 基本的界面布局

### 高级配置 (`configs/advanced.ron`)
- 包含所有功能
- 专辑封面显示
- 桌面通知
- 复杂的标签页布局
- 完整的键位绑定

### 极简配置 (`configs/minimal.ron`)
- 最小资源占用
- 禁用不必要功能
- 简化的界面
- 基本操作键位

## 使用方法

### 基本命令
- `rmpc` - 启动 rmpc
- `rmpc-wrapper` - 启动包装脚本（检查连接）
- `music-ctl` - 音乐控制脚本

### 音乐控制快捷命令
```bash
# 播放控制
music-ctl play      # 开始播放
music-ctl pause     # 暂停
music-ctl toggle    # 切换播放/暂停
music-ctl next      # 下一曲
music-ctl prev      # 上一曲

# 信息查询
music-ctl status    # 播放状态
music-ctl current   # 当前歌曲

# 音乐库管理
music-ctl update    # 更新数据库
music-ctl search <关键词>  # 搜索音乐
```

### rmpc 内置快捷键

#### 全局快捷键
- `q` - 退出
- `p` - 切换播放/暂停
- `>` - 下一曲
- `<` - 上一曲
- `+/=` - 音量+
- `-/,` - 音量-
- `z` - 切换重复模式
- `x` - 切换随机模式
- `~` - 显示帮助

#### 导航快捷键
- `j/k` - 上下移动
- `h/l` - 左右移动
- `g/G` - 顶部/底部
- `Ctrl+u/d` - 半页上下
- `Space` - 选择
- `Enter` - 确认

#### 标签页切换
- `Tab/Shift+Tab` - 下一个/上一个标签
- `1-7` - 直接切换到对应标签页

## 配置自定义

### 外部配置文件管理
如果使用外部配置方法，可以使用以下命令：

```bash
rmpc-config create    # 创建默认配置
rmpc-config edit      # 编辑配置文件
rmpc-config backup    # 备份配置
rmpc-config restore   # 恢复配置
rmpc-config validate  # 验证配置语法
rmpc-config show      # 显示配置内容
```

### 配置文件位置
- **配置文件**: `~/.config/rmpc/config.ron`
- **缓存目录**: `~/.cache/rmpc`
- **歌词目录**: `~/.local/share/rmpc/lyrics`
- **备份目录**: `~/.config/rmpc/backups`

## MPD 连接

rmpc 需要连接到 MPD 服务才能工作。确保：

1. MPD 服务正在运行
2. MPD 监听 `localhost:6600` （默认）
3. 没有设置密码，或在配置中正确设置了密码

检查 MPD 连接：
```bash
# 系统服务
sudo systemctl status mpd

# 用户服务  
systemctl --user status mpd

# 测试连接
music-ctl status
```

## 故障排除

### 无法连接 MPD
1. 检查 MPD 服务状态
2. 确认端口配置正确
3. 检查防火墙设置

### 配置文件错误
1. 使用 `rmpc-config validate` 检查语法
2. 参考示例配置文件
3. 查看 rmpc 日志输出

### 专辑封面不显示
1. 确认终端支持图像协议（Kitty、Sixel、iTerm2）
2. 检查 `album_art` 配置
3. 确认音乐文件包含封面信息

## 更多信息

- [rmpc 官方文档](https://mierak.github.io/rmpc/)
- [rmpc GitHub](https://github.com/mierak/rmpc)
- [MPD 官方文档](https://www.musicpd.org/doc/)
