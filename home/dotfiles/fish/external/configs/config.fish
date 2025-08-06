# ============================================================================
# Fish Shell 主配置文件
# ============================================================================
# 用于外部文件配置方式，通过 Home Manager 的 external 方法管理
# 
# 配置结构：
# ~/.config/fish/
# ├── config.fish           # 主配置文件（本文件）
# ├── functions/             # 自定义函数目录
# ├── completions/           # 自定义补全目录
# ├── conf.d/               # 自动加载的配置片段
# │   ├── aliases.fish      # 别名配置
# │   ├── exports.fish      # 环境变量配置
# │   ├── colors.fish       # 颜色主题配置
# │   └── keybindings.fish  # 键绑定配置
# └── fish_variables        # Fish 变量存储（自动生成）
# ============================================================================

# 禁用默认欢迎信息
set -g fish_greeting ""

# 加载配置模块
# Fish 会自动加载 conf.d/ 目录下的所有 .fish 文件
# 这里只需要确保基础设置正确

# 基础路径设置
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin
fish_add_path ~/.npm-global/bin

# 工具初始化
# =============

# Zoxide (智能目录跳转)
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
    alias cd='z'
end

# Starship (现代化提示符)
if command -v starship >/dev/null 2>&1
    starship init fish | source
end

# Direnv (目录环境变量管理)
# 注意：direnv 集成已在 develop/devenv 模块中统一管理
# 避免重复初始化

# 自定义欢迎函数
function fish_greeting
    # 可以在这里添加自定义的欢迎信息
    # 当前设置为空，使用 set -g fish_greeting ""
end

# 退出清理函数
function fish_exit
    # 退出时执行清理操作
    clear
end
