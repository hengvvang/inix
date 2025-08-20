# Yazi 配置说明

## 配置文件结构

```
~/.config/yazi/
├── init.lua          # 初始化脚本
├── yazi.toml         # 主配置文件
├── keymap.toml       # 按键绑定
├── theme.toml        # 主题配置
├── plugins/          # 插件目录
│   ├── README.md
│   ├── smart-enter.yazi/
│   ├── mkdir.yazi/
│   └── show-size.yazi/
└── flavors/          # 主题风格目录
    ├── rose-pine.yazi/
    ├── catppuccin-*.yazi/
    └── ...
```

## 插件使用

查看 `plugins/README.md` 了解如何在 `keymap.toml` 中配置插件快捷键。

## 主题

所有主题都放在 `flavors/` 目录中，可以在 `theme.toml` 中切换使用。
