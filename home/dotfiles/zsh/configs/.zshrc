# ============================================================================
# .zshrc - Zsh 交互式 Shell 配置文件
# ============================================================================
# 此文件只在交互式 shell 启动时读取
# 包含别名、函数、键绑定、补全等交互式功能

# 只在交互式 shell 中执行
[[ $- != *i* ]] && return

# Zsh 选项设置
# =============

# 历史记录选项
setopt SHARE_HISTORY              # 在多个 zsh 会话间共享历史
setopt HIST_VERIFY                # 历史展开时需要确认
setopt HIST_IGNORE_ALL_DUPS       # 忽略所有重复的历史记录
setopt HIST_IGNORE_SPACE          # 忽略以空格开头的命令
setopt HIST_FIND_NO_DUPS          # 搜索历史时不显示重复项
setopt HIST_SAVE_NO_DUPS          # 保存历史时不保存重复项
setopt HIST_REDUCE_BLANKS         # 删除多余的空白字符
setopt APPEND_HISTORY             # 追加到历史文件而不是覆盖
setopt INC_APPEND_HISTORY         # 立即追加到历史文件

# 目录导航选项
setopt AUTO_CD                    # 直接输入目录名即可切换
setopt AUTO_PUSHD                 # 自动将目录压入堆栈
setopt PUSHD_IGNORE_DUPS          # 忽略重复的目录
setopt PUSHD_SILENT               # 静默推送目录到堆栈

# 补全选项
setopt COMPLETE_IN_WORD           # 在单词中间也能补全
setopt ALWAYS_TO_END              # 补全后光标移到词尾
setopt AUTO_MENU                  # 自动使用菜单补全
setopt AUTO_LIST                  # 自动列出选择

# 通配符选项
setopt EXTENDED_GLOB              # 启用扩展通配符
setopt GLOB_DOTS                  # 通配符匹配点文件

# 其他选项
setopt CORRECT                    # 拼写纠正命令
setopt NO_BEEP                    # 禁用蜂鸣声
setopt INTERACTIVE_COMMENTS       # 允许交互式注释
setopt PROMPT_SUBST               # 启用提示符参数展开

# 历史记录设置
HISTSIZE=50000
SAVEHIST=50000

# 自动补全初始化
autoload -Uz compinit && compinit

# 补全样式设置
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:descriptions' format '%B%d%b'

# 别名设置
# =========

# 基础文件操作
if command -v eza &> /dev/null; then
    alias ll='eza -la --icons --group-directories-first'
    alias la='eza -la --icons'
    alias ls='eza --icons --group-directories-first'
    alias l='eza -l --icons'
    alias tree='eza --tree --icons'
else
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

# 目录导航
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 现代工具替换
command -v bat &> /dev/null && alias cat='bat --paging=never'
command -v fd &> /dev/null && alias find='fd'
command -v rg &> /dev/null && alias grep='rg --color=auto'
command -v dust &> /dev/null && alias du='dust'
command -v btop &> /dev/null && alias top='btop'

# Git 别名
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# 系统别名
alias c='clear'
alias h='history'
alias reload='source $ZDOTDIR/.zshrc'

# 自定义函数
# ===========

# 创建目录并进入
mkcd() {
    [[ $# -eq 0 ]] && { echo "用法: mkcd <目录>"; return 1; }
    mkdir -p "$1" && cd "$1"
}

# 智能解压
extract() {
    [[ $# -eq 0 ]] && { echo "用法: extract <文件>"; return 1; }
    [[ ! -f "$1" ]] && { echo "文件不存在: $1"; return 1; }
    
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.7z)      7z x "$1" ;;
        *) echo "不支持的格式: $1"; return 1 ;;
    esac
}

# 备份文件
backup() {
    [[ $# -eq 0 ]] && { echo "用法: backup <文件>"; return 1; }
    [[ ! -f "$1" ]] && { echo "文件不存在: $1"; return 1; }
    cp "$1" "${1}.backup.$(date +%Y%m%d_%H%M%S)"
}

# 键绑定设置
# ===========
bindkey -e  # Emacs 模式

# 基础编辑
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word

# 词汇导航
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# 历史搜索
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^R' history-incremental-search-backward

# 提示符设置
# ===========
autoload -U colors && colors

# Git 信息函数
git_prompt_info() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n "$branch" ]] && echo " %{$fg[yellow]%}($branch)%{$reset_color%}"
}

# 设置提示符
PROMPT='%{$fg[cyan]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)
%# '

# 工具初始化
# ===========

# Starship 提示符
command -v starship &> /dev/null && eval "$(starship init zsh)"

# Zoxide 目录跳转
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# FZF 模糊查找
if command -v fzf &> /dev/null; then
    source <(fzf --zsh) 2>/dev/null || true
fi
