# yazi.toml 主配置文件

`yazi.toml` 是 Yazi 的核心配置文件，控制文件管理器的基本行为、布局、排序和预览等功能。

## [mgr] - 文件管理器设置

### ratio
**类型**: 数组 [整数, 整数, 整数]
**默认值**: [1, 4, 3]
**描述**: 管理器布局比例，三个数字分别表示父目录、当前目录、预览区域的宽度比例。

```toml
[mgr]
ratio = [1, 4, 3]    # 默认：1/8 父目录，4/8 当前目录，3/8 预览
# ratio = [0, 1, 0]  # 只显示当前目录
# ratio = [1, 2, 1]  # 均匀分布
# ratio = [2, 6, 2]  # 强调当前目录
```

**注意**: 至少有一个值必须非零（至少显示一个面板）。

### sort_by
**类型**: 字符串
**默认值**: "natural"
**可选值**:
- `"none"` - 不排序
- `"mtime"` - 按最后修改时间排序
- `"btime"` - 按创建时间排序
- `"extension"` - 按文件扩展名排序
- `"alphabetical"` - 字母排序（1.md < 10.md < 2.md）
- `"natural"` - 自然排序（1.md < 2.md < 10.md）
- `"size"` - 按文件大小排序
- `"random"` - 随机排序

```toml
[mgr]
sort_by = "natural"      # 自然排序（推荐）
# sort_by = "mtime"      # 按修改时间
# sort_by = "size"       # 按文件大小
```

### sort_sensitive
**类型**: 布尔值
**默认值**: false
**描述**: 是否区分大小写排序。

```toml
[mgr]
sort_sensitive = false   # 不区分大小写
# sort_sensitive = true  # 区分大小写
```

### sort_reverse
**类型**: 布尔值
**默认值**: false
**描述**: 是否反向排序。

```toml
[mgr]
sort_reverse = false     # 正常顺序
# sort_reverse = true    # 反向排序
```

### sort_dir_first
**类型**: 布尔值
**默认值**: true
**描述**: 是否优先显示目录。

```toml
[mgr]
sort_dir_first = true    # 目录在前
# sort_dir_first = false # 文件和目录混合排序
```

### sort_translit
**类型**: 布尔值
**默认值**: false
**描述**: 是否音译文件名进行排序（将 Â 替换为 A，Æ 替换为 AE 等）。仅在 `sort_by = "natural"` 时有效。

```toml
[mgr]
sort_translit = false    # 不进行音译
# sort_translit = true   # 进行音译（适用于匈牙利语字符等）
```

### linemode
**类型**: 字符串
**默认值**: "none"
**可选值**:
- `"none"` - 不显示附加信息
- `"size"` - 显示文件大小
- `"btime"` - 显示创建时间
- `"mtime"` - 显示最后修改时间
- `"permissions"` - 显示文件权限（仅 Unix-like 系统）
- `"owner"` - 显示文件所有者（仅 Unix-like 系统）

也可以指定 1-20 个字符的自定义字符串，通过插件系统实现自定义 linemode。

```toml
[mgr]
linemode = "none"        # 不显示附加信息
# linemode = "size"      # 显示文件大小
# linemode = "mtime"     # 显示修改时间
# linemode = "permissions" # 显示权限
```

**自定义 linemode 示例**:
```toml
[mgr]
linemode = "size_and_mtime"
```

对应的 `~/.config/yazi/init.lua`:
```lua
function Linemode:size_and_mtime()
    local time = math.floor(self._file.cha.mtime or 0)
    if time == 0 then
        time = ""
    elseif os.date("%Y", time) == os.date("%Y") then
        time = os.date("%b %d %H:%M", time)
    else
        time = os.date("%b %d  %Y", time)
    end

    local size = self._file:size()
    return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
```

### show_hidden
**类型**: 布尔值
**默认值**: false
**描述**: 是否显示隐藏文件。

```toml
[mgr]
show_hidden = false      # 不显示隐藏文件
# show_hidden = true     # 显示隐藏文件
```

### show_symlink
**类型**: 布尔值
**默认值**: false
**描述**: 是否显示符号链接的目标路径。

```toml
[mgr]
show_symlink = false     # 不显示链接目标
# show_symlink = true    # 显示链接目标
```

### scrolloff
**类型**: 整数
**默认值**: 5
**描述**: 在文件列表中移动时，光标上下保持的文件数量。如果值大于屏幕高度的一半，光标将居中显示。

```toml
[mgr]
scrolloff = 5            # 保持上下 5 个文件的缓冲
# scrolloff = 200        # 大值会使光标居中
# scrolloff = 0          # 无缓冲，光标可以到达边缘
```

### mouse_events
**类型**: 字符串数组
**默认值**: ["click", "scroll"]
**可选值**:
- `"click"` - 鼠标点击
- `"scroll"` - 鼠标垂直滚动
- `"touch"` - 鼠标水平滚动
- `"move"` - 鼠标移动
- `"drag"` - 鼠标拖拽（某些终端不支持）

```toml
[mgr]
mouse_events = ["click", "scroll"]         # 默认
# mouse_events = ["click", "scroll", "move"] # 添加鼠标移动事件
# mouse_events = []                        # 禁用所有鼠标事件
```

### title_format
**类型**: 字符串
**默认值**: "Yazi: {cwd}"
**描述**: 终端标题格式。可用占位符：`{cwd}` - 当前工作目录。设为空字符串禁用标题更新。

```toml
[mgr]
title_format = "Yazi: {cwd}"           # 默认格式
# title_format = "📁 {cwd}"            # 带图标
# title_format = ""                    # 禁用标题更新
# title_format = "File Manager"        # 固定标题
```

## [preview] - 预览设置

### wrap
**类型**: 字符串
**默认值**: "no"
**可选值**:
- `"yes"` - 启用代码预览中的自动换行
- `"no"` - 禁用自动换行

```toml
[preview]
wrap = "no"              # 不换行
# wrap = "yes"           # 自动换行
```

### tab_size
**类型**: 整数
**默认值**: 4
**描述**: 制表符（\t）的显示宽度（空格数）。

```toml
[preview]
tab_size = 4             # 4 个空格
# tab_size = 2           # 2 个空格
# tab_size = 8           # 8 个空格
```

### max_width
**类型**: 整数
**默认值**: 600
**描述**: 图片预览的最大宽度（像素）。修改后需要 `yazi --clear-cache` 清理缓存。这个值也用于图片预加载，值越大缓存占用越多。

```toml
[preview]
max_width = 600          # 600 像素
# max_width = 800        # 更高质量但更占 CPU
# max_width = 400        # 更低质量但更快
```

### max_height
**类型**: 整数
**默认值**: 900
**描述**: 图片预览的最大高度（像素）。修改后需要 `yazi --clear-cache` 清理缓存。

```toml
[preview]
max_height = 900         # 900 像素
# max_height = 1200      # 更高质量
# max_height = 600       # 更低质量
```

### cache_dir
**类型**: 字符串
**默认值**: 系统缓存目录
**描述**: 缓存目录路径。默认使用系统缓存目录，重启时自动清理。指定绝对路径可以使缓存持久化。

```toml
[preview]
# cache_dir = ""         # 使用系统缓存目录（默认）
cache_dir = "/tmp/yazi-cache"  # 自定义缓存目录
# cache_dir = "~/.cache/yazi"   # 用户目录下的缓存
```

### image_delay
**类型**: 整数
**默认值**: 30
**描述**: 开始发送图片预览数据前的延迟时间（毫秒）。用于缓解某些终端渲染图片时的延迟问题。

```toml
[preview]
image_delay = 30         # 30 毫秒延迟
# image_delay = 0        # 无延迟
# image_delay = 100      # 100 毫秒延迟（适用于慢终端）
```

### image_filter
**类型**: 字符串
**默认值**: "triangle"
**可选值**:
- `"nearest"` - 最近邻（最快，质量最差）
- `"triangle"` - 线性三角（平衡）
- `"catmull-rom"` - Catmull-Rom（较慢，质量较好）
- `"lanczos3"` - Lanczos 窗口3（最慢，质量最好）

```toml
[preview]
image_filter = "triangle"      # 默认，平衡质量和速度
# image_filter = "nearest"     # 最快
# image_filter = "lanczos3"    # 最高质量
```

### image_quality
**类型**: 整数
**默认值**: 75
**范围**: 50-90
**描述**: 图片预缓存的质量。值越大质量越好，但 CPU 消耗越大，缓存文件越大。

```toml
[preview]
image_quality = 75       # 平衡质量和性能
# image_quality = 90     # 最高质量
# image_quality = 50     # 最低质量，最快速度
```

### ueberzug_scale
**类型**: 浮点数
**默认值**: 1.0
**描述**: Ueberzug 图片缩放比例。`scale > 1` 放大，`scale < 1` 缩小。

```toml
[preview]
ueberzug_scale = 1.0     # 不缩放
# ueberzug_scale = 0.5   # 缩小到一半（适用于高 DPI 显示器）
# ueberzug_scale = 2.0   # 放大两倍
```

### ueberzug_offset
**类型**: 数组 [浮点数, 浮点数, 浮点数, 浮点数]
**默认值**: [0.0, 0.0, 0.0, 0.0]
**描述**: Ueberzug 图片偏移，以字符单元为单位 [x, y, width, height]。

```toml
[preview]
ueberzug_offset = [0.0, 0.0, 0.0, 0.0]           # 无偏移
# ueberzug_offset = [0.5, 0.5, -0.5, -0.5]       # 各方向偏移半个字符
```

## [opener] - 文件打开器设置

定义可用的文件打开器，在 [open] 规则中引用。

```toml
[opener]
# 文本编辑器
edit = [
    { run = '$EDITOR "$@"', block = true, for = "unix" },
    { run = "%EDITOR% %*", block = true, for = "windows" },
]

# 视频播放器
play = [
    { run = 'mpv "$@"', orphan = true, for = "unix" },
    { run = '"C:\Program Files\mpv.exe" %*', orphan = true, for = "windows" },
]

# 系统默认打开
open = [
    { run = 'xdg-open "$@"', desc = "Open", for = "linux" },
    { run = 'open "$@"', desc = "Open", for = "macos" },
]
```

### 打开器参数说明

- `run`: 要执行的命令
  - `$n` (Unix) / `%n` (Windows): 第 N 个选中的文件（从 1 开始）
  - `$@` (Unix) / `%*` (Windows): 所有选中的文件
  - `$0` (Unix) / `%0` (Windows): 当前悬停的文件

- `block`: 是否阻塞模式（隐藏 Yazi，显示程序到主屏幕）
- `orphan`: 是否保持进程运行（即使 Yazi 退出）
- `desc`: 打开器描述（在交互组件中显示）
- `for`: 限制操作系统
  - `"unix"`: Linux 和 macOS
  - `"windows"`: Windows
  - `"linux"`: 仅 Linux
  - `"macos"`: 仅 macOS
  - `"android"`: Android（Termux）

## [open] - 文件打开规则

定义何时使用哪个打开器。

```toml
[open]
prepend_rules = [
    { name = "*.json", use = "edit" },
]

append_rules = [
    { name = "*", use = "my-fallback" },
]

# 或完全重写规则
rules = [
    { mime = "text/*", use = "edit" },
    { mime = "video/*", use = "play" },
    { name = "*.json", use = "edit" },
    { name = "*.html", use = ["open", "edit"] },  # 多个打开器
]
```

### 规则参数说明

- `name`: 文件名的 Glob 表达式（默认不区分大小写，以 `\s` 开头区分大小写）
- `mime`: MIME 类型的 Glob 表达式（默认不区分大小写）
- `use`: 使用的打开器名称（可以是数组表示多个选择）

## [tasks] - 任务管理设置

### micro_workers
**类型**: 整数
**默认值**: 10
**描述**: 微任务的最大并发数。

```toml
[tasks]
micro_workers = 10       # 10 个微任务工作线程
# micro_workers = 5      # 较少的线程（适用于低配置机器）
# micro_workers = 20     # 更多的线程（适用于高配置机器）
```

### macro_workers
**类型**: 整数
**默认值**: 25
**描述**: 宏任务的最大并发数。

```toml
[tasks]
macro_workers = 25       # 25 个宏任务工作线程
# macro_workers = 10     # 较少的线程
# macro_workers = 50     # 更多的线程
```

### bizarre_retry
**类型**: 整数
**默认值**: 5
**描述**: 奇怪错误发生时的最大重试次数。

```toml
[tasks]
bizarre_retry = 5        # 5 次重试
# bizarre_retry = 3      # 3 次重试
# bizarre_retry = 10     # 10 次重试
```

### suppress_preload
**类型**: 布尔值
**默认值**: false
**描述**: 是否从任务列表中排除系统创建的预加载任务。

```toml
[tasks]
suppress_preload = false  # 显示预加载任务
# suppress_preload = true # 隐藏预加载任务
```

### image_alloc
**类型**: 整数
**默认值**: 536870912 (512MB)
**描述**: 解码单张图片的最大内存分配限制（字节），0 表示无限制。

```toml
[tasks]
image_alloc = 536870912   # 512MB
# image_alloc = 1073741824 # 1GB
# image_alloc = 0          # 无限制（慎用）
```

### image_bound
**类型**: 数组 [整数, 整数]
**默认值**: [0, 0]
**描述**: 解码单张图片的最大尺寸限制 [宽度, 高度]（像素），0 表示无限制。

```toml
[tasks]
image_bound = [0, 0]        # 无限制
# image_bound = [7680, 4320] # 最大 8K 分辨率
# image_bound = [1920, 1080] # 最大 1080p 分辨率
```

## [plugin] - 插件系统设置

### fetchers
获取器用于获取文件信息。

```toml
[plugin]
prepend_fetchers = [
    { id = "git", name = "*", run = "git", prio = "high" },
    { id = "git", name = "*/", run = "git", prio = "high" },
]
```

### previewers
预览器用于预览文件内容。

```toml
[plugin]
prepend_previewers = [
    # HEIC 预览器
    { mime = "image/heic", run = "heic" },
    # RAF 预览器
    { name = "*.raf", run = "raf" },
]

append_previewers = [
    # 自定义回退预览器
    { name = "*", run = "binary" },
]
```

### preloaders
预加载器用于预加载文件信息。

```toml
[plugin]
prepend_preloaders = [
    # HEIC 预加载器
    { mime = "image/heic", run = "heic" },
]
```

### 内置插件

Yazi 自带以下插件：

**预览器**:
- `folder`: 文件夹预览
- `code`: 代码高亮预览
- `json`: JSON 格式化预览
- `noop`: 无操作
- `image`: 图片预览
- `video`: 视频预览
- `pdf`: PDF 预览
- `archive`: 压缩包预览

**预加载器**:
- `mime`: MIME 类型预加载
- `noop`: 无操作
- `image`: 图片预加载
- `video`: 视频预加载
- `pdf`: PDF 预加载

## [input] - 输入框设置

### cursor_blink
**类型**: 布尔值
**默认值**: true
**描述**: 控制光标是否闪烁。

```toml
[input]
cursor_blink = true      # 光标闪烁
# cursor_blink = false   # 光标不闪烁
```

### 各种输入框配置

可以为不同的输入框设置标题和位置：

- `cd` - 切换目录输入框
- `create` - 创建文件/目录输入框
- `rename` - 重命名输入框
- `filter` - 过滤输入框
- `find` - 查找输入框
- `search` - 搜索输入框
- `shell` - Shell 命令输入框

```toml
[input]
# CD 输入框
cd_title = "Change directory:"
cd_origin = "center"
cd_offset = [0, 2, 50, 3]

# 创建输入框
create_title = ["Create file:", "Create directory:"]
create_origin = "top-center"
create_offset = [0, 2, 50, 3]

# 重命名输入框
rename_title = "Rename:"
rename_origin = "hovered"
rename_offset = [0, 1, 50, 3]
```

### Origin 值

- `"top-left"`, `"top-center"`, `"top-right"`
- `"center-left"`, `"center"`, `"center-right"`
- `"bottom-left"`, `"bottom-center"`, `"bottom-right"`
- `"hovered"` - 悬停文件位置

### Offset 格式

`[x, y, width, height]` - x、y 为偏移量，width、height 为输入框大小。

## [confirm] - 确认对话框设置

与 [input] 部分相同的配置选项。可用的确认框：

- `trash` - 删除到回收站确认
- `delete` - 永久删除确认
- `overwrite` - 覆盖文件确认
- `quit` - 退出程序确认

## [pick] - 选择器设置

与 [input] 部分相同的配置选项。可用的选择器：

- `open` - "打开方式"选择器

## [which] - 快捷键提示设置

### sort_by
**类型**: 字符串
**默认值**: "none"
**可选值**:
- `"none"` - 不排序
- `"key"` - 按键排序
- `"desc"` - 按描述排序

```toml
[which]
sort_by = "none"         # 不排序
# sort_by = "key"        # 按键排序
# sort_by = "desc"       # 按描述排序
```

### sort_sensitive
**类型**: 布尔值
**默认值**: false
**描述**: 是否区分大小写排序。

```toml
[which]
sort_sensitive = false   # 不区分大小写
# sort_sensitive = true  # 区分大小写
```

### sort_reverse
**类型**: 布尔值
**默认值**: false
**描述**: 是否反向排序。

```toml
[which]
sort_reverse = false     # 正常顺序
# sort_reverse = true    # 反向排序
```

### sort_translit
**类型**: 布尔值
**默认值**: false
**描述**: 是否音译文件名进行排序。

```toml
[which]
sort_translit = false    # 不音译
# sort_translit = true   # 音译排序
```

## 完整配置示例

```toml
# yazi.toml - 完整配置示例

[mgr]
ratio = [1, 4, 3]
sort_by = "natural"
sort_sensitive = false
sort_reverse = false
sort_dir_first = true
sort_translit = false
linemode = "size"
show_hidden = false
show_symlink = true
scrolloff = 5
mouse_events = ["click", "scroll"]
title_format = "Yazi: {cwd}"

[preview]
wrap = "no"
tab_size = 4
max_width = 600
max_height = 900
cache_dir = ""
image_delay = 30
image_filter = "triangle"
image_quality = 75
ueberzug_scale = 1.0
ueberzug_offset = [0.0, 0.0, 0.0, 0.0]

[opener]
edit = [
    { run = '$EDITOR "$@"', block = true, for = "unix" },
    { run = "%EDITOR% %*", block = true, for = "windows" },
]
play = [
    { run = 'mpv "$@"', orphan = true, for = "unix" },
    { run = '"C:\Program Files\mpv.exe" %*', orphan = true, for = "windows" },
]
open = [
    { run = 'xdg-open "$@"', desc = "Open", for = "linux" },
    { run = 'open "$@"', desc = "Open", for = "macos" },
]

[open]
rules = [
    { mime = "text/*", use = "edit" },
    { mime = "video/*", use = "play" },
    { mime = "audio/*", use = "play" },
    { name = "*", use = "open" },
]

[tasks]
micro_workers = 10
macro_workers = 25
bizarre_retry = 5
suppress_preload = false
image_alloc = 536870912
image_bound = [0, 0]

[input]
cursor_blink = true
cd_title = "Change directory:"
cd_origin = "center"
cd_offset = [0, 2, 50, 3]

[which]
sort_by = "none"
sort_sensitive = false
sort_reverse = false
sort_translit = false
```
