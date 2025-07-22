# RMPC (Rusty Music Player Client) 配置模块

RMPC 是一个现代化的 MPD（Music Player Daemon）客户端，使用 Rust 编写，支持专辑封面显示和可配置的界面主题。

## 功能特性

- 🎵 现代化的 TUI 界面
- 🎨 支持自定义主题和默认主题
- 🖼️ 专辑封面显示支持（Auto 检测协议）
- ⌨️ Vim 风格的键绑定
- 🎧 完整的 MPD 功能支持
- 🔧 配置热重载支持

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
- `p` / `Space`: 播放/暂停
- `>`: 下一首歌曲
- `<`: 上一首歌曲
- `s`: 停止播放
- `z`: 切换重复模式
- `x`: 切换随机播放
- `c`: 切换消费模式
- `v`: 切换单曲模式

### 音量和进度控制
- `+` / `.`: 音量增加
- `-` / `,`: 音量减少
- `f`: 快进
- `b`: 快退

### 界面导航
- `1-7`: 切换标签页（队列、目录、艺术家、专辑艺术家、专辑、播放列表、搜索）
- `Tab`: 下一个标签页
- `Shift+Tab`: 上一个标签页
- `Ctrl+h/j/k/l`: 面板导航

### Vim 风格导航
- `h/j/k/l`: 左/下/上/右
- `g/G`: 跳转到顶部/底部
- `Ctrl+u/d`: 半页向上/向下
- `Space`: 选择项目
- `Ctrl+Space`: 反选
- `Enter`: 确认/播放

### 功能操作
- `a`: 添加到队列
- `A`: 添加全部
- `D`: 删除
- `r`: 重命名
- `B`: 显示信息
- `J/K`: 移动项目位置

### 搜索功能
- `/`: 进入搜索模式
- `n/N`: 下一个/上一个搜索结果
- `i`: 聚焦输入框

### 队列操作
- `Enter`: 播放选中歌曲
- `d`: 删除选中项目
- `D`: 清空整个队列
- `C`: 跳转到当前播放歌曲
- `X`: 随机排序队列
- `Ctrl+s`: 保存为播放列表
- `a`: 添加到播放列表

### 信息和管理
- `I`: 显示当前歌曲信息
- `O`: 显示输出设备
- `u`: 更新音乐数据库
- `U`: 重新扫描数据库
- `R`: 添加随机歌曲

### 退出和帮助
- `q`: 退出 RMPC
- `~`: 显示帮助信息
- `Esc` / `Ctrl+c`: 关闭弹窗/面板

## 配置特色

- **配置热重载**: 修改配置文件后自动生效
- **专辑封面**: 自动检测终端协议并显示专辑封面
- **智能搜索**: 支持多种搜索标签和不区分大小写搜索
- **灵活布局**: 队列页面分割显示专辑封面和播放列表
- **多语言支持**: 搜索标签支持中文显示

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

## 故障排除

如果遇到配置文件格式错误，可以：

1. 生成默认配置文件：
```bash
rmpc config > ~/.config/rmpc/config.ron
```

2. 检查配置文件语法：
```bash
rmpc config --current
```

3. 查看调试信息：
```bash
rmpc debug-info
```

## 配置文件位置

- 配置文件：`~/.config/rmpc/config.ron`
- 主题文件：`~/.config/rmpc/themes/`
- 格式：RON (Rusty Object Notation)
