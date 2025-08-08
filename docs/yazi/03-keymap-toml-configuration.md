# keymap.toml 键盘快捷键配置

`keymap.toml` 文件用于自定义 Yazi 的键盘快捷键。Yazi 支持 8 个不同的层级，每个层级都有自己的键盘映射。

## 配置结构

### 层级（Layers）

Yazi 有 8 个键盘映射层级：

1. **[mgr]** - 文件列表管理器
2. **[tasks]** - 任务管理器
3. **[spot]** - 文件信息查看器
4. **[pick]** - 选择组件（如"打开方式"）
5. **[input]** - 输入组件（如创建、重命名等）
6. **[confirm]** - 确认对话框
7. **[cmp]** - 补全组件（如 cd 路径补全）
8. **[help]** - 帮助菜单

### 键盘映射类型

每个层级支持三种键盘映射类型：

- `prepend_keymap` - 在默认键盘映射之前插入，优先级最高
- `append_keymap` - 在默认键盘映射之后插入，优先级最低
- `keymap` - 完全覆盖默认键盘映射

```toml
[mgr]
# 在默认映射前添加
prepend_keymap = [
    { on = "<C-a>", run = "my-cmd1", desc = "My command 1" },
]

# 在默认映射后添加
append_keymap = [
    { on = ["g", "d"], run = "cd ~/Downloads", desc = "Go to Downloads" },
]

# 完全覆盖默认映射（慎用）
keymap = [
    { on = "<C-a>", run = "my-cmd1" },
    { on = ["g", "b"], run = "my-cmd2" },
]
```

### 键盘映射格式

有两种配置格式：

**数组格式**:
```toml
[mgr]
prepend_keymap = [
    { on = "<C-a>", run = "my-cmd1", desc = "Single command with Ctrl + a" },
    { on = ["g", "b"], run = "my-cmd2", desc = "Single command with g => b" },
    { on = "c", run = ["cmd1", "cmd2"], desc = "Multiple commands with c" },
]
```

**表格格式**:
```toml
[[mgr.prepend_keymap]]
on = "<C-a>"
run = "my-cmd1"
desc = "Single command with Ctrl + a"

[[mgr.prepend_keymap]]
on = ["g", "b"]
run = "my-cmd2"
desc = "Single command with g => b"

[[mgr.prepend_keymap]]
on = "c"
run = ["cmd1", "cmd2"]
desc = "Multiple commands with c"
```

**注意**: 不能在同一个文件中混合使用两种格式。

## 按键表示法

### 基本按键

| 按键          | 表示法      |
| ------------- | ----------- |
| a-z           | 小写字母    |
| A-Z           | 大写字母    |
| 0-9           | 数字        |
| `<Space>`     | 空格键      |
| `<Backspace>` | 退格键      |
| `<Enter>`     | 回车键      |
| `<Tab>`       | Tab 键      |
| `<BackTab>`   | Shift + Tab |
| `<Delete>`    | Delete 键   |
| `<Insert>`    | Insert 键   |
| `<Esc>`       | Escape 键   |

### 方向键

| 按键         | 表示法      |
| ------------ | ----------- |
| `<Left>`     | 左箭头      |
| `<Right>`    | 右箭头      |
| `<Up>`       | 上箭头      |
| `<Down>`     | 下箭头      |
| `<Home>`     | Home 键     |
| `<End>`      | End 键      |
| `<PageUp>`   | PageUp 键   |
| `<PageDown>` | PageDown 键 |

### 功能键

| 按键             | 表示法 |
| ---------------- | ------ |
| `<F1>` - `<F19>` | 功能键 |

### 修饰键

| 修饰键    | 表示法                   |
| --------- | ------------------------ |
| `<S-...>` | Shift 键                 |
| `<C-...>` | Ctrl 键                  |
| `<A-...>` | Alt/Meta 键              |
| `<D-...>` | Command/Windows/Super 键 |

**示例**:
- `<C-a>` - Ctrl + a
- `<C-S-b>` 或 `<C-B>` - Ctrl + Shift + b
- `<A-Enter>` - Alt + Enter

**注意事项**:
1. `<D-...>` 需要终端支持 CSI u 协议
2. macOS 没有 Alt 键，某些终端需要将 Option 键映射为 Alt
3. 传统终端协议将 `<Tab>` 和 `<C-i>`、`<Enter>` 和 `<C-m>` 等视为相同按键

## [mgr] 文件管理器层级

### escape - 取消操作

取消查找、退出视觉模式、清除选择、取消过滤器或取消搜索。

**参数**:
- `--all` - 执行所有下列操作
- `--find` - 取消查找
- `--visual` - 退出视觉模式
- `--select` - 清除选择
- `--filter` - 取消过滤器
- `--search` - 取消搜索

```toml
[[mgr.prepend_keymap]]
on = "<Esc>"
run = "escape"
desc = "Cancel operation"

[[mgr.prepend_keymap]]
on = "q"
run = "escape --select"
desc = "Clear selection"
```

### quit - 退出程序

退出 Yazi。

**参数**:
- `--no-cwd-file` - 不输出当前目录到 --cwd-file 指定的文件

```toml
[[mgr.prepend_keymap]]
on = "<C-c>"
run = "quit"
desc = "Quit Yazi"
```

### close - 关闭标签页

关闭当前标签页，如果是最后一个标签页则退出程序。

**参数**:
- `--no-cwd-file` - 退出时不输出当前目录

```toml
[[mgr.prepend_keymap]]
on = "q"
run = "close"
desc = "Close tab or quit"
```

### suspend - 暂停程序

暂停 Yazi 并返回到父 shell。使用 `fg` 命令恢复。

```toml
[[mgr.prepend_keymap]]
on = "<C-z>"
run = "suspend"
desc = "Suspend Yazi"
```

### arrow - 移动光标

移动文件列表中的光标。

**参数**:
- `[steps]` - 移动步数，可以是：
  - `n` - 向上（负数）或向下（正数）移动 n 行
  - `n%` - 向上或向下移动屏幕高度的 n%
  - `"top"` - 移动到顶部
  - `"bot"` - 移动到底部
  - `"prev"` - 移动到上一个文件（支持环绕）
  - `"next"` - 移动到下一个文件（支持环绕）

```toml
[[mgr.prepend_keymap]]
on = "j"
run = "arrow 1"
desc = "Move down"

[[mgr.prepend_keymap]]
on = "k"
run = "arrow -1"
desc = "Move up"

[[mgr.prepend_keymap]]
on = "g"
run = "arrow top"
desc = "Go to top"

[[mgr.prepend_keymap]]
on = "G"
run = "arrow bot"
desc = "Go to bottom"

[[mgr.prepend_keymap]]
on = "<C-d>"
run = "arrow 50%"
desc = "Move down half screen"
```

### leave - 返回上级目录

返回到悬停文件的父目录，或当前工作目录的父目录。

```toml
[[mgr.prepend_keymap]]
on = "h"
run = "leave"
desc = "Go back"
```

### enter - 进入目录

进入子目录。

```toml
[[mgr.prepend_keymap]]
on = "l"
run = "enter"
desc = "Enter directory"

[[mgr.prepend_keymap]]
on = "<Enter>"
run = "enter"
desc = "Enter directory"
```

### back - 后退

回到上一个访问的目录。

```toml
[[mgr.prepend_keymap]]
on = "<C-o>"
run = "back"
desc = "Go back in history"
```

### forward - 前进

前进到下一个目录。

```toml
[[mgr.prepend_keymap]]
on = "<C-i>"
run = "forward"
desc = "Go forward in history"
```

### seek - 滚动预览

滚动预览面板的内容。

**参数**:
- `[n]` - 滚动行数（负数向上，正数向下）

```toml
[[mgr.prepend_keymap]]
on = "J"
run = "seek 5"
desc = "Seek down in preview"

[[mgr.prepend_keymap]]
on = "K"
run = "seek -5"
desc = "Seek up in preview"
```

### spot - 文件信息

显示文件详细信息。

```toml
[[mgr.prepend_keymap]]
on = "<Tab>"
run = "spot"
desc = "Show file info"
```

### cd - 切换目录

改变当前目录。

**参数**:
- `[path]` - 目标路径
- `--interactive` - 使用交互式输入

```toml
[[mgr.prepend_keymap]]
on = ["g", "h"]
run = "cd ~"
desc = "Go to home"

[[mgr.prepend_keymap]]
on = ["g", "d"]
run = "cd ~/Downloads"
desc = "Go to Downloads"

[[mgr.prepend_keymap]]
on = ":"
run = "cd --interactive"
desc = "Change directory interactively"

# Windows 驱动器切换
[[mgr.prepend_keymap]]
on = ["g", "c"]
run = "cd C:"
desc = "Switch to C drive"
```

### reveal - 跳转到文件

跳转到指定文件。如果文件不在当前目录，会切换到文件所在目录。

**参数**:
- `[path]` - 文件路径

```toml
[[mgr.prepend_keymap]]
on = ["g", "f"]
run = "reveal ~/file.txt"
desc = "Reveal file"
```

### toggle - 切换选择状态

切换悬停文件的选择状态。

**参数**:
- 默认 - 反转选择状态
- `--state=on` - 选择文件
- `--state=off` - 取消选择文件

```toml
[[mgr.prepend_keymap]]
on = "<Space>"
run = "toggle"
desc = "Toggle selection"

[[mgr.prepend_keymap]]
on = "v"
run = "toggle --state=on"
desc = "Select file"

[[mgr.prepend_keymap]]
on = "V"
run = "toggle --state=off"
desc = "Deselect file"
```

### toggle_all - 切换所有文件选择状态

切换当前目录中所有文件的选择状态。

**参数**:
- 默认 - 反转所有选择
- `--state=on` - 选择所有文件
- `--state=off` - 取消选择所有文件（仅当前目录）

```toml
[[mgr.prepend_keymap]]
on = "<C-a>"
run = "toggle_all"
desc = "Toggle all"

[[mgr.prepend_keymap]]
on = "A"
run = "toggle_all --state=on"
desc = "Select all"
```

### visual_mode - 进入视觉模式

进入视觉模式进行批量选择。

**参数**:
- 默认 - 选择模式
- `--unset` - 取消设置模式

```toml
[[mgr.prepend_keymap]]
on = "v"
run = "visual_mode"
desc = "Enter visual mode"

[[mgr.prepend_keymap]]
on = "V"
run = "visual_mode --unset"
desc = "Enter visual unset mode"
```

### open - 打开文件

使用 [open] 规则打开选中的文件。

**参数**:
- `--interactive` - 使用交互式界面选择打开方式
- `--hovered` - 总是打开悬停的文件（忽略选择状态）

```toml
[[mgr.prepend_keymap]]
on = "<Enter>"
run = "open"
desc = "Open file"

[[mgr.prepend_keymap]]
on = "o"
run = "open --interactive"
desc = "Open with..."

[[mgr.prepend_keymap]]
on = "O"
run = "open --hovered"
desc = "Open hovered file"
```

### yank - 复制/剪切

复制或剪切选中的文件。

**参数**:
- 默认 - 复制模式
- `--cut` - 剪切模式

```toml
[[mgr.prepend_keymap]]
on = "y"
run = "yank"
desc = "Copy files"

[[mgr.prepend_keymap]]
on = "x"
run = "yank --cut"
desc = "Cut files"
```

### unyank - 取消复制/剪切

取消文件的复制/剪切状态。

```toml
[[mgr.prepend_keymap]]
on = "u"
run = "unyank"
desc = "Cancel yank"
```

### paste - 粘贴

粘贴复制/剪切的文件。

**参数**:
- `--force` - 如果目标文件存在则覆盖
- `--follow` - 复制符号链接指向的文件而不是链接本身

```toml
[[mgr.prepend_keymap]]
on = "p"
run = "paste"
desc = "Paste files"

[[mgr.prepend_keymap]]
on = "P"
run = "paste --force"
desc = "Paste and overwrite"
```

### link - 创建符号链接

为复制的文件创建符号链接。

**参数**:
- `--relative` - 使用相对路径
- `--force` - 如果目标文件存在则覆盖

```toml
[[mgr.prepend_keymap]]
on = "L"
run = "link"
desc = "Create symbolic link"

[[mgr.prepend_keymap]]
on = "l"
run = "link --relative"
desc = "Create relative symbolic link"
```

### hardlink - 创建硬链接

为复制的文件创建硬链接。

**参数**:
- `--force` - 如果目标文件存在则覆盖
- `--follow` - 硬链接符号链接指向的文件

```toml
[[mgr.prepend_keymap]]
on = "H"
run = "hardlink"
desc = "Create hard link"
```

### remove - 删除文件

将文件移动到回收站或永久删除。

**参数**:
- `--force` - 不显示确认对话框
- `--permanently` - 永久删除文件
- `--hovered` - 总是删除悬停的文件

```toml
[[mgr.prepend_keymap]]
on = "d"
run = "remove"
desc = "Move to trash"

[[mgr.prepend_keymap]]
on = "D"
run = "remove --permanently"
desc = "Delete permanently"

[[mgr.prepend_keymap]]
on = "<Delete>"
run = "remove --force"
desc = "Delete without confirmation"
```

### create - 创建文件/目录

创建文件或目录。以 `/`（Unix）或 `\`（Windows）结尾表示目录。

**参数**:
- `--dir` - 总是创建目录
- `--force` - 如果目标存在则直接覆盖

```toml
[[mgr.prepend_keymap]]
on = "a"
run = "create"
desc = "Create file or directory"

[[mgr.prepend_keymap]]
on = "A"
run = "create --dir"
desc = "Create directory"
```

### rename - 重命名

重命名文件或目录。选中多个文件时进行批量重命名。

**参数**:
- `--hovered` - 总是重命名悬停的文件
- `--force` - 如果目标存在则直接覆盖
- `--empty` - 清空文件名的某部分
  - `"stem"` - 清空主名（保留扩展名）
  - `"ext"` - 清空扩展名（保留主名和点）
  - `"dot_ext"` - 清空点和扩展名
  - `"all"` - 清空整个文件名
- `--cursor` - 指定光标位置
  - `"end"` - 文件名末尾
  - `"start"` - 文件名开头
  - `"before_ext"` - 扩展名前

```toml
[[mgr.prepend_keymap]]
on = "r"
run = "rename"
desc = "Rename file"

[[mgr.prepend_keymap]]
on = "R"
run = "rename --hovered"
desc = "Rename hovered file"

[[mgr.prepend_keymap]]
on = "c"
run = "rename --empty=stem --cursor=start"
desc = "Change file name"

[[mgr.prepend_keymap]]
on = "e"
run = "rename --cursor=before_ext"
desc = "Rename before extension"
```

### copy - 复制路径

复制选中或悬停文件的路径到剪贴板。

**参数**:
- `[what]` - 复制什么：
  - `"path"` - 绝对路径
  - `"dirname"` - 父目录路径
  - `"filename"` - 文件名
  - `"name_without_ext"` - 不含扩展名的文件名
- `--separator` - 路径分隔符：
  - 默认 - 使用系统默认分隔符
  - `"unix"` - 所有平台都使用 `/`
- `--hovered` - 总是复制悬停的文件

```toml
[[mgr.prepend_keymap]]
on = "Y"
run = "copy path"
desc = "Copy file path"

[[mgr.prepend_keymap]]
on = "y"
run = "copy filename"
desc = "Copy filename"

[[mgr.prepend_keymap]]
on = "<C-y>"
run = "copy dirname"
desc = "Copy directory path"
```

### shell - 执行 Shell 命令

运行 shell 命令。

**参数**:
- `[template]` - 命令模板
- `--block` - 阻塞模式（隐藏 Yazi，在主屏幕显示程序）
- `--orphan` - 保持进程运行（即使 Yazi 退出）
- `--interactive` - 交互式输入命令
- `--cursor` - 交互模式下的初始光标位置

**可用变量**:
- `$n` (Unix) / `%n` (Windows) - 第 N 个选中的文件
- `$@` (Unix) / `%*` (Windows) - 所有选中的文件
- `$0` (Unix) / `%0` (Windows) - 悬停的文件

```toml
[[mgr.prepend_keymap]]
on = "!"
run = "shell --interactive"
desc = "Run shell command"

[[mgr.prepend_keymap]]
on = "<C-s>"
run = "shell 'echo $@'"
desc = "Echo selected files"

# 使用 end-of-options 标记避免转义
[[mgr.prepend_keymap]]
on = "t"
run = 'shell -- trash-put "$@"'
desc = "Trash selected files"

# 压缩文件
[[mgr.prepend_keymap]]
on = "z"
run = 'shell \'zip -r archive.zip "$@"\' --interactive'
desc = "Create zip archive"
```

### hidden - 显示/隐藏隐藏文件

设置隐藏文件的可见性。

**参数**:
- `"show"` - 显示隐藏文件
- `"hide"` - 隐藏隐藏文件
- `"toggle"` - 切换隐藏状态

```toml
[[mgr.prepend_keymap]]
on = "."
run = "hidden toggle"
desc = "Toggle hidden files"

[[mgr.prepend_keymap]]
on = "H"
run = "hidden show"
desc = "Show hidden files"
```

### linemode - 设置行模式

设置文件列表的行显示模式。

**参数**:
- `"none"` - 无行模式
- `"size"` - 显示文件大小
- `"btime"` - 显示创建时间
- `"mtime"` - 显示修改时间
- `"permissions"` - 显示权限（仅 Unix-like）
- `"owner"` - 显示所有者（仅 Unix-like）

```toml
[[mgr.prepend_keymap]]
on = "m"
run = "linemode size"
desc = "Show file sizes"

[[mgr.prepend_keymap]]
on = "M"
run = "linemode mtime"
desc = "Show modification times"

[[mgr.prepend_keymap]]
on = "<C-m>"
run = "linemode none"
desc = "Hide line info"
```

### search - 搜索

搜索文件。

**参数**:
- `--via` - 搜索引擎：`fd`、`rg`、`rga`
- `--args` - 传递给搜索引擎的参数

```toml
[[mgr.prepend_keymap]]
on = "s"
run = "search --via rg"
desc = "Search files with ripgrep"

[[mgr.prepend_keymap]]
on = "S"
run = "search --via fd"
desc = "Search files with fd"

# 使用空关键词实现平铺视图
[[mgr.prepend_keymap]]
on = ["g", "f"]
run = 'search_do --via=fd --args="-d 3"'
desc = "Flat view with max depth 3"
```

### find - 查找

在当前目录中交互式增量查找文件。

**参数**:
- `--previous` - 查找上一个匹配项
- `--smart` - 智能大小写（包含大写字符时区分大小写）
- `--insensitive` - 忽略大小写

```toml
[[mgr.prepend_keymap]]
on = "/"
run = "find"
desc = "Find files"

[[mgr.prepend_keymap]]
on = "?"
run = "find --previous"
desc = "Find previous"

[[mgr.prepend_keymap]]
on = "f"
run = "find --smart"
desc = "Find with smart case"
```

### find_arrow - 在查找结果中移动

移动到下一个或上一个匹配项。

**参数**:
- `--previous` - 移动到上一个匹配项

```toml
[[mgr.prepend_keymap]]
on = "n"
run = "find_arrow"
desc = "Next match"

[[mgr.prepend_keymap]]
on = "N"
run = "find_arrow --previous"
desc = "Previous match"
```

### filter - 过滤文件

过滤当前目录中的文件。

**参数**:
- `[query]` - 过滤查询（可选）
- `--smart` - 智能大小写
- `--insensitive` - 忽略大小写

```toml
[[mgr.prepend_keymap]]
on = "F"
run = "filter"
desc = "Filter files"

[[mgr.prepend_keymap]]
on = "<C-f>"
run = "filter --smart"
desc = "Smart filter"
```

### sort - 排序文件

设置文件排序方式。

**参数**:
- `[by]` - 排序方式（可选）：
  - `"none"` - 不排序
  - `"mtime"` - 按修改时间
  - `"btime"` - 按创建时间
  - `"extension"` - 按扩展名
  - `"alphabetical"` - 字母排序
  - `"natural"` - 自然排序
  - `"size"` - 按文件大小
  - `"random"` - 随机排序
- `--reverse` - 反向排序
- `--dir-first` - 目录优先
- `--translit` - 音译排序

```toml
[[mgr.prepend_keymap]]
on = ",m"
run = "sort mtime"
desc = "Sort by modification time"

[[mgr.prepend_keymap]]
on = ",s"
run = "sort size"
desc = "Sort by size"

[[mgr.prepend_keymap]]
on = ",r"
run = "sort --reverse"
desc = "Reverse sort order"

[[mgr.prepend_keymap]]
on = ",n"
run = "sort natural"
desc = "Natural sort"
```

### 标签页操作

#### tab_create - 创建标签页

**参数**:
- `[path]` - 指定路径（可选）
- `--current` - 使用当前路径

```toml
[[mgr.prepend_keymap]]
on = "t"
run = "tab_create --current"
desc = "New tab"

[[mgr.prepend_keymap]]
on = "T"
run = "tab_create ~/Downloads"
desc = "New tab in Downloads"
```

#### tab_close - 关闭标签页

**参数**:
- `[n]` - 关闭位置 n 的标签页（从 0 开始）

```toml
[[mgr.prepend_keymap]]
on = "W"
run = "tab_close 0"
desc = "Close first tab"
```

#### tab_switch - 切换标签页

**参数**:
- `[n]` - 切换到位置 n 的标签页
- `--relative` - 相对于当前标签页切换

```toml
[[mgr.prepend_keymap]]
on = "1"
run = "tab_switch 0"
desc = "Switch to tab 1"

[[mgr.prepend_keymap]]
on = "2"
run = "tab_switch 1"
desc = "Switch to tab 2"

[[mgr.prepend_keymap]]
on = "["
run = "tab_switch -1 --relative"
desc = "Previous tab"

[[mgr.prepend_keymap]]
on = "]"
run = "tab_switch 1 --relative"
desc = "Next tab"
```

#### tab_swap - 交换标签页

**参数**:
- `[n]` - 与位置 n 的标签页交换（负数向前，正数向后）

```toml
[[mgr.prepend_keymap]]
on = "{"
run = "tab_swap -1"
desc = "Swap tab left"

[[mgr.prepend_keymap]]
on = "}"
run = "tab_swap 1"
desc = "Swap tab right"
```

### help - 帮助菜单

打开帮助菜单。

```toml
[[mgr.prepend_keymap]]
on = "?"
run = "help"
desc = "Show help"
```

### plugin - 运行插件

运行功能插件。参见[插件系统](03-plugin-configuration.md)。

### noop - 无操作

用于禁用默认键绑定的虚拟命令。

```toml
[[mgr.prepend_keymap]]
on = ["g", "c"]
run = "noop"
desc = "Disabled keybinding"

# 数组格式（必须只有一个元素且为 "noop"）
[[mgr.prepend_keymap]]
on = ["g", "c"]
run = ["noop"]
```

## [tasks] 任务管理器层级

### show - 显示任务管理器

```toml
[[tasks.prepend_keymap]]
on = "w"
run = "show"
desc = "Show task manager"
```

### close - 隐藏任务管理器

```toml
[[tasks.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Hide task manager"

[[tasks.prepend_keymap]]
on = "q"
run = "close"
desc = "Hide task manager"
```

### arrow - 移动光标

与 [mgr] 层级相同的参数和用法。

```toml
[[tasks.prepend_keymap]]
on = "j"
run = "arrow 1"
desc = "Move down"

[[tasks.prepend_keymap]]
on = "k"
run = "arrow -1"
desc = "Move up"
```

### inspect - 检查任务日志

检查任务日志，包括：
- 失败文件操作的 I/O 错误
- 失败异步插件任务的 Lua 错误
- 后台运行或失败 shell 任务的实时 stdout/stderr

按 `q` 退出检查视图。

```toml
[[tasks.prepend_keymap]]
on = "<Enter>"
run = "inspect"
desc = "Inspect task"

[[tasks.prepend_keymap]]
on = "i"
run = "inspect"
desc = "Inspect task"
```

### cancel - 取消任务

取消选中的任务。

```toml
[[tasks.prepend_keymap]]
on = "d"
run = "cancel"
desc = "Cancel task"

[[tasks.prepend_keymap]]
on = "<Delete>"
run = "cancel"
desc = "Cancel task"
```

### help、plugin、noop

与 [mgr] 层级相同。

## [spot] 文件信息查看器层级

### close - 隐藏查看器

```toml
[[spot.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Hide spotter"

[[spot.prepend_keymap]]
on = "q"
run = "close"
desc = "Hide spotter"
```

### arrow - 移动光标

与其他层级相同。

### swipe - 滑动文件列表

**参数**:
- `[n]` - 滑动文件数量（负数向上，正数向下）

```toml
[[spot.prepend_keymap]]
on = "j"
run = "swipe 1"
desc = "Swipe down"

[[spot.prepend_keymap]]
on = "k"
run = "swipe -1"
desc = "Swipe up"
```

### copy - 复制内容

从查看器复制内容。

**参数**:
- `"cell"` - 复制选中的表格单元格

```toml
[[spot.prepend_keymap]]
on = "y"
run = "copy cell"
desc = "Copy cell content"
```

### plugin、noop、help

与其他层级相同。

## [pick] 选择器层级

### close - 关闭选择器

**参数**:
- `--submit` - 提交选择

```toml
[[pick.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Cancel picker"

[[pick.prepend_keymap]]
on = "q"
run = "close"
desc = "Cancel picker"

[[pick.prepend_keymap]]
on = "<Enter>"
run = "close --submit"
desc = "Submit selection"
```

### arrow、help、plugin、noop

与其他层级相同。

## [input] 输入层级

输入层级支持两种模式：普通模式和插入模式。

### 通用命令

#### close - 关闭输入

**参数**:
- `--submit` - 提交输入

```toml
[[input.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Cancel input"

[[input.prepend_keymap]]
on = "<Enter>"
run = "close --submit"
desc = "Submit input"
```

#### escape - 返回普通模式或取消输入

```toml
[[input.prepend_keymap]]
on = "<Esc>"
run = "escape"
desc = "Back to normal mode or cancel"
```

### 普通模式命令

#### move - 移动光标

**参数**:
- `[n]` - 移动字符数（负数向左，正数向右）
- `--in-operating` - 仅在等待操作时移动光标

```toml
[[input.prepend_keymap]]
on = "h"
run = "move -1"
desc = "Move left"

[[input.prepend_keymap]]
on = "l"
run = "move 1"
desc = "Move right"

[[input.prepend_keymap]]
on = "0"
run = "move -999"
desc = "Move to start"

[[input.prepend_keymap]]
on = "$"
run = "move 999"
desc = "Move to end"
```

#### backward - 向后移动单词

移动到当前或前一个单词的开始。

```toml
[[input.prepend_keymap]]
on = "b"
run = "backward"
desc = "Move word backward"
```

#### forward - 向前移动单词

**参数**:
- `--end-of-word` - 移动到当前或下一个单词的末尾

```toml
[[input.prepend_keymap]]
on = "w"
run = "forward"
desc = "Move word forward"

[[input.prepend_keymap]]
on = "e"
run = "forward --end-of-word"
desc = "Move to end of word"
```

#### insert - 进入插入模式

**参数**:
- `--append` - 在光标后插入

```toml
[[input.prepend_keymap]]
on = "i"
run = "insert"
desc = "Enter insert mode"

[[input.prepend_keymap]]
on = "a"
run = "insert --append"
desc = "Append after cursor"

[[input.prepend_keymap]]
on = "I"
run = "move -999; insert"
desc = "Insert at beginning"

[[input.prepend_keymap]]
on = "A"
run = "move 999; insert --append"
desc = "Append at end"
```

#### visual - 进入视觉模式

仅在普通模式下可用。

```toml
[[input.prepend_keymap]]
on = "v"
run = "visual"
desc = "Enter visual mode"
```

#### delete - 删除选中字符

仅在普通模式下可用。

**参数**:
- `--cut` - 剪切到剪贴板而不是仅删除
- `--insert` - 删除后进入插入模式

```toml
[[input.prepend_keymap]]
on = "d"
run = "delete --cut"
desc = "Delete and cut"

[[input.prepend_keymap]]
on = "D"
run = "delete --cut --insert"
desc = "Delete, cut and insert"

[[input.prepend_keymap]]
on = "x"
run = "delete"
desc = "Delete character"

[[input.prepend_keymap]]
on = "s"
run = "delete --insert"
desc = "Delete and insert"
```

#### yank - 复制选中字符

仅在普通模式下可用。

```toml
[[input.prepend_keymap]]
on = "y"
run = "yank"
desc = "Copy selection"
```

#### paste - 粘贴

仅在普通模式下可用。

**参数**:
- `--before` - 在光标前粘贴

```toml
[[input.prepend_keymap]]
on = "p"
run = "paste"
desc = "Paste after cursor"

[[input.prepend_keymap]]
on = "P"
run = "paste --before"
desc = "Paste before cursor"
```

#### undo - 撤销

仅在普通模式下可用。

```toml
[[input.prepend_keymap]]
on = "u"
run = "undo"
desc = "Undo"
```

#### redo - 重做

仅在普通模式下可用。

```toml
[[input.prepend_keymap]]
on = "<C-r>"
run = "redo"
desc = "Redo"
```

### 插入模式命令

#### backspace - 删除字符

仅在插入模式下可用。

**参数**:
- `--under` - 删除光标下的字符而不是前面的字符

```toml
[[input.prepend_keymap]]
on = "<Backspace>"
run = "backspace"
desc = "Delete previous character"

[[input.prepend_keymap]]
on = "<Delete>"
run = "backspace --under"
desc = "Delete current character"
```

#### kill - 删除指定范围的字符

仅在插入模式下可用。

**参数**:
- `"bol"` - 删除到行首
- `"eol"` - 删除到行尾
- `"backward"` - 删除到当前单词开始
- `"forward"` - 删除到当前单词结尾

```toml
[[input.prepend_keymap]]
on = "<C-u>"
run = "kill bol"
desc = "Kill to beginning of line"

[[input.prepend_keymap]]
on = "<C-k>"
run = "kill eol"
desc = "Kill to end of line"

[[input.prepend_keymap]]
on = "<C-w>"
run = "kill backward"
desc = "Kill word backward"
```

### help、plugin、noop

与其他层级相同。

## [confirm] 确认对话框层级

### close - 关闭对话框

**参数**:
- `--submit` - 提交确认

```toml
[[confirm.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Cancel confirmation"

[[confirm.prepend_keymap]]
on = "q"
run = "close"
desc = "Cancel confirmation"

[[confirm.prepend_keymap]]
on = "<Enter>"
run = "close --submit"
desc = "Confirm action"

[[confirm.prepend_keymap]]
on = "y"
run = "close --submit"
desc = "Yes"

[[confirm.prepend_keymap]]
on = "n"
run = "close"
desc = "No"
```

### arrow、help

与其他层级相同。

## [cmp] 补全层级

### close - 隐藏补全菜单

**参数**:
- `--submit` - 提交补全

```toml
[[cmp.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Hide completion"

[[cmp.prepend_keymap]]
on = "<Enter>"
run = "close --submit"
desc = "Submit completion"

[[cmp.prepend_keymap]]
on = "<Tab>"
run = "close --submit"
desc = "Submit completion"
```

### arrow、help、plugin、noop

与其他层级相同。

## [help] 帮助层级

### close - 隐藏帮助菜单

```toml
[[help.prepend_keymap]]
on = "<Esc>"
run = "close"
desc = "Hide help"

[[help.prepend_keymap]]
on = "q"
run = "close"
desc = "Hide help"
```

### escape - 清除过滤器或隐藏帮助

```toml
[[help.prepend_keymap]]
on = "<Esc>"
run = "escape"
desc = "Clear filter or hide help"
```

### arrow

与其他层级相同。

### filter - 过滤帮助项

应用帮助项过滤器。

```toml
[[help.prepend_keymap]]
on = "/"
run = "filter"
desc = "Filter help items"
```

### plugin、noop

与其他层级相同。

## 完整配置示例

```toml
# keymap.toml - 完整配置示例

[mgr]
prepend_keymap = [
    # 基本导航
    { on = "h", run = "leave", desc = "Go back" },
    { on = "l", run = "enter", desc = "Enter directory" },
    { on = "j", run = "arrow 1", desc = "Move down" },
    { on = "k", run = "arrow -1", desc = "Move up" },

    # 快速跳转
    { on = "g", run = "arrow top", desc = "Go to top" },
    { on = "G", run = "arrow bot", desc = "Go to bottom" },
    { on = ["g", "h"], run = "cd ~", desc = "Go home" },
    { on = ["g", "d"], run = "cd ~/Downloads", desc = "Go to Downloads" },
    { on = ["g", "D"], run = "cd ~/Desktop", desc = "Go to Desktop" },

    # 文件操作
    { on = "<Space>", run = "toggle", desc = "Toggle selection" },
    { on = "y", run = "yank", desc = "Copy files" },
    { on = "x", run = "yank --cut", desc = "Cut files" },
    { on = "p", run = "paste", desc = "Paste files" },
    { on = "d", run = "remove", desc = "Move to trash" },
    { on = "D", run = "remove --permanently", desc = "Delete permanently" },

    # 创建和重命名
    { on = "a", run = "create", desc = "Create file/directory" },
    { on = "r", run = "rename", desc = "Rename" },
    { on = "c", run = "rename --empty=stem --cursor=start", desc = "Change name" },

    # 视图选项
    { on = ".", run = "hidden toggle", desc = "Toggle hidden files" },
    { on = "s", run = "search --via rg", desc = "Search with ripgrep" },
    { on = "/", run = "find", desc = "Find files" },
    { on = "F", run = "filter", desc = "Filter files" },

    # 排序
    { on = "o", run = "sort mtime", desc = "Sort by time" },
    { on = "O", run = "sort size", desc = "Sort by size" },
    { on = ",r", run = "sort --reverse", desc = "Reverse sort" },

    # 标签页
    { on = "t", run = "tab_create --current", desc = "New tab" },
    { on = "T", run = "tab_close 0", desc = "Close tab" },
    { on = "1", run = "tab_switch 0", desc = "Tab 1" },
    { on = "2", run = "tab_switch 1", desc = "Tab 2" },
    { on = "3", run = "tab_switch 2", desc = "Tab 3" },

    # Shell 命令
    { on = "!", run = "shell --interactive", desc = "Shell command" },
    { on = "<C-s>", run = 'shell --block -- fish', desc = "Open shell" },

    # 其他
    { on = "<C-z>", run = "suspend", desc = "Suspend" },
    { on = "?", run = "help", desc = "Help" },
    { on = "q", run = "close", desc = "Close tab or quit" },
]

[tasks]
prepend_keymap = [
    { on = "<Esc>", run = "close", desc = "Close task manager" },
    { on = "j", run = "arrow 1", desc = "Move down" },
    { on = "k", run = "arrow -1", desc = "Move up" },
    { on = "<Enter>", run = "inspect", desc = "Inspect task" },
    { on = "d", run = "cancel", desc = "Cancel task" },
]

[spot]
prepend_keymap = [
    { on = "<Esc>", run = "close", desc = "Close spotter" },
    { on = "j", run = "swipe 1", desc = "Next file" },
    { on = "k", run = "swipe -1", desc = "Previous file" },
    { on = "y", run = "copy cell", desc = "Copy cell" },
]

[pick]
prepend_keymap = [
    { on = "<Esc>", run = "close", desc = "Cancel" },
    { on = "<Enter>", run = "close --submit", desc = "Submit" },
    { on = "j", run = "arrow 1", desc = "Move down" },
    { on = "k", run = "arrow -1", desc = "Move up" },
]

[input]
prepend_keymap = [
    # 普通模式
    { on = "<Esc>", run = "escape", desc = "Normal mode or cancel" },
    { on = "<Enter>", run = "close --submit", desc = "Submit" },
    { on = "i", run = "insert", desc = "Insert mode" },
    { on = "a", run = "insert --append", desc = "Append" },
    { on = "h", run = "move -1", desc = "Move left" },
    { on = "l", run = "move 1", desc = "Move right" },
    { on = "0", run = "move -999", desc = "Move to start" },
    { on = "$", run = "move 999", desc = "Move to end" },
    { on = "w", run = "forward", desc = "Next word" },
    { on = "b", run = "backward", desc = "Previous word" },
    { on = "d", run = "delete --cut", desc = "Delete" },
    { on = "y", run = "yank", desc = "Copy" },
    { on = "p", run = "paste", desc = "Paste" },
    { on = "u", run = "undo", desc = "Undo" },
    { on = "<C-r>", run = "redo", desc = "Redo" },

    # 插入模式
    { on = "<Backspace>", run = "backspace", desc = "Backspace" },
    { on = "<Delete>", run = "backspace --under", desc = "Delete" },
    { on = "<C-u>", run = "kill bol", desc = "Kill to start" },
    { on = "<C-k>", run = "kill eol", desc = "Kill to end" },
    { on = "<C-w>", run = "kill backward", desc = "Kill word" },
]

[confirm]
prepend_keymap = [
    { on = "<Esc>", run = "close", desc = "Cancel" },
    { on = "<Enter>", run = "close --submit", desc = "Confirm" },
    { on = "y", run = "close --submit", desc = "Yes" },
    { on = "n", run = "close", desc = "No" },
    { on = "j", run = "arrow 1", desc = "Move down" },
    { on = "k", run = "arrow -1", desc = "Move up" },
]

[cmp]
prepend_keymap = [
    { on = "<Esc>", run = "close", desc = "Cancel completion" },
    { on = "<Enter>", run = "close --submit", desc = "Submit" },
    { on = "<Tab>", run = "close --submit", desc = "Submit" },
    { on = "j", run = "arrow 1", desc = "Next item" },
    { on = "k", run = "arrow -1", desc = "Previous item" },
]

[help]
prepend_keymap = [
    { on = "<Esc>", run = "close", desc = "Close help" },
    { on = "q", run = "close", desc = "Close help" },
    { on = "j", run = "arrow 1", desc = "Move down" },
    { on = "k", run = "arrow -1", desc = "Move up" },
    { on = "/", run = "filter", desc = "Filter help" },
]
```

## 常用快捷键模板

### Vim 风格导航
```toml
[mgr]
prepend_keymap = [
    { on = "h", run = "leave", desc = "Go back" },
    { on = "l", run = "enter", desc = "Enter" },
    { on = "j", run = "arrow 1", desc = "Down" },
    { on = "k", run = "arrow -1", desc = "Up" },
    { on = "gg", run = "arrow top", desc = "Top" },
    { on = "G", run = "arrow bot", desc = "Bottom" },
    { on = "<C-d>", run = "arrow 50%", desc = "Half down" },
    { on = "<C-u>", run = "arrow -50%", desc = "Half up" },
]
```

### 文件管理器风格
```toml
[mgr]
prepend_keymap = [
    { on = "<Left>", run = "leave", desc = "Go back" },
    { on = "<Right>", run = "enter", desc = "Enter" },
    { on = "<Up>", run = "arrow -1", desc = "Up" },
    { on = "<Down>", run = "arrow 1", desc = "Down" },
    { on = "<Home>", run = "arrow top", desc = "Top" },
    { on = "<End>", run = "arrow bot", desc = "Bottom" },
    { on = "<PageUp>", run = "arrow -50%", desc = "Page up" },
    { on = "<PageDown>", run = "arrow 50%", desc = "Page down" },
]
```

### 快速书签
```toml
[mgr]
prepend_keymap = [
    { on = ["g", "h"], run = "cd ~", desc = "Home" },
    { on = ["g", "d"], run = "cd ~/Downloads", desc = "Downloads" },
    { on = ["g", "D"], run = "cd ~/Desktop", desc = "Desktop" },
    { on = ["g", "c"], run = "cd ~/.config", desc = "Config" },
    { on = ["g", "t"], run = "cd /tmp", desc = "Temp" },
    { on = ["g", "r"], run = "cd /", desc = "Root" },
    { on = ["g", "p"], run = "cd ~/Projects", desc = "Projects" },
    { on = ["g", "m"], run = "cd /media", desc = "Media" },
]
```

通过这些配置，你可以完全自定义 Yazi 的键盘快捷键，使其符合你的使用习惯。
