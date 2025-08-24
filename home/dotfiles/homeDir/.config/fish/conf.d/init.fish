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
