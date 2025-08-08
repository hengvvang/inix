# 插件配置 (Plugins)

Zellij 的插件系统允许你自定义和扩展功能。插件可以通过别名配置，也可以在后台加载。

## 插件别名配置

插件别名允许你为插件定义名称和位置，然后在布局或键绑定中引用它们。

```kdl
plugins {
    // 内置插件别名
    tab-bar location="zellij:tab-bar"
    status-bar location="zellij:status-bar"
    strider location="zellij:strider"
    compact-bar location="zellij:compact-bar"
    session-manager location="zellij:session-manager"
    welcome-screen location="zellij:session-manager" {
        welcome_screen true
    }
    filepicker location="zellij:strider" {
        cwd "/"
    }
    configuration location="zellij:configuration"
    plugin-manager location="zellij:plugin-manager"
    about location="zellij:about"
}
```

## 内置插件说明

### tab-bar
标签页栏插件，显示所有标签页

**位置:** `"zellij:tab-bar"`
**功能:** 显示标签页列表和状态

### status-bar
状态栏插件，显示模式和键绑定提示

**位置:** `"zellij:status-bar"`
**功能:** 显示当前模式、可用键绑定和系统状态

### compact-bar
紧凑状态栏，节省空间的状态栏替代品

**位置:** `"zellij:compact-bar"`
**功能:** 显示精简的状态信息

### strider
文件浏览器插件

**位置:** `"zellij:strider"`
**配置选项:**
```kdl
strider location="zellij:strider" {
    cwd "/path/to/directory"  // 起始目录
}
```

### session-manager
会话管理器插件

**位置:** `"zellij:session-manager"`
**配置选项:**
```kdl
session-manager location="zellij:session-manager" {
    welcome_screen false  // 是否显示欢迎界面
}
```

### welcome-screen
欢迎界面插件（基于 session-manager）

**位置:** `"zellij:session-manager"`
**配置选项:**
```kdl
welcome-screen location="zellij:session-manager" {
    welcome_screen true
}
```

### filepicker
文件选择器插件（基于 strider）

**位置:** `"zellij:strider"`
**配置选项:**
```kdl
filepicker location="zellij:strider" {
    cwd "/"  // 起始目录
}
```

### configuration
配置编辑器插件

**位置:** `"zellij:configuration"`
**功能:** 允许在运行时编辑配置

### plugin-manager
插件管理器

**位置:** `"zellij:plugin-manager"`
**功能:** 管理和配置插件

### about
关于信息插件

**位置:** `"zellij:about"`
**功能:** 显示版本信息和帮助

## 自定义插件配置

### 本地文件插件

```kdl
plugins {
    my-plugin location="file:/path/to/my-plugin.wasm" {
        // 插件特定配置
        option1 "value1"
        option2 42
    }
}
```

### 远程插件

```kdl
plugins {
    remote-plugin location="https://example.com/my-plugin.wasm" {
        // 插件配置
    }
}
```

### Git 仓库插件

```kdl
plugins {
    git-plugin location="https://github.com/user/repo" {
        // 插件配置
    }
}
```

## 后台插件加载

`load_plugins` 块允许在新会话启动时加载后台插件：

```kdl
load_plugins {
    "file:/path/to/my-plugin.wasm"
    "https://example.com/my-plugin.wasm"
}
```

## 插件在键绑定中的使用

### LaunchOrFocusPlugin
启动或聚焦插件

```kdl
bind "w" {
    LaunchOrFocusPlugin "session-manager" {
        floating true
        move_to_focused_tab true
    };
    SwitchToMode "Normal"
}
```

**插件启动选项:**
- `floating true/false` - 是否以浮动窗口显示
- `move_to_focused_tab true/false` - 是否移动到聚焦的标签页
- `move_to_tab <number>` - 移动到指定编号的标签页

### 常见插件键绑定示例

```kdl
session {
    // 会话管理器
    bind "w" {
        LaunchOrFocusPlugin "session-manager" {
            floating true
            move_to_focused_tab true
        };
        SwitchToMode "Normal"
    }

    // 配置编辑器
    bind "c" {
        LaunchOrFocusPlugin "configuration" {
            floating true
            move_to_focused_tab true
        };
        SwitchToMode "Normal"
    }

    // 插件管理器
    bind "p" {
        LaunchOrFocusPlugin "plugin-manager" {
            floating true
            move_to_focused_tab true
        };
        SwitchToMode "Normal"
    }

    // 关于页面
    bind "a" {
        LaunchOrFocusPlugin "zellij:about" {
            floating true
            move_to_focused_tab true
        };
        SwitchToMode "Normal"
    }

    // 分享插件
    bind "s" {
        LaunchOrFocusPlugin "zellij:share" {
            floating true
            move_to_focused_tab true
        };
        SwitchToMode "Normal"
    }
}
```

## 插件开发配置

### 插件配置传递

插件可以接收配置参数：

```kdl
plugins {
    my-custom-plugin location="file:/path/to/plugin.wasm" {
        // 字符串参数
        database_url "postgresql://localhost/mydb"

        // 数字参数
        refresh_interval 30

        // 布尔参数
        debug_mode true

        // 嵌套配置
        ui {
            theme "dark"
            font_size 14
        }

        // 数组配置
        ignored_files "*.tmp" "*.log" ".git"
    }
}
```

### 插件权限配置

某些插件可能需要特定权限：

```kdl
plugins {
    file-manager location="file:/path/to/file-manager.wasm" {
        // 文件系统权限
        allow_file_access true
        allowed_paths "/home/user" "/opt/projects"

        // 网络权限
        allow_network false

        // 命令执行权限
        allow_exec true
        allowed_commands "ls" "cat" "grep"
    }
}
```

## 插件管理最佳实践

### 基本插件集

推荐的基本插件配置：

```kdl
plugins {
    tab-bar location="zellij:tab-bar"
    status-bar location="zellij:status-bar"
    strider location="zellij:strider"
    session-manager location="zellij:session-manager"
}
```

### 开发者插件集

适合开发者的插件配置：

```kdl
plugins {
    compact-bar location="zellij:compact-bar"
    strider location="zellij:strider" {
        cwd "~/projects"
    }
    session-manager location="zellij:session-manager"
    configuration location="zellij:configuration"
    plugin-manager location="zellij:plugin-manager"
}
```

### 最小化插件集

最小化界面的插件配置：

```kdl
plugins {
    compact-bar location="zellij:compact-bar"
}
```

## 注意事项

1. **重启要求:** 更改插件别名配置需要重启 Zellij 才能生效
2. **性能影响:** 加载过多后台插件可能影响性能
3. **权限安全:** 仅加载信任的插件，特别是具有文件系统或网络访问权限的插件
4. **版本兼容:** 确保插件与当前 Zellij 版本兼容
