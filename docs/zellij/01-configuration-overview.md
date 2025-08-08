# Zellij 配置概览

Zellij 使用 [KDL (KuneForm Document Language)](https://kdl.dev/) 作为其配置语言，这是一种人类友好的配置格式。

## 配置文件位置

### 查找顺序

Zellij 按以下顺序查找配置文件 `config.kdl`：

1. `--config-dir` 命令行标志指定的目录
2. `ZELLIJ_CONFIG_DIR` 环境变量指定的目录
3. `$HOME/.config/zellij` (主配置目录)
4. 默认系统位置:
   - Linux: `/home/alice/.config/zellij`
   - macOS: `/Users/Alice/Library/Application Support/org.Zellij-Contributors.Zellij`
5. 系统配置位置: `/etc/zellij`

### 快速开始

```bash
# 创建配置目录
mkdir ~/.config/zellij

# 生成默认配置文件
zellij setup --dump-config > ~/.config/zellij/config.kdl
```

### 指定配置文件

```bash
# 使用特定配置文件
zellij --config /path/to/config.kdl

# 或使用环境变量
export ZELLIJ_CONFIG_FILE=/path/to/config.kdl
zellij

# 启动时不加载任何配置
zellij options --clean
```

## 配置文件结构

Zellij 配置文件主要包含以下几个部分：

- **基本选项** (Options) - 全局行为设置
- **键绑定** (Keybinds) - 按键映射配置
- **主题** (Themes) - 颜色主题定义
- **插件** (Plugins) - 插件别名配置
- **布局** (Layouts) - 会话布局定义

## 实时配置更新

Zellij 会主动监视配置文件的更改。大多数配置项会立即生效，无需重启会话。需要重启的配置项会在相应的文档中特别说明。

## 配置验证

使用以下命令检查配置文件位置和有效性：

```bash
zellij setup --check
```

这将显示 Zellij 正在使用的配置目录和文件位置，以及配置是否有效。
