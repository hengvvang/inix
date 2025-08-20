# ============================================================================
# 键绑定配置
# ============================================================================
# 此文件定义 Fish Shell 的键盘快捷键绑定
# 文件会被自动加载（通过 conf.d 机制）

# 词汇导航快捷键
# ===============
# Ctrl+Right: 向前跳一个词
bind \e\[1\;5C forward-word

# Ctrl+Left: 向后跳一个词
bind \e\[1\;5D backward-word

# 自动建议快捷键
# ===============
# Ctrl+F: 接受自动建议
bind \cf accept-autosuggestion

# 历史记录搜索快捷键
# ===================
# Ctrl+R: 向后搜索历史记录
bind \cr history-search-backward

# Ctrl+S: 向前搜索历史记录
bind \cs history-search-forward

# 自定义快捷键
# =============
# Alt+L: 清屏
bind \el 'clear; commandline -f repaint'

# Alt+H: 显示帮助
bind \eh 'man (commandline -ct)'

# Alt+E: 编辑当前命令行（在编辑器中）
bind \ee edit_command_buffer

# Ctrl+Alt+E: 编辑当前命令行历史
bind \e\ce 'history merge; edit_command_buffer'

# FZF 集成快捷键（如果安装了 fzf）
# =================================
# Ctrl+T: 文件查找
if command -v fzf >/dev/null 2>&1
    bind \ct 'fzf-file-widget'
end

# Alt+C: 目录跳转
if command -v fzf >/dev/null 2>&1
    bind \ec 'fzf-cd-widget'
end

# 命令行编辑快捷键
# =================
# Ctrl+A: 移动到行首
bind \ca beginning-of-line

# Ctrl+E: 移动到行尾
bind \ce end-of-line

# Ctrl+K: 删除到行尾
bind \ck kill-line

# Ctrl+U: 删除到行首
bind \cu backward-kill-line

# Ctrl+W: 删除前一个词
bind \cw backward-kill-word

# Alt+D: 删除后一个词
bind \ed kill-word

# 特殊功能快捷键
# ===============
# Ctrl+L: 清屏（保持当前命令行）
bind \cl 'clear; commandline -f repaint'

# Alt+.: 插入上一个命令的最后一个参数
bind \e. history-token-search-backward
