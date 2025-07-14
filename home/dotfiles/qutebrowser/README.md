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

## 配置特性 🚀

### 🎯 Zen Browser 兼容性
- **完整快捷键映射**：与 Zen Browser 快捷键 100% 兼容
- **无缝迁移体验**：零学习成本，直接使用熟悉的快捷键
- **功能增强**：在保持兼容的基础上添加了 vim 风格的额外操作
- **渐进式学习**：可选的高级快捷键，逐步提升效率

### 🔧 核心功能
- **三种配置方式**：Home Manager 模块、直接文件、外部文件引用
- **智能搜索**：增量搜索，智能大小写，Nix 包搜索
- **隐私保护**：禁用第三方 Cookie、地理位置、通知，基础广告拦截
- **性能优化**：50MB 缓存，快速补全，10秒下载清理

### ⌨️ 键位绑定（Zen Browser 兼容）

#### 标签管理
| 按键 | 功能 | 兼容性 |
|------|------|--------|
| `Ctrl+T` | 新标签 | ✅ Zen Browser |
| `Ctrl+W` | 关闭标签 | ✅ Zen Browser |
| `Ctrl+Shift+T` | 恢复关闭的标签 | ✅ Zen Browser |
| `Ctrl+Shift+W` | 关闭窗口 | ✅ Zen Browser |
| `Ctrl+Tab` | 下一个标签 | ✅ Zen Browser |
| `Ctrl+Shift+Tab` | 上一个标签 | ✅ Zen Browser |
| `Alt+1-8` | 切换到指定标签 | ✅ Zen Browser |
| `Alt+9` | 切换到最后标签 | ✅ Zen Browser |

#### 导航操作
| 按键 | 功能 | 兼容性 |
|------|------|--------|
| `Alt+←` | 后退 | ✅ Zen Browser |
| `Alt+→` | 前进 | ✅ Zen Browser |
| `Ctrl+[` | 后退 (替代) | ✅ Zen Browser |
| `Ctrl+]` | 前进 (替代) | ✅ Zen Browser |
| `Ctrl+R` | 刷新页面 | ✅ Zen Browser |
| `Ctrl+Shift+R` | 强制刷新 | ✅ Zen Browser |

#### 搜索和查找
| 按键 | 功能 | 兼容性 |
|------|------|--------|
| `Ctrl+K` | 搜索聚焦 | ✅ Zen Browser |
| `Ctrl+J` | 搜索聚焦 (替代) | ✅ Zen Browser |
| `Ctrl+F` | 页面查找 | ✅ Zen Browser |
| `Ctrl+G` | 查找下一个 | ✅ Zen Browser |
| `Ctrl+Shift+G` | 查找上一个 | ✅ Zen Browser |

#### 页面操作
| 按键 | 功能 | 兼容性 |
|------|------|--------|
| `Ctrl+L` | 地址栏聚焦 | ✅ Zen Browser |
| `Alt+D` | 地址栏聚焦 (替代) | ✅ Zen Browser |
| `Ctrl+D` | 添加书签 | ✅ Zen Browser |
| `Ctrl+Shift+D` | 添加书签 (替代) | ✅ Zen Browser |
| `Ctrl+B` | 书签管理 | ✅ Zen Browser |

#### 缩放控制
| 按键 | 功能 | 兼容性 |
|------|------|--------|
| `Ctrl++` | 放大 | ✅ Zen Browser |
| `Ctrl+=` | 放大 (无 Shift) | ✅ Zen Browser |
| `Ctrl+-` | 缩小 | ✅ Zen Browser |
| `Ctrl+0` | 重置缩放 | ✅ Zen Browser |

#### 开发者工具
| 按键 | 功能 | 兼容性 |
|------|------|--------|
| `F12` | 开发者工具 | ✅ Zen Browser |
| `Ctrl+Shift+I` | 开发者工具 | ✅ Zen Browser |
| `Ctrl+Shift+J` | 浏览器控制台 | ✅ Zen Browser |
| `Ctrl+Shift+K` | Web 控制台 | ✅ Zen Browser |

### ⌨️  核心键位绑定（Zen Browser 官方兼容）

#### 标签管理 (Window & Tab Management)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+T` | 新建标签 | ✅ 完全一致 |
| `Ctrl+W` | 关闭标签 | ✅ 完全一致 |
| `Ctrl+Shift+W` | 关闭窗口 | ✅ 完全一致 |
| `Ctrl+Q` | 退出应用 | ✅ 完全一致 |
| `Ctrl+Shift+T` | 恢复已关闭标签 | ✅ 完全一致 |
| `Alt+1-8` | 选择标签 1-8 | ✅ 完全一致 |
| `Alt+9` | 选择最后一个标签 | ✅ 完全一致 |
| `Ctrl+Tab` | 下一个标签 | ✅ 完全一致 |
| `Ctrl+Shift+Tab` | 上一个标签 | ✅ 完全一致 |

#### 导航 (Navigation)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Alt+←` | 后退 | ✅ 完全一致 |
| `Alt+→` | 前进 | ✅ 完全一致 |
| `Ctrl+[` | 后退（备用） | ✅ 完全一致 |
| `Ctrl+]` | 前进（备用） | ✅ 完全一致 |
| `Alt+Home` | 主页 | ✅ 完全一致 |
| `Ctrl+R` | 刷新页面 | ✅ 完全一致 |
| `Ctrl+Shift+R` | 强制刷新 | ✅ 完全一致 |
| `Ctrl+H` | 历史记录 | ✅ 完全一致 |
| `Ctrl+Shift+P` | 私有窗口 | ✅ 完全一致 |

#### 搜索和查找 (Search & Find)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+K` | 聚焦搜索 | ✅ 完全一致 |
| `Ctrl+J` | 聚焦搜索（备用） | ✅ 完全一致 |
| `Ctrl+F` | 页面查找 | ✅ 完全一致 |
| `Ctrl+G` | 查找下一个 | ✅ 完全一致 |
| `Ctrl+Shift+G` | 查找上一个 | ✅ 完全一致 |

#### 页面操作 (Page Operations)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+L` | 地址栏聚焦 | ✅ 完全一致 |
| `Alt+D` | 地址栏聚焦（备用） | ✅ 完全一致 |
| `Ctrl+S` | 保存页面 | ✅ 完全一致 |
| `Ctrl+P` | 打印页面 | ✅ 完全一致 |
| `Ctrl+U` | 查看源代码 | ✅ 完全一致 |

#### 历史和书签 (History & Bookmarks)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+Shift+H` | 显示所有历史 | ✅ 完全一致 |
| `Ctrl+D` | 添加书签 | ✅ 完全一致 |
| `Ctrl+Shift+D` | 添加书签（备用） | ✅ 完全一致 |
| `Ctrl+Shift+O` | 显示书签库 | ✅ 完全一致 |

#### 媒体和显示 (Media & Display)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+M` | 切换静音 | ✅ 完全一致 |
| `Ctrl+-` | 缩小 | ✅ 完全一致 |
| `Ctrl++` | 放大 | ✅ 完全一致 |
| `Ctrl+=` | 放大（备用） | ✅ 完全一致 |
| `Ctrl+0` | 重置缩放 | ✅ 完全一致 |
| `Ctrl+Shift+S` | 截图 | ✅ 完全一致 |

#### 开发者工具 (Developer Tools)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+Shift+I` | 开发者工具 | ✅ 完全一致 |
| `Ctrl+Shift+J` | 浏览器控制台 | ✅ 完全一致 |
| `Ctrl+Shift+K` | Web 控制台 | ✅ 完全一致 |
| `Ctrl+Shift+M` | 响应式设计模式 | ✅ 完全一致 |
| `F12` | 开发者工具 | ✅ 完全一致 |

#### 其他功能 (Other Features)
| 快捷键 | 功能 | Zen Browser 兼容 |
|--------|------|------------------|
| `Ctrl+Shift+Y` | 打开下载 | ✅ 完全一致 |
| `Ctrl+O` | 打开文件 | ✅ 完全一致 |
| `F11` | 全屏模式 | ✅ 完全一致 |
| `Escape` | 停止加载 | ✅ 完全一致 |
| `Ctrl+B` | 显示书签 | ✅ 完全一致 |
| `Ctrl+Shift+C` | 复制当前 URL | ✅ 完全一致 |
| `Ctrl+Shift+Delete` | 清除浏览数据 | ✅ 完全一致 |

#### 额外功能（Vim 风格增强）
| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `J` | 下一个标签 | vim 风格，与 Ctrl+Tab 互补 |
| `K` | 上一个标签 | vim 风格，与 Ctrl+Shift+Tab 互补 |
| `H` | 后退 | vim 风格，与 Alt+← 互补 |
| `L` | 前进 | vim 风格，与 Alt+→ 互补 |
| `d` | 关闭标签 | vim 风格，与 Ctrl+W 互补 |
| `u` | 撤销关闭 | vim 风格，与 Ctrl+Shift+T 互补 |
| `r` | 刷新页面 | vim 风格，与 Ctrl+R 互补 |
| `o` | 快速打开 | vim 风格，与 Ctrl+L 互补 |
| `O` | 新标签打开 | vim 风格，与 Ctrl+T 互补 |
| `gg` | 滚动到顶部 | vim 风格 |
| `G` | 滚动到底部 | vim 风格 |
| `yy` | 复制 URL | vim 风格 |
| `yt` | 复制标题 | vim 风格 |
| `gi` | 跳转到输入框 | 智能导航 |
| `gf` | mpv 播放链接 | 媒体增强 |

#### Zen Browser 特色功能映射
| Zen 功能 | Qutebrowser 映射 | 兼容性 |
|----------|------------------|--------|
| **Split View** | 🚫 暂不支持 | Zen 独有功能 |
| **Workspaces** | 🚫 暂不支持 | Zen 独有功能 |
| **Compact Mode** | 📋 使用 minimal UI | 部分兼容 |
| **AI Chatbot** | 🚫 暂不支持 | Zen 独有功能 |
| **Firefox Sidebar** | 📋 使用插件系统 | 部分兼容 |
| **Floating Toolbar** | 📋 使用状态栏配置 | 部分兼容 |

> **注意**：Zen Browser 的 Split View、Workspaces、AI Sidebar 等高级功能在 Qutebrowser 中暂无直接对应。
> 建议对于这些功能密集的工作流，可以考虑使用 tmux 分屏 + 多个 Qutebrowser 实例来模拟。

### 🔍 搜索引擎（精简高效）

| 关键字 | 搜索引擎 | 用途 |
|--------|----------|------|
| 默认 | Google | 通用搜索 |
| `g` | Google | 显式 Google 搜索 |
| `d` | DuckDuckGo | 隐私搜索 |
| `gh` | GitHub | 代码搜索 |
| `w` | Wikipedia (中文) | 知识搜索 |
| `y` | YouTube | 视频搜索 |
| `n` | Nix Packages | 包搜索 |

### 📦 附加工具

配置自动安装：
- `mpv` - 视频播放器，集成链接播放（`gf` 快捷键）

### 🚀 配置选项

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

- **Zen Browser 快捷键映射**：查看 [ZEN_MAPPING.md](./ZEN_MAPPING.md) 获取完整的快捷键对照表
- **优化说明**：查看 [OPTIMIZATION.md](./OPTIMIZATION.md) 了解配置优化详情
- Qutebrowser 官方文档：https://qutebrowser.org/doc/
- Home Manager 手册：https://nix-community.github.io/home-manager/
- Zen Browser 官方文档：https://docs.zen-browser.app/
