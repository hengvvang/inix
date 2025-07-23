# ============================================================================
# .zshenv - Zsh 环境变量配置文件
# ============================================================================
# 此文件在所有 Zsh shell 启动时都会被读取（交互式和非交互式）
# 应该只包含必要的环境变量设置

# XDG 基础目录规范
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Zsh 配置目录
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# 确保 ZDOTDIR 存在
[[ ! -d "$ZDOTDIR" ]] && mkdir -p "$ZDOTDIR"

# 基础环境变量
export EDITOR=vim
export VISUAL=vim
export BROWSER=google-chrome
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# 路径设置
typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.npm-global/bin"
    $path
)

# 开发工具环境变量
export GOPATH="$HOME/go"
export GOPROXY="https://goproxy.cn,direct"
export CARGO_HOME="$HOME/.cargo"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PYTHONDONTWRITEBYTECODE=1

# 历史记录文件位置
export HISTFILE="$ZDOTDIR/.zsh_history"
