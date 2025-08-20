# ============================================================================
# Fish Shell 初始化配置
# ============================================================================
# 此文件在 conf.d 中，会被自动加载
# 用于设置一些基础的 Fish 变量和初始化工作

# 基础 Fish 设置
# ===============

# 自动补全路径设置
set -g fish_complete_path $fish_complete_path ~/.config/fish/completions

# 函数路径设置（如果需要自定义）
# set -g fish_function_path $fish_function_path ~/.config/fish/functions

# 历史记录和自动建议的基础设置
# ==============================

# 历史记录最大条数
set -U fish_history_max 50000

# 忽略以空格开头的命令
set -U fish_history_ignore_space yes

# 启用自动建议
set -U fish_autosuggestion_enabled 1

# 自动建议高亮颜色
set -U fish_autosuggestion_highlight_color 5f5f5f

# 欢迎信息设置
set -U fish_greeting ""

# 键绑定模式设置
set -U fish_key_bindings fish_default_key_bindings

# 初始化检查
# ===========

# 检查重要工具是否安装
function __fish_check_tools
    set -l missing_tools
    
    # 检查现代化工具
    for tool in eza bat fd rg
        if not command -v $tool >/dev/null 2>&1
            set -a missing_tools $tool
        end
    end
    
    # 如果有缺失工具，给出提示
    if test (count $missing_tools) -gt 0
        echo "提示: 以下现代化工具未安装，建议通过 Nix 安装以获得更好体验:"
        for tool in $missing_tools
            echo "  - $tool"
        end
        echo ""
    end
end

# 仅在交互式 shell 中运行检查
if status is-interactive
    __fish_check_tools
end
