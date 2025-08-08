# 插件系统与初始化配置

Yazi 提供了强大的 Lua 插件系统，允许你扩展文件管理器的功能。插件系统包括初始化脚本、功能插件、预览器和预加载器。

## init.lua 初始化脚本

`init.lua` 文件用于初始化 Yazi，加载插件并执行启动脚本。

### 基本结构

```lua
-- ~/.config/yazi/init.lua

-- 导入并设置插件
require("your-plugin-name"):setup({
    -- 插件配置
})

-- 直接执行 Lua 代码
function yazi_initialize()
    -- 初始化代码
end
```

### Ya 模块

Ya 是 Yazi 的核心 API 模块，提供与应用程序交互的接口。

#### 基础 API

```lua
-- 文件系统操作
ya.file_cache()              -- 获取文件缓存
ya.dir_changed(path)         -- 目录改变事件

-- UI 操作
ya.notify(message)           -- 显示通知
ya.input(options)            -- 显示输入框
ya.confirm(options)          -- 显示确认对话框

-- 应用程序控制
ya.app_emit(event, data)     -- 发送应用程序事件
ya.manager_emit(event, data) -- 发送管理器事件
```

#### 示例用法

```lua
-- 显示通知
ya.notify({
    title = "Hello",
    content = "Welcome to Yazi!",
    timeout = 3,
    level = "info"  -- info, warn, error
})

-- 获取用户输入
local result = ya.input({
    title = "Enter filename:",
    value = "default.txt",
    position = {0, 0}
})

-- 确认对话框
local confirmed = ya.confirm({
    title = "Delete file?",
    content = "Are you sure you want to delete this file?",
    yes = "Delete",
    no = "Cancel"
})
```

### 事件处理

```lua
-- 文件选择事件
function on_file_selected()
    local selected = ya.current_selected()
    ya.notify("Selected: " .. selected.name)
end

-- 目录切换事件
function on_dir_changed(path)
    ya.notify("Changed to: " .. path)
end

-- 按键事件
function on_key_press(key)
    if key == "F1" then
        ya.notify("F1 pressed!")
        return true  -- 阻止默认行为
    end
    return false  -- 继续默认处理
end
```

### 环境变量和配置

```lua
-- 获取环境变量
local home = os.getenv("HOME")
local config_dir = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")

-- 设置全局变量
yazi_config = {
    enable_icons = true,
    show_hidden = false,
    sort_by = "modified"
}
```

## 功能插件 (Functional Plugins)

功能插件执行特定任务，如文件操作、系统集成等。

### 插件目录结构

```
~/.config/yazi/plugins/
├── my-plugin/
│   ├── init.lua        -- 插件主文件
│   ├── config.lua      -- 配置文件（可选）
│   └── README.md       -- 说明文档
└── another-plugin/
    └── init.lua
```

### 基础插件模板

```lua
-- ~/.config/yazi/plugins/my-plugin/init.lua

local M = {}

-- 插件配置
M.config = {
    enabled = true,
    option1 = "default_value",
    option2 = false
}

-- 主要功能函数
function M.main(state, args)
    local selected = state.selected
    local current = state.current

    -- 处理选中的文件
    for _, file in ipairs(selected) do
        ya.notify("Processing: " .. file.name)
        -- 执行操作...
    end
end

-- 设置函数
function M.setup(opts)
    if opts then
        for k, v in pairs(opts) do
            M.config[k] = v
        end
    end
end

-- 辅助函数
function M.helper_function(param)
    -- 辅助功能...
end

return M
```

### 插件 API

#### State 对象

插件接收的 `state` 参数包含当前状态信息：

```lua
function M.main(state, args)
    -- 当前文件夹信息
    local cwd = state.manager.cwd

    -- 当前悬停的文件
    local hovered = state.manager.hovered

    -- 选中的文件列表
    local selected = state.manager.selected

    -- 标签页信息
    local tabs = state.manager.tabs

    -- 任务信息
    local tasks = state.tasks.progress
end
```

#### 文件操作 API

```lua
-- 文件系统操作
ya.fs_exists(path)           -- 检查文件/目录是否存在
ya.fs_metadata(path)         -- 获取文件元数据
ya.fs_read(path)             -- 读取文件内容
ya.fs_write(path, content)   -- 写入文件内容
ya.fs_remove(path)           -- 删除文件/目录
ya.fs_rename(old, new)       -- 重命名文件/目录
ya.fs_copy(src, dst)         -- 复制文件
ya.fs_create_dir(path)       -- 创建目录

-- 示例：批量重命名文件
function M.batch_rename(state, args)
    local selected = state.manager.selected
    local prefix = args[1] or "renamed_"

    for i, file in ipairs(selected) do
        local old_path = file.url
        local new_name = prefix .. i .. "_" .. file.name
        local new_path = file.parent.url .. "/" .. new_name

        ya.fs_rename(old_path, new_path)
    end

    ya.notify("Renamed " .. #selected .. " files")
end
```

#### 进程执行

```lua
-- 同步执行命令
local output = ya.shell("ls -la", { capture = true })
ya.notify("Output: " .. output.stdout)

-- 异步执行命令
ya.spawn("git status", {
    cwd = state.manager.cwd,
    on_exit = function(status, stdout, stderr)
        if status == 0 then
            ya.notify("Git status: " .. stdout)
        else
            ya.notify("Error: " .. stderr, "error")
        end
    end
})

-- 在终端中执行
ya.shell("vim " .. file.url, { orphan = true })
```

### 实用插件示例

#### Git 状态插件

```lua
-- ~/.config/yazi/plugins/git-status/init.lua

local M = {}

function M.main(state, args)
    local cwd = tostring(state.manager.cwd)

    -- 检查是否在 git 仓库中
    local cmd = "git -C " .. cwd .. " status --porcelain"
    local output = ya.shell(cmd, { capture = true })

    if output.status ~= 0 then
        ya.notify("Not in a git repository", "warn")
        return
    end

    -- 解析 git 状态
    local files = {}
    for line in output.stdout:gmatch("[^\n]+") do
        local status = line:sub(1, 2)
        local file = line:sub(4)
        table.insert(files, { status = status, file = file })
    end

    -- 显示状态
    if #files == 0 then
        ya.notify("Working directory clean", "info")
    else
        local message = "Git status:\n"
        for _, item in ipairs(files) do
            message = message .. item.status .. " " .. item.file .. "\n"
        end
        ya.notify(message, "info")
    end
end

return M
```

#### 文件压缩插件

```lua
-- ~/.config/yazi/plugins/compress/init.lua

local M = {}

M.config = {
    zip_command = "zip -r",
    tar_command = "tar -czf",
    formats = {
        zip = { cmd = "zip -r", ext = ".zip" },
        tar = { cmd = "tar -czf", ext = ".tar.gz" },
        ["7z"] = { cmd = "7z a", ext = ".7z" }
    }
}

function M.main(state, args)
    local selected = state.manager.selected
    if #selected == 0 then
        ya.notify("No files selected", "warn")
        return
    end

    local format = args[1] or "zip"
    local config = M.config.formats[format]

    if not config then
        ya.notify("Unsupported format: " .. format, "error")
        return
    end

    -- 生成压缩文件名
    local archive_name = "archive_" .. os.date("%Y%m%d_%H%M%S") .. config.ext

    -- 构建命令
    local cmd = config.cmd .. " " .. archive_name
    for _, file in ipairs(selected) do
        cmd = cmd .. " " .. file.name
    end

    -- 执行压缩
    ya.spawn(cmd, {
        cwd = tostring(state.manager.cwd),
        on_exit = function(status, stdout, stderr)
            if status == 0 then
                ya.notify("Created: " .. archive_name, "info")
            else
                ya.notify("Compression failed: " .. stderr, "error")
            end
        end
    })
end

function M.setup(opts)
    if opts then
        for k, v in pairs(opts) do
            M.config[k] = v
        end
    end
end

return M
```

#### 系统信息插件

```lua
-- ~/.config/yazi/plugins/sysinfo/init.lua

local M = {}

function M.main(state, args)
    local info = {}

    -- 磁盘使用情况
    local df_output = ya.shell("df -h " .. tostring(state.manager.cwd), { capture = true })
    if df_output.status == 0 then
        local line = df_output.stdout:match("\n([^\n]+)")
        if line then
            local _, _, used, available, percent = line:match("(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)")
            table.insert(info, "Disk: " .. used .. " used, " .. available .. " free (" .. percent .. ")")
        end
    end

    -- 文件统计
    local files = state.manager.current.files
    local file_count = 0
    local dir_count = 0
    local total_size = 0

    for _, file in ipairs(files) do
        if file.is_dir then
            dir_count = dir_count + 1
        else
            file_count = file_count + 1
            total_size = total_size + (file.length or 0)
        end
    end

    table.insert(info, "Files: " .. file_count .. ", Dirs: " .. dir_count)
    table.insert(info, "Total size: " .. M.format_size(total_size))

    -- 显示信息
    ya.notify(table.concat(info, "\n"), "info")
end

function M.format_size(bytes)
    local units = {"B", "KB", "MB", "GB", "TB"}
    local size = bytes
    local unit_index = 1

    while size >= 1024 and unit_index < #units do
        size = size / 1024
        unit_index = unit_index + 1
    end

    return string.format("%.2f %s", size, units[unit_index])
end

return M
```

## 预览器插件 (Previewers)

预览器插件用于预览特定类型的文件。

### 预览器结构

```lua
-- ~/.config/yazi/plugins/my-previewer/init.lua

local M = {}

-- 预览器入口点
function M.peek(job)
    local file = job.file
    local skip = job.skip
    local limit = job.limit

    -- 检查文件类型
    if file.mime_type ~= "text/markdown" then
        return false  -- 不处理此类型文件
    end

    -- 生成预览内容
    local content = M.generate_preview(file.url, skip, limit)

    -- 输出内容
    ya.preview_widgets(job, { content })

    return true  -- 表示已处理
end

function M.generate_preview(path, skip, limit)
    -- 读取文件内容并处理...
    local content = ya.fs_read(path)

    -- 处理 markdown...
    return processed_content
end

return M
```

### Markdown 预览器示例

```lua
-- ~/.config/yazi/plugins/md-preview/init.lua

local M = {}

function M.peek(job)
    local file = job.file

    if not file.url:match("%.md$") then
        return false
    end

    local content = ya.fs_read(file.url)
    if not content then
        return false
    end

    -- 简单的 markdown 渲染
    content = content:gsub("^# (.+)", "🔥 %1")  -- 标题
    content = content:gsub("^## (.+)", "▶ %1")  -- 二级标题
    content = content:gsub("%*%*(.-)%*%*", "🔥%1🔥")  -- 粗体
    content = content:gsub("%*(.-)%*", "⚡%1⚡")  -- 斜体
    content = content:gsub("`([^`]+)`", "💻%1💻")  -- 代码
    content = content:gsub("^%- (.+)", "• %1")  -- 列表项

    ya.preview_widgets(job, {{
        type = "text",
        text = content
    }})

    return true
end

return M
```

### JSON 预览器示例

```lua
-- ~/.config/yazi/plugins/json-preview/init.lua

local M = {}

function M.peek(job)
    local file = job.file

    if not file.url:match("%.json$") then
        return false
    end

    local content = ya.fs_read(file.url)
    if not content then
        return false
    end

    -- 解析 JSON（需要 json 库）
    local ok, data = pcall(function()
        return M.parse_json(content)
    end)

    if not ok then
        ya.preview_widgets(job, {{
            type = "text",
            text = "❌ Invalid JSON file"
        }})
        return true
    end

    -- 格式化显示
    local formatted = M.format_json(data, 0)

    ya.preview_widgets(job, {{
        type = "text",
        text = formatted
    }})

    return true
end

function M.parse_json(str)
    -- 简单的 JSON 解析器（实际使用中应该用专业库）
    return load("return " .. str:gsub("true", "true"):gsub("false", "false"):gsub("null", "nil"))()
end

function M.format_json(data, indent)
    local indent_str = string.rep("  ", indent)

    if type(data) == "table" then
        local result = "{\n"
        for k, v in pairs(data) do
            result = result .. indent_str .. "  " .. tostring(k) .. ": "
            result = result .. M.format_json(v, indent + 1) .. ",\n"
        end
        result = result .. indent_str .. "}"
        return result
    else
        return tostring(data)
    end
end

return M
```

## 预加载器插件 (Preloaders)

预加载器在后台预加载文件信息，提高响应速度。

### 预加载器结构

```lua
-- ~/.config/yazi/plugins/my-preloader/init.lua

local M = {}

function M.preload(job)
    local file = job.file
    local skip = job.skip
    local limit = job.limit

    -- 预加载逻辑
    local result = M.load_data(file.url)

    -- 缓存结果
    ya.file_cache_set(file.url, "my_data", result)

    return result
end

return M
```

### 目录大小预加载器

```lua
-- ~/.config/yazi/plugins/dir-size/init.lua

local M = {}

function M.preload(job)
    local file = job.file

    if not file.is_dir then
        return nil
    end

    -- 在后台计算目录大小
    ya.spawn("du -sh " .. file.url, {
        capture = true,
        on_exit = function(status, stdout, stderr)
            if status == 0 then
                local size = stdout:match("^(%S+)")
                ya.file_cache_set(file.url, "dir_size", size)
                ya.manager_emit("refresh", {})
            end
        end
    })
end

return M
```

### Git 状态预加载器

```lua
-- ~/.config/yazi/plugins/git-preloader/init.lua

local M = {}

function M.preload(job)
    local file = job.file

    -- 检查是否在 git 仓库中
    ya.spawn("git status --porcelain " .. file.url, {
        capture = true,
        on_exit = function(status, stdout, stderr)
            if status == 0 and stdout ~= "" then
                local git_status = stdout:sub(1, 2)
                ya.file_cache_set(file.url, "git_status", git_status)
                ya.manager_emit("refresh", {})
            end
        end
    })
end

return M
```

## 插件配置和注册

### yazi.toml 中的插件配置

```toml
# ~/.config/yazi/yazi.toml

[plugin]
# 预处理器
prependers = [
    { mime = "text/*", run = "highlight" },
    { mime = "*/json", run = "json-preview" },
]

# 预览器
previewers = [
    { mime = "text/markdown", run = "md-preview" },
    { mime = "application/json", run = "json-preview" },
    { name = "*.csv", run = "csv-preview" },
]

# 预加载器
preloaders = [
    { mime = "inode/directory", run = "dir-size" },
    { mime = "*", run = "git-preloader" },
]
```

### init.lua 中的插件初始化

```lua
-- ~/.config/yazi/init.lua

-- 加载并配置插件
require("compress"):setup({
    default_format = "tar",
    include_hidden = false
})

require("git-status"):setup({
    show_untracked = true,
    auto_refresh = true
})

require("sysinfo"):setup({
    show_disk_usage = true,
    refresh_interval = 30
})

-- 注册键盘快捷键
function setup()
    ya.manager_emit("unyank", {})
end

-- 全局快捷键处理
function on_key(key)
    if key == "g" then
        -- 触发 git 状态插件
        require("git-status"):main(ya.current_state(), {})
        return true
    elseif key:match("^<C-c>") then
        -- Ctrl+C 触发压缩插件
        require("compress"):main(ya.current_state(), {"zip"})
        return true
    end

    return false
end
```

### 插件安装脚本

```lua
-- ~/.config/yazi/install_plugins.lua

local plugins = {
    {
        name = "compress",
        url = "https://github.com/user/yazi-compress.git",
        config = { default_format = "tar" }
    },
    {
        name = "git-status",
        url = "https://github.com/user/yazi-git.git",
        config = { auto_refresh = true }
    }
}

function install_plugins()
    for _, plugin in ipairs(plugins) do
        local plugin_dir = os.getenv("HOME") .. "/.config/yazi/plugins/" .. plugin.name

        if not ya.fs_exists(plugin_dir) then
            ya.shell("git clone " .. plugin.url .. " " .. plugin_dir)
            ya.notify("Installed plugin: " .. plugin.name)

            -- 应用配置
            if plugin.config then
                require(plugin.name):setup(plugin.config)
            end
        end
    end
end

-- 运行安装
install_plugins()
```

## 调试和测试

### 调试技巧

```lua
-- 调试输出
function debug_log(message)
    ya.fs_write("/tmp/yazi_debug.log",
                os.date() .. ": " .. tostring(message) .. "\n",
                { append = true })
end

-- 错误处理
function safe_execute(func, ...)
    local ok, result = pcall(func, ...)
    if not ok then
        ya.notify("Plugin error: " .. tostring(result), "error")
        debug_log("Error: " .. tostring(result))
    end
    return ok, result
end

-- 性能测试
function benchmark(func, name)
    local start = os.clock()
    func()
    local duration = os.clock() - start
    debug_log("Benchmark " .. name .. ": " .. duration .. "s")
end
```

### 插件模板生成器

```lua
-- ~/.config/yazi/create_plugin.lua

function create_plugin_template(name, type)
    local plugin_dir = os.getenv("HOME") .. "/.config/yazi/plugins/" .. name
    ya.fs_create_dir(plugin_dir)

    local template = ""

    if type == "functional" then
        template = [[
local M = {}

M.config = {
    enabled = true,
    -- 添加配置选项
}

function M.main(state, args)
    local selected = state.manager.selected
    -- 主要逻辑
    ya.notify("Plugin ]] .. name .. [[ executed")
end

function M.setup(opts)
    if opts then
        for k, v in pairs(opts) do
            M.config[k] = v
        end
    end
end

return M
]]
    elseif type == "previewer" then
        template = [[
local M = {}

function M.peek(job)
    local file = job.file

    -- 检查文件类型
    if not M.supported(file) then
        return false
    end

    -- 生成预览
    local content = M.generate_preview(file.url)
    ya.preview_widgets(job, content)

    return true
end

function M.supported(file)
    -- 检查是否支持此文件类型
    return true
end

function M.generate_preview(path)
    -- 生成预览内容
    return {{ type = "text", text = "Preview for " .. path }}
end

return M
]]
    end

    ya.fs_write(plugin_dir .. "/init.lua", template)
    ya.notify("Created plugin template: " .. name)
end
```

通过这个强大的插件系统，你可以扩展 Yazi 的功能，实现自定义的文件操作、预览器和系统集成功能。插件使用 Lua 编写，提供了丰富的 API 来访问文件系统、执行命令和控制 UI。
