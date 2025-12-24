# Vicinae 配置

Vicinae 是一个现代化的应用启动器,专为 Wayland 桌面环境设计。

## 启用配置

在你的 Home Manager 配置中添加:

```nix
myHome.dotfiles = {
  enable = true;

  vicinae = {
    enable = true;
    # 选择配置方式:
    # - "homeManager": 使用 Home Manager 生成配置 (推荐)
    # - "copyFiles": 直接复制配置文件
    configStyle = "homeManager";  # 或 "copyFiles"
  };
};
```

## 配置方式对比

### homeManager 方式 (推荐)

- **优点**:
  - 配置由 Nix 管理,完全声明式
  - 自动生成 JSON 配置
  - 可以轻松在不同系统间共享
  - 配置即代码,易于版本控制

- **缺点**:
  - 修改配置需要重新构建 Home Manager
  - 无法通过 GUI 直接修改配置

- **配置文件**: `home/dotfiles/nixMod/vicinae/default.nix`

### copyFiles 方式

- **优点**:
  - 可以通过 Vicinae GUI 直接修改配置
  - 修改立即生效,无需重新构建

- **缺点**:
  - GUI 修改会丢失注释和格式
  - 配置文件可能被覆盖

- **配置文件**: `home/dotfiles/homeDir/.config/vicinae/settings.json`

## 配置说明

### 窗口行为

```nix
close_on_focus_loss = true;    # 失去焦点时关闭窗口
pop_to_root_on_close = false;  # 关闭时保持搜索状态
consider_preedit = true;       # 支持中文输入法
```

### 搜索设置

```nix
search_files_in_root = true;   # 在主界面搜索文件
favicon_service = "twenty";    # Favicon 服务提供商
```

### 键盘绑定

```nix
keybinding = "default";  # Vim 风格键位
# "default" - Vim 风格 (Ctrl+J/K 上下, Ctrl+H/L 左右)
# "emacs"   - Emacs 风格 (Ctrl+N/P 上下, Ctrl+Alt+B/F 左右)
```

### 窗口外观

```nix
launcher_window = {
  opacity = 0.96;              # 窗口不透明度 (0.0-1.0)

  csd = {
    enabled = true;            # 使用客户端装饰
    rounding = 12;             # 圆角半径 (像素)
    border_width = 2;          # 边框宽度 (像素)
  };

  size = {
    width = 800;               # 窗口宽度
    height = 500;              # 窗口高度
  };
};
```

## 使用方法

### 启动 Vicinae

在终端运行:
```bash
vicinae toggle
```

或在 Niri 中绑定快捷键 (已配置 `Mod+/`):
```kdl
Mod+Slash { spawn "vicinae" "toggle"; }
```

### 查看默认配置

```bash
vicinae config default
```

### 查看当前配置

```bash
vicinae config current
```

## 快捷键

- `Ctrl+J/K` - 上下移动 (默认模式)
- `Ctrl+H/L` - 左右移动 (默认模式)
- `Enter` - 执行选中项
- `Esc` - 关闭窗口

## 功能特性

- **应用搜索**: 快速搜索并启动应用程序
- **文件搜索**: 搜索文件系统中的文件
- **剪贴板历史**: 访问剪贴板历史记录
- **自定义扩展**: 支持通过扩展添加更多功能

## 相关文档

- [官方文档](https://docs.vicinae.com/config)
- [GitHub 仓库](https://github.com/vicinaehq/vicinae)

## 依赖包

本配置会自动安装:
- `vicinae` - 主程序
- `lxgw-wenkai` - 霞鹜文楷字体 (用于中文显示)
