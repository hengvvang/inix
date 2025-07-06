# Fish Shell 配置文件 - 外部文件方式

# 禁用欢迎信息
set -g fish_greeting ""

# 环境变量
set -gx EDITOR vim
set -gx BROWSER google-chrome
set -gx TERM xterm-256color

# 路径设置
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

# 别名
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git 别名
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# 现代工具别名
alias cat='bat'
alias ls='eza --icons'
alias tree='eza --tree'
alias find='fd'
alias grep='rg'
alias du='dust'
alias df='duf'
alias ps='procs'
alias top='btop'

# 键绑定
bind \e\[1\;5C forward-word
bind \e\[1\;5D backward-word
