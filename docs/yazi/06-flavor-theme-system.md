# 主题系统与 Flavor 配置

Yazi 的主题系统包括内置主题、社区主题包（Flavors）以及自定义主题创建。Flavor 是预配置的主题包，包含完整的配色方案和图标配置。

## Flavor 主题包概述

### 什么是 Flavor

Flavor 是 Yazi 的预制主题包，包含：
- 完整的颜色配置（`theme.toml`）
- 语法高亮主题（`tmtheme.xml`）
- 图标配置
- 预览样式设置

### Flavor 目录结构

```
~/.config/yazi/flavors/
├── gruvbox-dark/
│   ├── flavor.toml       -- Flavor 元数据
│   ├── theme.toml        -- 主题配置
│   ├── tmtheme.xml       -- 语法高亮主题
│   └── README.md         -- 说明文档
├── dracula/
│   ├── flavor.toml
│   ├── theme.toml
│   ├── tmtheme.xml
│   └── LICENSE
└── custom-theme/
    ├── flavor.toml
    └── theme.toml
```

## flavor.toml 元数据配置

每个 Flavor 都有一个 `flavor.toml` 文件描述主题信息。

### 基本信息

```toml
# ~/.config/yazi/flavors/my-flavor/flavor.toml

[flavor]
# 主题名称
name = "My Custom Theme"

# 主题作者
author = "Your Name <your.email@example.com>"

# 主题版本
version = "1.0.0"

# 主题描述
description = "A beautiful custom theme for Yazi"

# 许可证
license = "MIT"

# 主题主页
homepage = "https://github.com/username/yazi-theme"

# 仓库地址
repository = "https://github.com/username/yazi-theme.git"

# 关键词
keywords = ["dark", "colorful", "modern"]

# 是否为深色主题
dark = true
```

### 依赖和兼容性

```toml
[flavor]
name = "Advanced Theme"
author = "Developer <dev@example.com>"

# Yazi 版本要求
yazi_version = ">=0.2.0"

# 依赖的其他 Flavor
dependencies = [
    "base-icons@1.0.0",
    "nerd-fonts@2.1.0"
]

# 兼容的终端
compatible_terminals = [
    "kitty",
    "alacritty",
    "wezterm",
    "iterm2"
]

# 所需功能
required_features = [
    "truecolor",
    "unicode"
]
```

### 安装脚本

```toml
[flavor]
name = "Complex Theme"

# 安装后脚本
[install]
# 需要额外下载的文件
downloads = [
    {
        url = "https://example.com/extra-icons.zip",
        path = "icons/",
        checksum = "sha256:abc123..."
    }
]

# 安装后执行的命令
post_install = [
    "echo 'Theme installed successfully'",
    "notify-send 'Yazi Theme' 'New theme activated'"
]

# 卸载时执行
pre_uninstall = [
    "rm -rf ~/.cache/yazi/theme-cache"
]
```

## 内置和社区 Flavor

### 官方内置主题

Yazi 内置多个高质量主题：

```toml
# ~/.config/yazi/yazi.toml

[flavor]
# 深色主题选择
dark = "gruvbox-dark"       # Gruvbox 深色
# dark = "dracula"          # Dracula 主题
# dark = "nord"             # Nord 主题
# dark = "onedark"          # One Dark 主题
# dark = "monokai"          # Monokai 主题
# dark = "catppuccin-mocha" # Catppuccin Mocha

# 浅色主题选择
light = "gruvbox-light"     # Gruvbox 浅色
# light = "solarized-light" # Solarized Light
# light = "github-light"    # GitHub Light
# light = "catppuccin-latte"# Catppuccin Latte
```

### 社区主题安装

#### 使用 Git 安装

```bash
# 克隆主题仓库
cd ~/.config/yazi/flavors
git clone https://github.com/username/yazi-theme-name.git theme-name

# 或者使用子模块
cd ~/.config/yazi
git submodule add https://github.com/username/yazi-theme.git flavors/theme-name
```

#### 手动安装

```bash
# 创建主题目录
mkdir -p ~/.config/yazi/flavors/my-theme

# 下载主题文件
curl -o ~/.config/yazi/flavors/my-theme/theme.toml \
     https://raw.githubusercontent.com/user/repo/main/theme.toml

curl -o ~/.config/yazi/flavors/my-theme/flavor.toml \
     https://raw.githubusercontent.com/user/repo/main/flavor.toml
```

#### 使用包管理器

```bash
# 使用 yay（示例，实际可能不存在）
yay -S yazi-theme-gruvbox

# 使用 brew
brew install yazi-theme-collection

# 使用 npm（社区包）
npm install -g yazi-themes
yazi-themes install gruvbox-dark
```

## 创建自定义 Flavor

### 基础 Flavor 创建

```bash
# 创建 Flavor 目录
mkdir -p ~/.config/yazi/flavors/my-custom-theme
cd ~/.config/yazi/flavors/my-custom-theme
```

#### 1. 创建 flavor.toml

```toml
# flavor.toml
[flavor]
name = "My Custom Theme"
author = "Your Name <email@example.com>"
version = "1.0.0"
description = "A personalized theme with custom colors"
license = "MIT"
dark = true
keywords = ["custom", "personal", "dark"]
```

#### 2. 创建 theme.toml

```toml
# theme.toml
[mgr]
cwd = { fg = "#89b4fa", bold = true }
hovered = { fg = "#1e1e2e", bg = "#f9e2af" }
preview_hovered = { fg = "#1e1e2e", bg = "#f9e2af" }
find_keyword = { fg = "#f38ba8", bold = true, underline = true }
find_position = { fg = "#cba6f7", italic = true }

marker_copied = { fg = "#a6e3a1", bg = "#a6e3a1" }
marker_cut = { fg = "#f38ba8", bg = "#f38ba8" }
marker_marked = { fg = "#89dceb", bg = "#89dceb" }
marker_selected = { fg = "#f9e2af", bg = "#f9e2af" }

count_copied = { fg = "#1e1e2e", bg = "#a6e3a1", bold = true }
count_cut = { fg = "#1e1e2e", bg = "#f38ba8", bold = true }
count_selected = { fg = "#1e1e2e", bg = "#f9e2af", bold = true }

border_symbol = "│"
border_style = { fg = "#6c7086" }

[tabs]
active = { fg = "#1e1e2e", bg = "#cba6f7", bold = true }
inactive = { fg = "#bac2de", bg = "#45475a" }

[status]
overall = { bg = "#313244" }
sep_left = { open = "", close = " " }
sep_right = { open = " ", close = "" }

perm_type = { fg = "#89b4fa", bold = true }
perm_read = { fg = "#a6e3a1" }
perm_write = { fg = "#f9e2af" }
perm_exec = { fg = "#fab387" }
perm_sep = { fg = "#6c7086" }

progress_label = { fg = "#cdd6f4", bold = true }
progress_normal = { fg = "#89b4fa", bg = "#313244" }
progress_error = { fg = "#f38ba8", bg = "#313244", bold = true }

[filetype]
rules = [
    { mime = "image/*", fg = "#f9e2af" },
    { mime = "video/*", fg = "#cba6f7" },
    { mime = "audio/*", fg = "#cba6f7" },
    { name = "*.zip", fg = "#f38ba8" },
    { name = "*.pdf", fg = "#89dceb" },
    { name = "*", is = "orphan", fg = "#f38ba8" },
    { name = "*/", fg = "#89b4fa" },
]
```

#### 3. 添加语法高亮主题

```xml
<!-- tmtheme.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>name</key>
    <string>My Custom Theme</string>
    <key>settings</key>
    <array>
        <dict>
            <key>settings</key>
            <dict>
                <key>background</key>
                <string>#1e1e2e</string>
                <key>foreground</key>
                <string>#cdd6f4</string>
                <key>caret</key>
                <string>#f5e0dc</string>
                <key>selection</key>
                <string>#45475a</string>
                <key>lineHighlight</key>
                <string>#313244</string>
            </dict>
        </dict>
        <dict>
            <key>name</key>
            <string>Comment</string>
            <key>scope</key>
            <string>comment</string>
            <key>settings</key>
            <dict>
                <key>foreground</key>
                <string>#6c7086</string>
                <key>fontStyle</key>
                <string>italic</string>
            </dict>
        </dict>
        <dict>
            <key>name</key>
            <string>String</string>
            <key>scope</key>
            <string>string</string>
            <key>settings</key>
            <dict>
                <key>foreground</key>
                <string>#a6e3a1</string>
            </dict>
        </dict>
        <dict>
            <key>name</key>
            <string>Keyword</string>
            <key>scope</key>
            <string>keyword</string>
            <key>settings</key>
            <dict>
                <key>foreground</key>
                <string>#cba6f7</string>
                <key>fontStyle</key>
                <string>bold</string>
            </dict>
        </dict>
        <dict>
            <key>name</key>
            <string>Function</string>
            <key>scope</key>
            <string>entity.name.function</string>
            <key>settings</key>
            <dict>
                <key>foreground</key>
                <string>#89b4fa</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
```

### 高级 Flavor 功能

#### 多变体支持

```toml
# flavor.toml
[flavor]
name = "Adaptive Theme"
description = "Theme with multiple variants"

# 定义变体
[variants]
dark = { theme = "theme-dark.toml", tmtheme = "tmtheme-dark.xml" }
light = { theme = "theme-light.toml", tmtheme = "tmtheme-light.xml" }
contrast = { theme = "theme-contrast.toml", tmtheme = "tmtheme-contrast.xml" }

# 默认变体
default_variant = "dark"
```

#### 动态颜色支持

```toml
# flavor.toml
[flavor]
name = "Dynamic Theme"

[dynamic]
# 支持系统颜色
supports_system_colors = true

# 自动切换深浅色
auto_switch = true

# 时间基础切换
time_based = {
    light_start = "06:00",
    dark_start = "18:00"
}

# 根据壁纸调整
wallpaper_based = true
```

#### 条件加载

```toml
# flavor.toml
[flavor]
name = "Conditional Theme"

[conditions]
# 根据终端类型加载不同配置
[[conditions.terminal]]
name = "kitty"
theme = "theme-kitty.toml"
features = ["truecolor", "unicode"]

[[conditions.terminal]]
name = "alacritty"
theme = "theme-alacritty.toml"

[[conditions.terminal]]
name = "default"
theme = "theme-fallback.toml"

# 根据操作系统
[[conditions.os]]
name = "linux"
icon_set = "linux-icons"

[[conditions.os]]
name = "macos"
icon_set = "mac-icons"

[[conditions.os]]
name = "windows"
icon_set = "windows-icons"
```

### 主题生成器脚本

#### 从现有主题生成

```lua
-- ~/.config/yazi/scripts/theme_generator.lua

local M = {}

function M.generate_from_base16(base16_colors)
    local theme = {
        mgr = {
            cwd = { fg = base16_colors.base0D, bold = true },
            hovered = { fg = base16_colors.base00, bg = base16_colors.base0A },
            find_keyword = { fg = base16_colors.base08, bold = true },
            -- ... 更多配置
        }
    }

    return M.theme_to_toml(theme)
end

function M.theme_to_toml(theme)
    local toml = ""
    for section, values in pairs(theme) do
        toml = toml .. "[" .. section .. "]\n"
        for key, style in pairs(values) do
            toml = toml .. key .. " = " .. M.style_to_toml(style) .. "\n"
        end
        toml = toml .. "\n"
    end
    return toml
end

function M.style_to_toml(style)
    local parts = {}
    for k, v in pairs(style) do
        if type(v) == "string" then
            table.insert(parts, k .. ' = "' .. v .. '"')
        else
            table.insert(parts, k .. " = " .. tostring(v))
        end
    end
    return "{ " .. table.concat(parts, ", ") .. " }"
end

-- 使用示例
local base16_gruvbox = {
    base00 = "#282828", base01 = "#3c3836", base02 = "#504945", base03 = "#665c54",
    base04 = "#bdae93", base05 = "#d5c4a1", base06 = "#ebdbb2", base07 = "#fbf1c7",
    base08 = "#fb4934", base09 = "#fe8019", base0A = "#fabd2f", base0B = "#b8bb26",
    base0C = "#8ec07c", base0D = "#83a598", base0E = "#d3869b", base0F = "#d65d0e"
}

local generated_theme = M.generate_from_base16(base16_gruvbox)
ya.fs_write("~/.config/yazi/flavors/generated/theme.toml", generated_theme)

return M
```

#### 颜色提取器

```lua
-- ~/.config/yazi/scripts/color_extractor.lua

local M = {}

function M.extract_from_wallpaper(image_path)
    -- 使用 imagemagick 提取主要颜色
    local cmd = "convert " .. image_path .. " -resize 50x50 -colors 8 -format '%c' histogram:info:"
    local output = ya.shell(cmd, { capture = true })

    local colors = {}
    for line in output.stdout:gmatch("[^\n]+") do
        local count, color = line:match("(%d+):%s*#(%w+)")
        if color then
            table.insert(colors, { count = tonumber(count), color = "#" .. color })
        end
    end

    -- 按使用频率排序
    table.sort(colors, function(a, b) return a.count > b.count end)

    return M.generate_theme_from_colors(colors)
end

function M.generate_theme_from_colors(colors)
    -- 分配颜色角色
    local bg = colors[1].color        -- 最常用作背景
    local fg = colors[#colors].color  -- 最少用作前景
    local accent1 = colors[2].color   -- 强调色1
    local accent2 = colors[3].color   -- 强调色2
    local accent3 = colors[4].color   -- 强调色3

    return {
        mgr = {
            cwd = { fg = accent1, bold = true },
            hovered = { fg = bg, bg = accent2 },
            find_keyword = { fg = accent3, bold = true },
            marker_selected = { fg = accent1, bg = accent1 },
        },
        status = {
            overall = { bg = M.darken(bg, 0.1) },
            progress_normal = { fg = accent1 },
        }
    }
end

function M.darken(color, factor)
    -- 简单的颜色变暗函数
    local r, g, b = color:match("#(%w%w)(%w%w)(%w%w)")
    r = math.floor(tonumber(r, 16) * (1 - factor))
    g = math.floor(tonumber(g, 16) * (1 - factor))
    b = math.floor(tonumber(b, 16) * (1 - factor))
    return string.format("#%02x%02x%02x", r, g, b)
end

return M
```

## Flavor 管理

### Flavor 管理器脚本

```lua
-- ~/.config/yazi/scripts/flavor_manager.lua

local M = {}

function M.list_available()
    local flavors = {}
    local flavor_dir = os.getenv("HOME") .. "/.config/yazi/flavors"

    for dir in ya.fs_list_dirs(flavor_dir) do
        local flavor_file = dir .. "/flavor.toml"
        if ya.fs_exists(flavor_file) then
            local flavor_info = M.parse_flavor_info(flavor_file)
            table.insert(flavors, flavor_info)
        end
    end

    return flavors
end

function M.parse_flavor_info(flavor_file)
    local content = ya.fs_read(flavor_file)
    -- 简单的 TOML 解析（实际应用中使用专业库）
    local info = {}
    info.name = content:match('name%s*=%s*"([^"]+)"') or "Unknown"
    info.author = content:match('author%s*=%s*"([^"]+)"') or "Unknown"
    info.version = content:match('version%s*=%s*"([^"]+)"') or "0.0.0"
    info.description = content:match('description%s*=%s*"([^"]+)"') or ""
    return info
end

function M.switch_flavor(flavor_name, variant)
    local config_file = os.getenv("HOME") .. "/.config/yazi/yazi.toml"
    local config = ya.fs_read(config_file)

    -- 更新配置中的 flavor 设置
    if variant == "light" then
        config = config:gsub('light%s*=%s*"[^"]*"', 'light = "' .. flavor_name .. '"')
    else
        config = config:gsub('dark%s*=%s*"[^"]*"', 'dark = "' .. flavor_name .. '"')
    end

    ya.fs_write(config_file, config)
    ya.notify("Switched to flavor: " .. flavor_name, "info")

    -- 刷新界面
    ya.manager_emit("refresh", {})
end

function M.preview_flavor(flavor_name)
    -- 临时切换主题进行预览
    local current_theme = M.get_current_theme()
    M.switch_flavor(flavor_name, "dark")

    ya.input({
        title = "Preview: " .. flavor_name,
        content = "Press Enter to apply, Esc to revert",
        on_cancel = function()
            M.switch_flavor(current_theme, "dark")
        end
    })
end

function M.install_from_url(url, name)
    local temp_dir = "/tmp/yazi_flavor_" .. name
    local target_dir = os.getenv("HOME") .. "/.config/yazi/flavors/" .. name

    -- 克隆仓库
    ya.spawn("git clone " .. url .. " " .. temp_dir, {
        on_exit = function(status, stdout, stderr)
            if status == 0 then
                -- 移动到目标目录
                ya.shell("mv " .. temp_dir .. " " .. target_dir)
                ya.notify("Installed flavor: " .. name, "info")
            else
                ya.notify("Failed to install flavor: " .. stderr, "error")
            end
        end
    })
end

return M
```

### 交互式 Flavor 选择器

```lua
-- ~/.config/yazi/scripts/flavor_picker.lua

local M = {}

function M.show_flavor_picker()
    local flavors = require("flavor_manager"):list_available()

    local items = {}
    for _, flavor in ipairs(flavors) do
        table.insert(items, {
            text = flavor.name .. " (" .. flavor.version .. ")",
            description = flavor.description,
            author = flavor.author,
            value = flavor.name
        })
    end

    ya.pick({
        title = "Select Theme",
        items = items,
        columns = {
            { name = "name", width = 20 },
            { name = "author", width = 15 },
            { name = "description", width = 40 }
        },
        on_select = function(item)
            require("flavor_manager"):switch_flavor(item.value, "dark")
        end,
        on_preview = function(item)
            require("flavor_manager"):preview_flavor(item.value)
        end
    })
end

-- 快速切换功能
function M.quick_switch()
    local favorites = {
        "gruvbox-dark",
        "dracula",
        "nord",
        "catppuccin-mocha"
    }

    local current = M.get_current_flavor()
    local current_index = 1

    for i, flavor in ipairs(favorites) do
        if flavor == current then
            current_index = i
            break
        end
    end

    local next_index = (current_index % #favorites) + 1
    local next_flavor = favorites[next_index]

    require("flavor_manager"):switch_flavor(next_flavor, "dark")
    ya.notify("Switched to: " .. next_flavor, "info")
end

return M
```

## 主题分发和分享

### 创建主题包

```bash
#!/bin/bash
# create_flavor_package.sh

FLAVOR_NAME="$1"
VERSION="$2"

if [ -z "$FLAVOR_NAME" ] || [ -z "$VERSION" ]; then
    echo "Usage: $0 <flavor_name> <version>"
    exit 1
fi

FLAVOR_DIR="$HOME/.config/yazi/flavors/$FLAVOR_NAME"
PACKAGE_DIR="/tmp/yazi-flavor-$FLAVOR_NAME-$VERSION"

# 创建包目录
mkdir -p "$PACKAGE_DIR"

# 复制主题文件
cp -r "$FLAVOR_DIR"/* "$PACKAGE_DIR/"

# 创建安装脚本
cat > "$PACKAGE_DIR/install.sh" << 'EOF'
#!/bin/bash
INSTALL_DIR="$HOME/.config/yazi/flavors/$(basename $(pwd))"
mkdir -p "$INSTALL_DIR"
cp -r . "$INSTALL_DIR/"
echo "Installed flavor to $INSTALL_DIR"
EOF

chmod +x "$PACKAGE_DIR/install.sh"

# 创建压缩包
cd /tmp
tar -czf "yazi-flavor-$FLAVOR_NAME-$VERSION.tar.gz" "yazi-flavor-$FLAVOR_NAME-$VERSION"

echo "Package created: /tmp/yazi-flavor-$FLAVOR_NAME-$VERSION.tar.gz"
```

### 主题仓库模板

```toml
# flavor.toml - 发布准备
[flavor]
name = "My Amazing Theme"
author = "Your Name <your.email@example.com>"
version = "1.2.0"
description = "A beautiful and functional theme for Yazi file manager"
license = "MIT"
homepage = "https://github.com/username/yazi-theme-name"
repository = "https://github.com/username/yazi-theme-name.git"
keywords = ["dark", "colorful", "productivity", "terminal"]

yazi_version = ">=0.2.0"
dark = true

# 截图和演示
screenshots = [
    "screenshots/main-view.png",
    "screenshots/file-preview.png",
    "screenshots/search-highlight.png"
]

# 安装说明
install_notes = """
This theme works best with:
- A terminal that supports 24-bit colors
- Nerd Fonts for proper icon display
- A dark terminal background
"""
```

通过 Flavor 系统，你可以轻松管理、切换和分享 Yazi 主题，让文件管理器拥有个性化的外观和风格。无论是使用现有的主题还是创建自己的主题，Flavor 系统都提供了灵活而强大的解决方案。
