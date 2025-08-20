# ============================================================================
# 颜色主题配置
# ============================================================================
# 此文件定义 Fish Shell 的颜色主题
# 文件会被自动加载（通过 conf.d 机制）

# Fish Shell 语法高亮颜色设置
# ===========================

# 命令颜色
set -g fish_color_command blue

# 参数颜色
set -g fish_color_param cyan

# 重定向符号颜色
set -g fish_color_redirection yellow

# 注释颜色
set -g fish_color_comment red

# 错误颜色
set -g fish_color_error red --bold

# 转义字符颜色
set -g fish_color_escape cyan

# 操作符颜色
set -g fish_color_operator yellow

# 语句结束符颜色
set -g fish_color_end green

# 引号颜色
set -g fish_color_quote yellow

# 自动建议颜色
set -g fish_color_autosuggestion 555

# 用户名颜色
set -g fish_color_user green

# 主机名颜色
set -g fish_color_host blue

# 有效路径颜色
set -g fish_color_valid_path --underline

# 当前工作目录颜色
set -g fish_color_cwd green

# Root 用户工作目录颜色
set -g fish_color_cwd_root red

# 匹配项颜色
set -g fish_color_match cyan

# 搜索匹配背景色
set -g fish_color_search_match --background=purple

# 选择背景色
set -g fish_color_selection --background=purple

# 取消操作颜色
set -g fish_color_cancel red

# 分页器颜色设置
# ===============
set -g fish_pager_color_completion cyan
set -g fish_pager_color_description yellow
set -g fish_pager_color_prefix blue
set -g fish_pager_color_progress cyan

# 历史记录和自动建议设置
# ======================

# 历史记录最大条数
set -g fish_history_max 50000

# 忽略以空格开头的命令（不记录到历史）
set -g fish_history_ignore_space yes

# 启用自动建议
set -g fish_autosuggestion_enabled 1

# 自动建议高亮颜色
set -g fish_autosuggestion_highlight_color 5f5f5f
