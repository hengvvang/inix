# Bash 配置模块

根据你的实际风格，已经为你配置好了bash，并使用starship作为命令提示符。

## 功能特性

### ✨ Starship 提示符
- 现代化跨Shell提示符
- 支持Git状态显示
- 显示编程语言版本信息
- 美观的图标和颜色

### 🔧 实用别名
- `ll` - 详细列表 (`ls -alF`)
- `la` - 显示隐藏文件 (`ls -A`)
- `..` - 返回上级目录
- `g` - Git快捷方式
- `nr` - Nix run
- `cat` - 使用 bat 替代
- `tree` - 使用 eza 替代

### 🛠️ 实用函数
- `mkcd <dir>` - 创建目录并进入
- `up [n]` - 快速返回n级父目录
- `ff <pattern>` - 快速搜索文件
- `path` - 显示PATH路径
- `myip` - 获取公网IP

### 📦 集成工具
- 现代化工具: bat, eza, fd, ripgrep, htop
- 开发环境: Node.js (nvm), Rust
- 补全支持: bash-completion
- 历史管理: 10000条历史记录

## 配置方式

当前使用 `homemanager` 方式配置，你也可以选择：
- `homemanager` - 使用 Home Manager 程序模块 (推荐)
- `direct` - 直接文件写入方式
- `external` - 外部文件引用方式

## 使用方法

1. 启动新的bash会话或重新加载配置：
   ```bash
   source ~/.bashrc
   ```

2. 或者直接启动bash：
   ```bash
   bash
   ```

3. 测试配置：
   ```bash
   ./test_bash_config.sh
   ```

## 自定义配置

可以在 `~/.bashrc.local` 中添加个人自定义配置，不会被系统覆盖。

示例：
```bash
# ~/.bashrc.local
export MY_CUSTOM_VAR="value"
alias myalias="command"

# 自定义函数
my_function() {
    echo "Hello from custom function"
}
```

## 故障排除

如果遇到问题，可以：

1. 检查配置文件是否正确生成：
   ```bash
   head ~/.bashrc
   ```

2. 重新构建并应用配置：
   ```bash
   cd /home/hengvvang/nix
   nix build .#homeConfigurations.hengvvang.activationPackage
   ./result/activate
   ```

3. 查看Starship配置：
   ```bash
   cat ~/.config/starship.toml
   ```

享受你的新bash配置！🎉
