# RMPC 配置模块

RM```nix
myHome.dotfiles.rmpc = {
  enable = true;           # 启用 RMPC 配置
  method = "homemanager";  # 配置方式：homemanager / direct / external
  theme = "rose-pine";     # 主题选择：default / rose-pine / rose-pine-dawn / rose-pine-moon
};
```

## 主题支持

### 🌙 Rose Pine 主题系列

#### 1. Rose Pine (默认深色)
- **适用场景**: 日常使用，长时间音乐欣赏
- **特色**: 深紫色背景，护眼舒适
- **配色**: `#191724` 背景，`#c4a7e7` 强调色

#### 2. Rose Pine Dawn (浅色)
- **适用场景**: 白天使用，明亮环境
- **特色**: 米白色背景，温暖色调
- **配色**: `#faf4ed` 背景，`#907aa9` 强调色

#### 3. Rose Pine Moon (中等对比度)
- **适用场景**: 黄昏时光，中等光线环境
- **特色**: 深蓝紫背景，平衡对比度
- **配色**: `#232136` 背景，`#c4a7e7` 强调色

### 主题特性
- 🎨 官方 Rose Pine 色彩搭配
- 🌸 三种对比度变体可选
- ⭐ 高对比度，优化可读性
- 🎵 音乐专用界面优化

### 主题配置
- `default`: 使用 RMPC 内置默认主题
- `rose-pine`: Rose Pine 深色主题 (推荐)
- `rose-pine-dawn`: Rose Pine 浅色主题
- `rose-pine-moon`: Rose Pine 月光主题yer Client) 是一个现代化的 TUI MPD 客户端，支持专辑封面显示。

## 功能特性

- 🎵 现代化 TUI 界面，支持专辑封面显示
- � Vim 风格快捷键绑定
- �🎨 支持自定义主题（包括 Rose Pine 主题）
- � 三种配置管理方式：homemanager / direct / external
- 📱 响应式布局，支持多种面板视图
- 🔍 强大的搜索和浏览功能

## 配置选项

```nix
myHome.dotfiles.rmpc = {
  enable = true;           # 启用 RMPC 配置
  method = "homemanager";  # 配置方式：homemanager / direct / external
  theme = "rose-pine";     # 主题选择：default / rose-pine
};
```

## 主题支持

### Rose Pine 主题
- � 深色优雅配色方案
- 🎨 Rose Pine 官方色彩搭配
- 🌸 粉紫渐变色调
- ⭐ 高对比度，护眼设计

### 主题配置
- `default`: 使用 RMPC 内置默认主题
- `rose-pine`: 使用 Rose Pine 自定义主题

## 配置方式

### 1. HomeManager 方式（推荐）
```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "homemanager";  # 使用 Home Manager 管理配置
  theme = "rose-pine";     # 应用 Rose Pine 主题
};
```

### 2. Direct 方式（开发调试）
```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "direct";       # 直接写入配置文件
  theme = "rose-pine";
};
```

### 3. External 方式（外部文件）
```nix
myHome.dotfiles.rmpc = {
  enable = true;
  method = "external";     # 使用外部文件配置
  theme = "rose-pine";
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
