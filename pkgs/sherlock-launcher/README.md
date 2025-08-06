# Sherlock Launcher - 自定义包

这是一个自定义的 Sherlock Launcher Nix 包，提供比 nixpkgs 中更新的版本。

## 版本信息

- **当前版本**: 0.1.14-2 (最新发布版本)
- **nixpkgs 版本**: 0.1.11 (较旧)
- **主要改进**: 包含最新的功能和修复

## 新功能 (相比 nixpkgs 版本)

### v0.1.14 的主要功能：
- 🍅 **番茄工作法计时器**: 内置番茄钟功能
- 🎨 **表情符号选择器重制**: 改进的表情符号选择界面
- ⌨️ **自定义绑定和内部功能**: 更灵活的快捷键配置
- 🔧 **改进的配置系统**: 更好的配置文件管理

### v0.1.13 的功能：
- 🎨 **主题选择器**: 轻松切换主题
- 💱 **货币计算器**: 内置货币转换功能
- 🎭 **动画支持**: 重新启用动画效果
- 📸 **图片标志**: 支持图片显示

### v0.1.12 的功能：
- 🌫️ **窗口背景**: 背景模糊效果
- 📏 **窗口扩展**: 根据内容自动调整窗口大小
- 📝 **上下文菜单**: 右键菜单支持
- 😀 **表情符号选择器**: 表情符号快速选择

## 构建状态

✅ **构建成功** - 已在 NixOS 上成功编译和测试

```bash
# 构建命令
nix build .#sherlock-launcher

# 测试命令
result/bin/sherlock --version
# 输出: Sherlock v0.1.14
```

## 安装和使用

### 1. 获取正确的哈希值

运行更新脚本来获取最新的哈希值：

```bash
./pkgs/sherlock-launcher/update.sh
```

### 2. 构建包

```bash
nix build .#packages.x86_64-linux.sherlock-launcher
```

### 3. 安装到系统

在你的 NixOS 配置中添加：

```nix
environment.systemPackages = with pkgs; [
  # 其他包...
  self.packages.${system}.sherlock-launcher
];
```

或者在 Home Manager 中添加：

```nix
home.packages = with pkgs; [
  # 其他包...
  self.packages.${system}.sherlock-launcher
];
```

## 依赖关系

这个包需要以下依赖项：
- `gtk4` - GTK4 图形界面库
- `gtk4-layer-shell` - Wayland 层级 shell 支持
- `dbus` - 系统通信总线
- `wayland` - Wayland 协议支持
- `openssl` - SSL/TLS 支持
- `sqlite` - 数据库支持
- `gdk-pixbuf` - 图像处理
- `librsvg` - SVG 图像支持

## 配置

首次运行时，使用以下命令初始化配置：

```bash
sherlock init
```

这将在 `~/.config/sherlock/` 目录下创建配置文件：
- `config.toml` - 主配置文件
- `fallback.json` - 启动器配置
- `sherlock_alias.json` - 应用程序别名
- `main.css` - 自定义样式
- `sherlockignore` - 忽略的应用程序

## 使用示例

### 基本启动
```bash
sherlock
```

### 使用自定义配置
```bash
sherlock --config ~/.config/sherlock/config.toml
```

### 后台模式
```bash
sherlock --daemonize
```

## 故障排除

### 如果构建失败：

1. **检查哈希值**: 运行 `./pkgs/sherlock-launcher/update.sh` 确保哈希值是最新的
2. **检查依赖**: 确保所有必需的依赖都可用
3. **查看构建日志**: 检查具体的错误信息

### 如果运行时出错：

1. **检查 Wayland 支持**: Sherlock 主要为 Wayland 设计
2. **初始化配置**: 运行 `sherlock init` 创建默认配置
3. **检查权限**: 确保配置目录有正确的读写权限

## 参考链接

- [官方仓库](https://github.com/Skxxtz/sherlock)
- [官方文档](https://github.com/Skxxtz/sherlock/tree/main/docs)
- [配置指南](https://github.com/Skxxtz/sherlock/blob/main/docs/config.md)
- [启动器配置](https://github.com/Skxxtz/sherlock/blob/main/docs/launchers.md)

## 许可证

GPL-3.0 - 详见 [LICENSE](https://github.com/Skxxtz/sherlock/blob/main/LICENSE)
