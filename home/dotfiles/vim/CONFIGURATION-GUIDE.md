# Vim Home Manager 配置说明

基于 [mynixos.com](https://mynixos.com/home-manager/options/programs.vim) 的搜索结果优化的 Vim 配置。

## 核心 Home Manager 配置选项

### 1. programs.vim.enable
- **类型**: boolean
- **默认值**: false
- **说明**: 启用 Vim 程序配置

### 2. programs.vim.defaultEditor
- **类型**: boolean
- **默认值**: false
- **说明**: 是否将 vim 设置为默认编辑器（设置 EDITOR 环境变量）
- **当前设置**: false - 避免与其他编辑器冲突

### 3. programs.vim.packageConfigurable
- **类型**: package
- **默认值**: pkgs.vim
- **说明**: 使用的 vim 包版本
- **当前设置**: pkgs.vim-full - 功能完整版本，包含更多编译选项

### 4. programs.vim.settings
**基于 mynixos.com 文档的所有可用设置选项：**

#### 基础编辑设置
```nix
number = true;              # 显示行号
relativenumber = false;     # 相对行号 (设为 false 简化界面)
expandtab = true;           # 使用空格替代 tab
tabstop = 2;               # tab 宽度
shiftwidth = 2;            # 自动缩进宽度
```

#### 搜索设置
```nix
ignorecase = true;         # 搜索忽略大小写
smartcase = true;          # 包含大写时区分大小写
```

#### 备份和撤销
```nix
undofile = true;           # 启用持久化撤销
undodir = [ "~/.vim/undo" ];     # 撤销文件目录
backupdir = [ "~/.vim/backup" ]; # 备份文件目录
directory = [ "~/.vim/swp" ];    # 交换文件目录
```

#### 界面设置
```nix
background = "dark";       # 暗色主题背景
hidden = true;             # 允许切换未保存的缓冲区
history = 1000;            # 命令历史数量
```

#### 鼠标设置
```nix
mouse = "";                # 禁用鼠标 (可设为 "a" 启用)
mousehide = true;          # 输入时隐藏鼠标
mousefocus = false;        # 关闭鼠标焦点跟随
mousemodel = "extend";     # 鼠标模型
```

#### 其他设置
```nix
modeline = false;          # 关闭 modeline (安全考虑)
copyindent = true;         # 复制现有缩进格式
```

### 5. programs.vim.plugins
**基于 mynixos.com/packages/vimPlugins 的常用插件选择：**

#### 核心插件
- `vim-sensible` - Vim 合理默认设置

#### 编辑增强
- `auto-pairs` - 自动配对括号
- `vim-surround` - 包围字符操作
- `vim-commentary` - 快速注释

#### 文件管理
- `nerdtree` - 文件树浏览器
- `fzf-vim` - 模糊搜索

#### Git 集成
- `vim-fugitive` - Git 操作
- `vim-gitgutter` - Git diff 显示

#### 语法支持
- `vim-polyglot` - 多语言语法包
- `ale` - 异步语法检查
- `vim-nix` - Nix 语法支持

#### 外观主题
- `vim-airline` - 状态栏
- `onedark-vim` - OneDark 主题
- `gruvbox` - Gruvbox 主题

#### 实用工具
- `vim-easymotion` - 快速跳转
- `undotree` - 撤销树可视化

### 6. programs.vim.extraConfig
**自定义 vimrc 配置，包含：**

#### 基础设置
- 编码设置 (UTF-8)
- 界面增强
- 主题配置

#### 插件配置
- NERDTree: 文件树配置
- FZF: 搜索快捷键
- Airline: 状态栏配置
- ALE: 语法检查和自动修复
- GitGutter: Git 状态显示

#### 键位映射 (象征性配置，避免复杂)
- `<Space>` 作为 leader 键
- `<Esc><Esc>` 清除搜索高亮
- `<C-s>` 快速保存
- `<C-hjkl>` 窗口导航
- `<C-n>` 切换文件树
- `<C-p>` 文件搜索
- `<F5>` 撤销树

#### 文件类型配置
- Python: 4 空格缩进
- Go: 4 空格缩进，tab 字符
- JavaScript/TypeScript: 2 空格缩进
- Nix: 2 空格缩进
- 其他语言的合理默认设置

#### 自动命令
- 自动创建目录
- 去除行尾空格
- 记住光标位置

## 依赖包配置

```nix
home.packages = [
  fzf         # 模糊搜索工具
  ripgrep     # 快速文本搜索
  nixpkgs-fmt # Nix 代码格式化
];
```

## 目录结构

自动创建必要的 vim 目录：
- `~/.vim/undo/` - 撤销文件
- `~/.vim/backup/` - 备份文件
- `~/.vim/swp/` - 交换文件

## 设计原则

1. **基于官方文档**: 所有配置选项都来自 mynixos.com 的官方文档
2. **常用功能优先**: 选择最常用和稳定的插件
3. **简单注释**: 每个配置项都有清晰的中文注释
4. **合理默认值**: 不常用功能设为默认值或关闭
5. **性能考虑**: 避免过多插件影响启动速度
6. **安全考虑**: 关闭 modeline 等潜在安全风险

## 使用建议

1. **渐进式使用**: 可以根据需要注释掉不需要的插件
2. **主题切换**: 在 extraConfig 中切换 colorscheme
3. **键位自定义**: 可以在 extraConfig 中添加个人键位映射
4. **语言支持**: 根据开发需要调整文件类型配置

这个配置提供了一个功能完整但不过度复杂的 Vim 环境，适合日常开发使用。
