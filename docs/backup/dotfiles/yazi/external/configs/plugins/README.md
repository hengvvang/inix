# Yazi Plugins

这里包含了为 Yazi 文件管理器定制的插件。

## 可用插件

### smart-enter.yazi
智能进入插件，对目录执行进入操作，对文件执行打开操作。

**使用方法：**
在 `keymap.toml` 中添加：
```toml
{ on = [ "l" ], run = "plugin smart-enter", desc = "Smart enter" }
```

### mkdir.yazi
快速创建目录插件。

**使用方法：**
在 `keymap.toml` 中添加：
```toml
{ on = [ "M" ], run = "plugin mkdir", desc = "Create directory" }
```

### show-size.yazi
显示当前文件或目录大小的插件。

**使用方法：**
在 `keymap.toml` 中添加：
```toml
{ on = [ "s" ], run = "plugin show-size", desc = "Show file size" }
```

## 插件目录结构

```
plugins/
├── README.md
├── smart-enter.yazi/
│   ├── main.lua
│   ├── README.md
│   └── LICENSE
├── mkdir.yazi/
│   ├── main.lua
│   ├── README.md
│   └── LICENSE
└── show-size.yazi/
    ├── main.lua
    ├── README.md
    └── LICENSE
```

## 注意事项

- 所有插件都遵循 yazi 官方插件开发规范
- 插件使用同步执行模式（@sync entry）以确保响应速度
- 每个插件都包含完整的文档和许可证信息
