# Qutebrowser Dotfiles 配置

本配置为 Qutebrowser 浏览器提供了完整的 dotfiles 管理，严格遵循项目的设计模式。

## 配置结构

```
home/dotfiles/qutebrowser/
├── default.nix           # 主配置文件，定义选项和导入
├── homemanager.nix       # Home Manager 程序模块配置（推荐）
├── direct.nix            # 直接文件写入配置
├── external.nix          # 外部文件引用配置
└── configs/              # 外部配置文件目录
    ├── config.py         # Qutebrowser Python 配置
    └── quickmarks        # 快速书签
```

## 配置特性

### 🎯 核心功能
- **三种配置方式**：Home Manager 模块、直接文件、外部文件引用
- **深色模式**：启用网页深色模式
- **隐私保护**：禁用第三方 Cookie、地理位置、通知
- **键位绑定**：类 Vim 键位绑定
- **搜索引擎**：预配置多种搜索引擎
- **下载管理**：自动下载到 ~/Downloads

### 🔧 配置选项

在用户配置中启用：
```nix
myHome.dotfiles.qutebrowser = {
  enable = true;                    # 启用 Qutebrowser dotfiles
  method = "homemanager";           # 配置方式选择
};
```

支持的配置方式：
- `"homemanager"` - 使用 Home Manager 程序模块（默认，推荐）
- `"direct"` - 直接写入配置文件
- `"external"` - 引用外部配置文件

### ⌨️ 键位绑定

| 按键 | 功能 | 描述 |
|------|------|------|
| `J` | tab-next | 下一个标签页 |
| `K` | tab-prev | 上一个标签页 |
| `d` | tab-close | 关闭标签页 |
| `u` | undo | 恢复关闭的标签页 |
| `r` | reload | 刷新页面 |
| `R` | reload --force | 强制刷新页面 |
| `M` | bookmark-add | 添加书签 |
| `gb` | bookmark-load | 加载书签 |
| `gh` | history | 打开历史记录 |
| `F12` | devtools | 开发者工具 |
| `=` | zoom-in | 放大 |
| `-` | zoom-out | 缩小 |
| `0` | zoom | 重置缩放 |

### 🔍 搜索引擎

| 关键字 | 搜索引擎 |
|--------|----------|
| `g` | Google |
| `b` | Bing |
| `d` | DuckDuckGo |
| `gh` | GitHub |
| `w` | Wikipedia (中文) |
| `y` | YouTube |

### 📦 附加工具

配置自动安装以下工具：
- `yt-dlp` - YouTube 视频下载
- `mpv` - 视频播放器

## 启用配置

### 1. 启用 dotfiles 配置

在用户配置文件中添加：
```nix
myHome.dotfiles = {
  enable = true;
  qutebrowser.enable = true;
};
```

### 2. 启用浏览器应用包

确保安装 Qutebrowser 包：
```nix
myHome.pkgs.apps.browsers.enable = true;
```

### 3. 应用配置

```bash
# 切换 Home Manager 配置
home-manager switch --flake .#用户名@主机名

# 例如：
home-manager switch --flake .#hengvvang@laptop
```

## 已启用用户

- ✅ `hengvvang@laptop` - 完整功能配置
- ✅ `zlritsu@laptop` - 轻量级配置

## 自定义配置

### 修改配置方式

在用户配置中指定配置方式：
```nix
myHome.dotfiles.qutebrowser = {
  enable = true;
  method = "direct";  # 或 "external"
};
```

### 自定义外部配置

1. 修改 `configs/config.py` 文件
2. 设置配置方式为 `"external"`
3. 重新应用 Home Manager 配置

## 故障排除

### 配置不生效
1. 确认 dotfiles 和浏览器应用都已启用
2. 检查配置文件语法
3. 重新应用 Home Manager 配置

### 键位冲突
修改 `homemanager.nix` 中的 `keyBindings` 部分

### 自定义搜索引擎
修改 `searchEngines` 配置部分

## 更多信息

- Qutebrowser 官方文档：https://qutebrowser.org/doc/
- Home Manager 手册：https://nix-community.github.io/home-manager/
