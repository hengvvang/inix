# ============================================================================
# 别名配置
# ============================================================================
# 此文件定义 Fish Shell 的别名
# 文件会被自动加载（通过 conf.d 机制）

# 基础文件操作别名
# ================
alias ll='eza -la --icons --group-directories-first'
alias la='eza -la --icons'
alias ls='eza --icons --group-directories-first'
alias l='eza -l --icons'
alias tree='eza --tree --icons'

# 目录导航别名
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# 现代工具替换传统命令
# ====================
alias cat='bat --paging=never'
alias less='bat --paging=always'
alias find='fd'
alias grep='rg --color=auto'
alias du='dust'
alias df='duf'
alias ps='procs'
alias top='btop'
alias htop='btop'
alias ping='gping'

# Git 相关别名
# =============
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph'
alias gla='git log --oneline --graph --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias gst='git stash'
alias gstp='git stash pop'

# 系统相关别名
# =============
alias c='clear'
alias h='history'
alias j='jobs'
alias x='exit'
alias q='exit'
alias reload='source ~/.config/fish/config.fish'

# 安全的文件操作
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# 网络工具别名
# =============
alias myip='curl -s https://ipinfo.io/json | jq -r ".ip"'
alias localip='ip route get 1.1.1.1 | grep -oP "src \K\S+"'
alias ports='netstat -tuln'

# 系统监控别名
# =============
alias cpu='top -p $(pgrep -d"," -f ".*")'
alias mem='free -h'
alias disk='df -h'

# 开发相关别名
# =============
alias py='python'
alias py3='python3'
alias pip='pip3'
alias node='node'
alias npm='npm'
alias yarn='yarn'

# Docker 相关别名（如果使用 Docker）
# ==================================
# alias d='docker'
# alias dc='docker-compose'
# alias dps='docker ps'
# alias di='docker images'
# alias drm='docker rm'
# alias drmi='docker rmi'
