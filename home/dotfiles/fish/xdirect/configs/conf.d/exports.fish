# ============================================================================
# 环境变量配置
# ============================================================================
# 此文件定义 Fish Shell 的环境变量
# 文件会被自动加载（通过 conf.d 机制）

# 编辑器设置
set -gx EDITOR vim
set -gx VISUAL vim

# 浏览器设置
set -gx BROWSER google-chrome

# 终端设置
set -gx TERM xterm-256color

# 语言和编码设置
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# 开发工具环境变量
# ==================

# Go 语言
set -gx GOPATH ~/go
set -gx GOPROXY https://goproxy.cn,direct

# Rust
set -gx CARGO_HOME ~/.cargo

# Node.js
set -gx NPM_CONFIG_PREFIX ~/.npm-global

# Python
set -gx PYTHONDONTWRITEBYTECODE 1
set -gx PIP_REQUIRE_VIRTUALENV true

# 其他工具设置
# =============

# 让 less 支持彩色输出
set -gx LESS "-R"

# fzf 默认选项
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

# ripgrep 配置文件
set -gx RIPGREP_CONFIG_PATH ~/.ripgreprc

# 历史记录设置
set -gx HISTSIZE 50000
set -gx HISTFILESIZE 50000
