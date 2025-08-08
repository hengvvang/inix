# theme.toml 主题配置文件

`theme.toml` 文件用于配置 Yazi 的颜色主题和样式。它控制界面的所有视觉元素，包括颜色、边框、图标等。

## 基本类型

### Color - 颜色类型

颜色可以是十六进制 RGB 值或预定义的颜色名称。

**十六进制格式**: `"#484D66"`

**预定义颜色**:
- `"reset"` - 重置颜色
- `"black"` - 黑色
- `"white"` - 白色
- `"red"` - 红色
- `"lightred"` - 亮红色
- `"green"` - 绿色
- `"lightgreen"` - 亮绿色
- `"yellow"` - 黄色
- `"lightyellow"` - 亮黄色
- `"blue"` - 蓝色
- `"lightblue"` - 亮蓝色
- `"magenta"` - 品红色
- `"lightmagenta"` - 亮品红色
- `"cyan"` - 青色
- `"lightcyan"` - 亮青色
- `"gray"` - 灰色
- `"darkgray"` - 深灰色

```toml
# 颜色示例
[mgr]
cwd = { fg = "#e4e4e4" }              # 十六进制颜色
hovered = { fg = "white", bg = "blue" } # 预定义颜色
```

### Style - 样式类型

样式对象包含前景色、背景色和文本修饰属性。

**格式**: `{ fg = "颜色", bg = "颜色", 修饰属性... }`

**属性**:
- `fg` (Color) - 前景色（文字颜色）
- `bg` (Color) - 背景色
- `bold` (Boolean) - 粗体
- `dim` (Boolean) - 暗淡（某些终端不支持）
- `italic` (Boolean) - 斜体
- `underline` (Boolean) - 下划线
- `blink` (Boolean) - 闪烁
- `blink_rapid` (Boolean) - 快速闪烁
- `reversed` (Boolean) - 反转前景和背景色
- `hidden` (Boolean) - 隐藏
- `crossed` (Boolean) - 删除线

```toml
# 样式示例
[mgr]
hovered = { fg = "black", bg = "yellow", bold = true }
find_keyword = { fg = "red", underline = true, italic = true }
marker_selected = { fg = "white", bg = "blue", reversed = true }
```

## [flavor] - 预制主题

使用预制主题包（flavors）而不是自定义主题。

### dark
**类型**: 字符串
**描述**: 深色模式使用的主题名称

```toml
[flavor]
dark = "dracula"          # 使用 dracula 深色主题
# dark = "gruvbox-dark"   # 使用 gruvbox 深色主题
# dark = "monokai"        # 使用 monokai 主题
```

### light
**类型**: 字符串
**描述**: 浅色模式使用的主题名称

```toml
[flavor]
light = "gruvbox-light"   # 使用 gruvbox 浅色主题
# light = "solarized-light" # 使用 solarized 浅色主题
```

### 同时配置深浅色模式
```toml
[flavor]
dark = "dracula"
light = "gruvbox-light"
```

## [mgr] - 文件管理器样式

### cwd
**类型**: Style
**描述**: 当前工作目录文本样式

```toml
[mgr]
cwd = { fg = "#83a598", bold = true }
# cwd = { fg = "cyan", italic = true }
```

### hovered
**类型**: Style
**描述**: 悬停文件的样式

```toml
[mgr]
hovered = { fg = "black", bg = "yellow" }
# hovered = { fg = "white", bg = "#3c3836", bold = true }
```

### preview_hovered
**类型**: Style
**描述**: 预览面板中悬停文件的样式

```toml
[mgr]
preview_hovered = { fg = "black", bg = "lightyellow" }
```

### find_keyword
**类型**: Style
**描述**: 查找关键词高亮样式

```toml
[mgr]
find_keyword = { fg = "yellow", bold = true, underline = true }
# find_keyword = { fg = "#fe8019", italic = true }
```

### find_position
**类型**: Style
**描述**: 查找位置信息样式（显示在文件名右侧）

```toml
[mgr]
find_position = { fg = "magenta", italic = true }
```

### 标记样式

#### marker_copied
**类型**: Style
**描述**: 已复制文件的标记样式

```toml
[mgr]
marker_copied = { fg = "green", bg = "green" }
```

#### marker_cut
**类型**: Style
**描述**: 已剪切文件的标记样式

```toml
[mgr]
marker_cut = { fg = "red", bg = "red" }
```

#### marker_marked
**类型**: Style
**描述**: 视觉模式中预选文件的标记样式

```toml
[mgr]
marker_marked = { fg = "lightcyan", bg = "lightcyan" }
```

#### marker_selected
**类型**: Style
**描述**: 已选中文件的标记样式

```toml
[mgr]
marker_selected = { fg = "lightyellow", bg = "lightyellow" }
```

### 计数样式

#### count_copied
**类型**: Style
**描述**: 已复制文件数量的样式

```toml
[mgr]
count_copied = { fg = "white", bg = "green", bold = true }
```

#### count_cut
**类型**: Style
**描述**: 已剪切文件数量的样式

```toml
[mgr]
count_cut = { fg = "white", bg = "red", bold = true }
```

#### count_selected
**类型**: Style
**描述**: 已选中文件数量的样式

```toml
[mgr]
count_selected = { fg = "white", bg = "blue", bold = true }
```

### 边框样式

#### border_symbol
**类型**: 字符串
**描述**: 边框符号

```toml
[mgr]
border_symbol = "│"        # 细竖线
# border_symbol = "┃"      # 粗竖线
# border_symbol = "|"      # ASCII 竖线
# border_symbol = " "      # 无边框（空格）
```

#### border_style
**类型**: Style
**描述**: 边框样式

```toml
[mgr]
border_style = { fg = "gray" }
# border_style = { fg = "#665c54", dim = true }
```

### syntect_theme
**类型**: 字符串
**描述**: 代码预览高亮主题路径（`.tmTheme` 文件）

```toml
[mgr]
syntect_theme = "~/Downloads/Dracula.tmTheme"
# syntect_theme = "/path/to/your/theme.tmTheme"
```

**注意**: 使用 flavor 时此选项无效，因为 flavor 包含自己的 `tmtheme.xml` 文件。

## [tabs] - 标签页样式

### active
**类型**: Style
**描述**: 活动标签页样式

```toml
[tabs]
active = { fg = "black", bg = "white", bold = true }
```

### inactive
**类型**: Style
**描述**: 非活动标签页样式

```toml
[tabs]
inactive = { fg = "white", bg = "gray" }
```

### sep_inner
**类型**: { open: 字符串, close: 字符串 }
**描述**: 内分隔符

```toml
[tabs]
sep_inner = { open = "[", close = "]" }
# sep_inner = { open = " ", close = " " }  # 无分隔符
```

### sep_outer
**类型**: { open: 字符串, close: 字符串 }
**描述**: 外分隔符

```toml
[tabs]
sep_outer = { open = "", close = "" }
# sep_outer = { open = "<<", close = ">>" }
```

标签页显示效果示例：
```
outer.open + inner.open + tab_name + inner.close + ... + outer.close
[Tab1] [Tab2] [Tab3]
```

## [mode] - 模式指示器样式

### 普通模式

#### normal_main
**类型**: Style
**描述**: 普通模式主样式

```toml
[mode]
normal_main = { fg = "black", bg = "blue", bold = true }
```

#### normal_alt
**类型**: Style
**描述**: 普通模式备选样式

```toml
[mode]
normal_alt = { fg = "white", bg = "darkblue" }
```

### 选择模式

#### select_main
**类型**: Style
**描述**: 选择模式主样式

```toml
[mode]
select_main = { fg = "black", bg = "green", bold = true }
```

#### select_alt
**类型**: Style
**描述**: 选择模式备选样式

```toml
[mode]
select_alt = { fg = "white", bg = "darkgreen" }
```

### 取消设置模式

#### unset_main
**类型**: Style
**描述**: 取消设置模式主样式

```toml
[mode]
unset_main = { fg = "black", bg = "red", bold = true }
```

#### unset_alt
**类型**: Style
**描述**: 取消设置模式备选样式

```toml
[mode]
unset_alt = { fg = "white", bg = "darkred" }
```

## [status] - 状态栏样式

### overall
**类型**: Style
**描述**: 整体状态栏样式

```toml
[status]
overall = { bg = "gray" }
```

### 分隔符

#### sep_left
**类型**: { open: 字符串, close: 字符串 }
**描述**: 左分隔符

```toml
[status]
sep_left = { open = "", close = "]" }
```

#### sep_right
**类型**: { open: 字符串, close: 字符串 }
**描述**: 右分隔符

```toml
[status]
sep_right = { open = "[", close = "" }
```

### 权限样式

#### perm_type
**类型**: Style
**描述**: 文件类型符号样式（d=目录，-=文件，l=符号链接等）

```toml
[status]
perm_type = { fg = "cyan", bold = true }
```

#### perm_read
**类型**: Style
**描述**: 读权限符号样式（r）

```toml
[status]
perm_read = { fg = "green" }
```

#### perm_write
**类型**: Style
**描述**: 写权限符号样式（w）

```toml
[status]
perm_write = { fg = "yellow" }
```

#### perm_exec
**类型**: Style
**描述**: 执行权限符号样式（x）

```toml
[status]
perm_exec = { fg = "red" }
```

#### perm_sep
**类型**: Style
**描述**: 权限分隔符样式（-）

```toml
[status]
perm_sep = { fg = "gray", dim = true }
```

### 进度条样式

#### progress_label
**类型**: Style
**描述**: 进度标签样式

```toml
[status]
progress_label = { fg = "white", bold = true }
```

#### progress_normal
**类型**: Style
**描述**: 正常状态进度条样式

```toml
[status]
progress_normal = { fg = "blue", bg = "black" }
```

#### progress_error
**类型**: Style
**描述**: 错误状态进度条样式

```toml
[status]
progress_error = { fg = "red", bg = "black", bold = true }
```

## [which] - 快捷键提示样式

### cols
**类型**: 整数 (1, 2, 或 3)
**描述**: 显示列数

```toml
[which]
cols = 3              # 3 列显示
# cols = 2            # 2 列显示
# cols = 1            # 1 列显示
```

### mask
**类型**: Style
**描述**: 遮罩样式

```toml
[which]
mask = { bg = "black" }
```

### cand
**类型**: Style
**描述**: 候选按键样式

```toml
[which]
cand = { fg = "yellow", bold = true }
```

### rest
**类型**: Style
**描述**: 其余按键样式

```toml
[which]
rest = { fg = "gray" }
```

### desc
**类型**: Style
**描述**: 描述文本样式

```toml
[which]
desc = { fg = "white" }
```

### separator
**类型**: 字符串
**描述**: 分隔符

```toml
[which]
separator = " -> "
# separator = " : "
# separator = " | "
```

### separator_style
**类型**: Style
**描述**: 分隔符样式

```toml
[which]
separator_style = { fg = "gray", dim = true }
```

## [confirm] - 确认对话框样式

### border
**类型**: Style
**描述**: 边框样式

```toml
[confirm]
border = { fg = "blue" }
```

### title
**类型**: Style
**描述**: 标题样式

```toml
[confirm]
title = { fg = "white", bold = true }
```

### content
**类型**: Style
**描述**: 内容样式

```toml
[confirm]
content = { fg = "white" }
```

### list
**类型**: Style
**描述**: 列表样式

```toml
[confirm]
list = { fg = "lightgray" }
```

### 按钮样式

#### btn_yes
**类型**: Style
**描述**: 确认按钮样式

```toml
[confirm]
btn_yes = { fg = "black", bg = "green", bold = true }
```

#### btn_no
**类型**: Style
**描述**: 取消按钮样式

```toml
[confirm]
btn_no = { fg = "black", bg = "red", bold = true }
```

#### btn_labels
**类型**: [字符串, 字符串]
**描述**: 按钮标签文本 [确认按钮, 取消按钮]

```toml
[confirm]
btn_labels = ["Yes", "No"]
# btn_labels = ["确定", "取消"]
# btn_labels = ["✓", "✗"]
```

## [spot] - 文件信息查看器样式

### border
**类型**: Style
**描述**: 边框样式

```toml
[spot]
border = { fg = "cyan" }
```

### title
**类型**: Style
**描述**: 标题样式

```toml
[spot]
title = { fg = "white", bold = true }
```

### tbl_col
**类型**: Style
**描述**: 表格选中列样式

```toml
[spot]
tbl_col = { bg = "darkgray" }
```

### tbl_cell
**类型**: Style
**描述**: 表格选中单元格样式

```toml
[spot]
tbl_cell = { fg = "yellow", bg = "darkgray", bold = true }
```

## [notify] - 通知样式

### title_info
**类型**: Style
**描述**: 信息通知标题样式

```toml
[notify]
title_info = { fg = "blue", bold = true }
```

### title_warn
**类型**: Style
**描述**: 警告通知标题样式

```toml
[notify]
title_warn = { fg = "yellow", bold = true }
```

### title_error
**类型**: Style
**描述**: 错误通知标题样式

```toml
[notify]
title_error = { fg = "red", bold = true }
```

## [pick] - 选择器样式

### border
**类型**: Style
**描述**: 边框样式

```toml
[pick]
border = { fg = "blue" }
```

### active
**类型**: Style
**描述**: 选中项样式

```toml
[pick]
active = { fg = "black", bg = "yellow" }
```

### inactive
**类型**: Style
**描述**: 未选中项样式

```toml
[pick]
inactive = { fg = "white" }
```

## [input] - 输入框样式

### border
**类型**: Style
**描述**: 边框样式

```toml
[input]
border = { fg = "blue" }
```

### title
**类型**: Style
**描述**: 标题样式

```toml
[input]
title = { fg = "white", bold = true }
```

### value
**类型**: Style
**描述**: 输入值样式

```toml
[input]
value = { fg = "white" }
```

### selected
**类型**: Style
**描述**: 选中文本样式

```toml
[input]
selected = { fg = "black", bg = "yellow" }
```

## [cmp] - 补全菜单样式

### border
**类型**: Style
**描述**: 边框样式

```toml
[cmp]
border = { fg = "blue" }
```

### active
**类型**: Style
**描述**: 选中项样式

```toml
[cmp]
active = { fg = "black", bg = "yellow" }
```

### inactive
**类型**: Style
**描述**: 未选中项样式

```toml
[cmp]
inactive = { fg = "white" }
```

### 图标

#### icon_file
**类型**: 字符串
**描述**: 文件图标

```toml
[cmp]
icon_file = "📄"
# icon_file = ""
```

#### icon_folder
**类型**: 字符串
**描述**: 文件夹图标

```toml
[cmp]
icon_folder = "📁"
# icon_folder = ""
```

#### icon_command
**类型**: 字符串
**描述**: 命令图标

```toml
[cmp]
icon_command = "⚡"
# icon_command = ""
```

## [tasks] - 任务管理器样式

### border
**类型**: Style
**描述**: 边框样式

```toml
[tasks]
border = { fg = "blue" }
```

### title
**类型**: Style
**描述**: 标题样式

```toml
[tasks]
title = { fg = "white", bold = true }
```

### hovered
**类型**: Style
**描述**: 悬停任务样式

```toml
[tasks]
hovered = { fg = "black", bg = "yellow" }
```

## [help] - 帮助菜单样式

### on
**类型**: Style
**描述**: 按键列样式

```toml
[help]
on = { fg = "yellow", bold = true }
```

### run
**类型**: Style
**描述**: 命令列样式

```toml
[help]
run = { fg = "cyan" }
```

### desc
**类型**: Style
**描述**: 描述列样式

```toml
[help]
desc = { fg = "white" }
```

### hovered
**类型**: Style
**描述**: 悬停项样式

```toml
[help]
hovered = { fg = "black", bg = "yellow" }
```

### footer
**类型**: Style
**描述**: 页脚样式

```toml
[help]
footer = { fg = "gray", italic = true }
```

### 图标

#### icon_info
**类型**: 字符串
**描述**: 信息图标

```toml
[help]
icon_info = "ℹ"
# icon_info = ""
```

#### icon_warn
**类型**: 字符串
**描述**: 警告图标

```toml
[help]
icon_warn = "⚠"
# icon_warn = ""
```

#### icon_error
**类型**: 字符串
**描述**: 错误图标

```toml
[help]
icon_error = "✗"
# icon_error = ""
```

## [filetype] - 文件类型样式

为特定文件类型设置样式，支持按名称和 MIME 类型匹配。

```toml
[filetype]
rules = [
    # 图片文件
    { mime = "image/*", fg = "yellow" },

    # 视频和音频文件
    { mime = "video/*", fg = "magenta" },
    { mime = "audio/*", fg = "magenta" },

    # 压缩文件
    { name = "*.zip", fg = "red" },
    { name = "*.tar.*", fg = "red" },
    { name = "*.rar", fg = "red" },

    # 文档文件
    { name = "*.pdf", fg = "cyan" },
    { name = "*.doc*", fg = "blue" },
    { name = "*.ppt*", fg = "orange" },
    { name = "*.xls*", fg = "green" },

    # 代码文件
    { name = "*.rs", fg = "#ce422b" },
    { name = "*.py", fg = "#3776ab" },
    { name = "*.js", fg = "#f7df1e" },
    { name = "*.ts", fg = "#3178c6" },
    { name = "*.html", fg = "#e34c26" },
    { name = "*.css", fg = "#1572b6" },
    { name = "*.go", fg = "#00add8" },
    { name = "*.java", fg = "#ed8b00" },
    { name = "*.cpp", fg = "#00599c" },
    { name = "*.c", fg = "#555555" },

    # 配置文件
    { name = "*.toml", fg = "purple" },
    { name = "*.yaml", fg = "purple" },
    { name = "*.yml", fg = "purple" },
    { name = "*.json", fg = "yellow" },
    { name = "*.xml", fg = "orange" },

    # 空文件
    { mime = "inode/empty", fg = "cyan" },

    # 孤立符号链接
    { name = "*", is = "orphan", fg = "red" },

    # 目录
    { name = "*/", fg = "blue" },
]
```

### 规则选项

- `name` - 文件名 glob 表达式（默认不区分大小写，以 `\s` 开头区分大小写）
- `mime` - MIME 类型 glob 表达式（默认不区分大小写）
- `is` - 文件类型限制：
  - `"block"` - 块设备
  - `"char"` - 字符设备
  - `"exec"` - 可执行文件
  - `"fifo"` - FIFO
  - `"link"` - 符号链接
  - `"orphan"` - 孤立符号链接
  - `"sock"` - 套接字
  - `"sticky"` - 设置粘滞位的文件

支持完整的 [Style 属性](#style---样式类型)。

特殊规则：
- `{ name = "*" }` - 匹配所有文件
- `{ name = "*/" }` - 匹配所有目录

## [icon] - 图标配置

Yazi 内置支持 [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) 图标集。

### 图标规则优先级

1. `globs` - glob 表达式（如 `**/Downloads/*.zip`）
2. `dirs` - 目录名（如 `Desktop`）
3. `files` - 文件名（如 `.bashrc`）
4. `exts` - 扩展名（如 `mp3`）
5. `conds` - 条件表达式（如 `!dir`）

### 添加自定义图标

使用 `prepend_*` 和 `append_*` 在默认图标集基础上添加：

```toml
[icon]
prepend_dirs = [
    { name = "desktop", text = "", fg = "#563d7c" },
    { name = "downloads", text = "", fg = "#44cc11" },
]

prepend_exts = [
    { name = "mp3", text = "", fg = "#00afff" },
    { name = "flac", text = "", fg = "#00afff" },
]
```

### 完全自定义图标

```toml
[icon]
dirs = [
    { name = "desktop", text = "", fg = "#563d7c" },
    # ...更多目录图标
]

exts = [
    { name = "mp3", text = "", fg = "#00afff" },
    # ...更多扩展名图标
]
```

### Glob 规则

用于复杂匹配：

```toml
[icon]
prepend_globs = [
    { name = "**/node_modules/**", text = "", fg = "#8cc84b" },
    { name = "**/.git/**", text = "", fg = "#f14e32" },
    { name = "**/Downloads/*.zip", text = "", fg = "#ff6b6b" },
]
```

### 条件图标

基于文件元数据的图标：

```toml
[icon]
prepend_conds = [
    # 隐藏目录
    { if = "hidden & dir", text = "👻" },
    # 可执行文件
    { if = "exec", text = "⚡", fg = "green" },
    # 符号链接
    { if = "link", text = "🔗", fg = "cyan" },
    # 孤立链接
    { if = "orphan", text = "💀", fg = "red" },
    # 大文件（需要插件支持）
    { if = "size > 100MB", text = "📦", fg = "red" },
]
```

#### 条件因子

- `dir` - 是目录
- `hidden` - 是隐藏文件
- `link` - 是符号链接
- `orphan` - 是孤立链接
- `dummy` - 元数据加载失败
- `block` - 是块设备
- `char` - 是字符设备
- `fifo` - 是 FIFO
- `sock` - 是套接字
- `exec` - 是可执行文件
- `sticky` - 设置了粘滞位

条件支持逻辑运算符：
- `|` - 或
- `&` - 与
- `!` - 非
- `()` - 分组

```toml
[icon]
prepend_conds = [
    { if = "hidden & dir", text = "📁", fg = "gray" },
    { if = "exec & !dir", text = "⚡", fg = "green" },
    { if = "(link | orphan) & !dir", text = "🔗", fg = "cyan" },
]
```

### 图标规则属性

每个图标规则包含：

- `name` (globs, dirs, files, exts) 或 `if` (conds) - 匹配规则
- `text` - 图标文本
- `fg` - 图标颜色（Color）
- 其他 Style 属性（如 `bold`、`italic` 等）

```toml
[icon]
prepend_exts = [
    { name = "rs", text = "", fg = "#ce422b", bold = true },
    { name = "py", text = "", fg = "#3776ab", italic = true },
]
```

## 完整主题配置示例

### 深色主题示例

```toml
# theme.toml - 深色主题示例

[mgr]
cwd = { fg = "#83a598", bold = true }
hovered = { fg = "#282828", bg = "#fabd2f" }
preview_hovered = { fg = "#282828", bg = "#fabd2f" }
find_keyword = { fg = "#fe8019", bold = true, underline = true }
find_position = { fg = "#d3869b", italic = true }

marker_copied = { fg = "#b8bb26", bg = "#b8bb26" }
marker_cut = { fg = "#fb4934", bg = "#fb4934" }
marker_marked = { fg = "#8ec07c", bg = "#8ec07c" }
marker_selected = { fg = "#fabd2f", bg = "#fabd2f" }

count_copied = { fg = "#282828", bg = "#b8bb26", bold = true }
count_cut = { fg = "#282828", bg = "#fb4934", bold = true }
count_selected = { fg = "#282828", bg = "#fabd2f", bold = true }

border_symbol = "│"
border_style = { fg = "#665c54" }

[tabs]
active = { fg = "#282828", bg = "#fabd2f", bold = true }
inactive = { fg = "#a89984", bg = "#3c3836" }
sep_inner = { open = " ", close = " " }
sep_outer = { open = "", close = "" }

[mode]
normal_main = { fg = "#282828", bg = "#83a598", bold = true }
normal_alt = { fg = "#ebdbb2", bg = "#458588" }
select_main = { fg = "#282828", bg = "#b8bb26", bold = true }
select_alt = { fg = "#ebdbb2", bg = "#98971a" }
unset_main = { fg = "#282828", bg = "#fb4934", bold = true }
unset_alt = { fg = "#ebdbb2", bg = "#cc241d" }

[status]
overall = { bg = "#3c3836" }
sep_left = { open = "", close = " " }
sep_right = { open = " ", close = "" }

perm_type = { fg = "#83a598", bold = true }
perm_read = { fg = "#b8bb26" }
perm_write = { fg = "#fabd2f" }
perm_exec = { fg = "#fe8019" }
perm_sep = { fg = "#928374" }

progress_label = { fg = "#ebdbb2", bold = true }
progress_normal = { fg = "#83a598", bg = "#3c3836" }
progress_error = { fg = "#fb4934", bg = "#3c3836", bold = true }

[which]
cols = 3
mask = { bg = "#282828" }
cand = { fg = "#fabd2f", bold = true }
rest = { fg = "#928374" }
desc = { fg = "#ebdbb2" }
separator = " → "
separator_style = { fg = "#665c54" }

[confirm]
border = { fg = "#83a598" }
title = { fg = "#ebdbb2", bold = true }
content = { fg = "#ebdbb2" }
list = { fg = "#a89984" }
btn_yes = { fg = "#282828", bg = "#b8bb26", bold = true }
btn_no = { fg = "#282828", bg = "#fb4934", bold = true }
btn_labels = ["确定", "取消"]

[input]
border = { fg = "#83a598" }
title = { fg = "#ebdbb2", bold = true }
value = { fg = "#ebdbb2" }
selected = { fg = "#282828", bg = "#fabd2f" }

[filetype]
rules = [
    { mime = "image/*", fg = "#fabd2f" },
    { mime = "video/*", fg = "#d3869b" },
    { mime = "audio/*", fg = "#d3869b" },
    { name = "*.zip", fg = "#fb4934" },
    { name = "*.tar.*", fg = "#fb4934" },
    { name = "*.pdf", fg = "#8ec07c" },
    { name = "*.rs", fg = "#ce422b" },
    { name = "*.py", fg = "#3776ab" },
    { name = "*.js", fg = "#f7df1e" },
    { name = "*.md", fg = "#83a598" },
    { name = "*", is = "orphan", fg = "#fb4934" },
    { name = "*/", fg = "#83a598" },
]
```

### 浅色主题示例

```toml
# theme.toml - 浅色主题示例

[mgr]
cwd = { fg = "#458588", bold = true }
hovered = { fg = "#fbf1c7", bg = "#d79921" }
preview_hovered = { fg = "#fbf1c7", bg = "#d79921" }
find_keyword = { fg = "#d65d0e", bold = true, underline = true }
find_position = { fg = "#8f3f71", italic = true }

marker_copied = { fg = "#79740e", bg = "#79740e" }
marker_cut = { fg = "#9d0006", bg = "#9d0006" }
marker_marked = { fg = "#427b58", bg = "#427b58" }
marker_selected = { fg = "#b57614", bg = "#b57614" }

border_symbol = "│"
border_style = { fg = "#bdae93" }

[tabs]
active = { fg = "#fbf1c7", bg = "#d79921", bold = true }
inactive = { fg = "#665c54", bg = "#ebdbb2" }

[status]
overall = { bg = "#ebdbb2" }
perm_type = { fg = "#458588", bold = true }
perm_read = { fg = "#79740e" }
perm_write = { fg = "#b57614" }
perm_exec = { fg = "#d65d0e" }
perm_sep = { fg = "#928374" }

[filetype]
rules = [
    { mime = "image/*", fg = "#b57614" },
    { mime = "video/*", fg = "#8f3f71" },
    { mime = "audio/*", fg = "#8f3f71" },
    { name = "*", is = "orphan", fg = "#9d0006" },
    { name = "*/", fg = "#458588" },
]
```

### 使用预制主题

如果你不想自定义主题，可以使用预制主题：

```toml
# theme.toml - 使用预制主题

[flavor]
dark = "gruvbox-dark"
light = "gruvbox-light"

# 可以在主题基础上覆盖特定样式
[mgr]
hovered = { fg = "black", bg = "red", bold = true }
```

常见的预制主题：
- `gruvbox-dark` / `gruvbox-light`
- `dracula`
- `nord`
- `solarized-dark` / `solarized-light`
- `monokai`
- `onedark`
- `catppuccin-mocha` / `catppuccin-latte`

通过这些配置选项，你可以完全自定义 Yazi 的外观和感觉，创造出符合你个人喜好和工作环境的主题。
