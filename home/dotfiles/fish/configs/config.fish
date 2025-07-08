# Fish Shell 配置文件 - 外部文件方式

# 禁用欢迎信息
set -g fish_greeting ""

# 环境变量
set -gx EDITOR vim
set -gx BROWSER google-chrome
set -gx TERM xterm-256color
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# 路径设置
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin
fish_add_path ~/.npm-global/bin

# 基础别名
alias ll='eza -la --icons --group-directories-first'
alias la='eza -la --icons'
alias ls='eza --icons --group-directories-first'
alias l='eza -l --icons'
alias tree='eza --tree --icons'
alias grep='rg --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# 现代工具别名
alias cat='bat --paging=never'
alias less='bat --paging=always'
alias find='fd'
alias du='dust'
alias df='duf'
alias ps='procs'
alias top='btop'
alias htop='btop'
alias ping='gping'

# Git 别名
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
alias c='clear'
alias h='history'
alias j='jobs'
alias x='exit'
alias q='exit'
alias reload='source ~/.config/fish/config.fish'

# 文件操作别名
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# 网络工具
alias myip='curl -s https://ipinfo.io/json | jq -r ".ip"'
alias localip='ip route get 1.1.1.1 | grep -oP "src \K\S+"'
alias ports='netstat -tuln'

# 系统监控
alias cpu='top -p $(pgrep -d"," -f ".*")'
alias mem='free -h'
alias disk='df -h'

# 自定义函数
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "不支持的文件类型: $argv[1]"
        end
    else
        echo "文件不存在: $argv[1]"
    end
end

function backup
    cp $argv[1] $argv[1].backup.(date +%Y%m%d_%H%M%S)
end

function weather
    curl -s "wttr.in/$argv[1]?format=3"
end

function cheat
    curl -s "cheat.sh/$argv[1]"
end

# 快速目录跳转
function cdl
    cd $argv[1]; and ll
end

# 快速git commit
function gac
    git add -A; and git commit -m "$argv[1]"
end

# 快速查找并编辑文件
function fe
    set -l file (fd . | fzf --preview 'bat --color=always {}')
    if test -n "$file"
        $EDITOR $file
    end
end

# 快速查找并进入目录
function fcd
    set -l dir (fd -t d | fzf --preview 'ls -la {}')
    if test -n "$dir"
        cd $dir
    end
end

# 键绑定 - 更符合人体工程学
bind \e\[1\;5C forward-word
bind \e\[1\;5D backward-word
bind \cf accept-autosuggestion
bind \cr history-search-backward
bind \cs history-search-forward

# 初始化工具
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
    alias cd='z'
end

if command -v starship >/dev/null 2>&1
    starship init fish | source
end

if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
end

# 自动补全增强
set -g fish_complete_path $fish_complete_path ~/.config/fish/completions

# 颜色设置
set -g fish_color_command blue
set -g fish_color_param cyan
set -g fish_color_redirection yellow
set -g fish_color_comment red
set -g fish_color_error red --bold
set -g fish_color_escape cyan
set -g fish_color_operator yellow
set -g fish_color_end green
set -g fish_color_quote yellow
set -g fish_color_autosuggestion 555
set -g fish_color_user green
set -g fish_color_host blue
set -g fish_color_valid_path --underline
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_match cyan
set -g fish_color_search_match --background=purple
set -g fish_color_selection --background=purple
set -g fish_color_cancel red

# 历史记录设置
set -g fish_history_max 50000
set -g fish_history_ignore_space yes

# 自动建议设置
set -g fish_autosuggestion_enabled 1
set -g fish_autosuggestion_highlight_color 5f5f5f

# 欢迎信息（可选）
function fish_greeting
    echo
    echo "🐟 Welcome to Fish Shell! 🐟"
    echo "Today is" (date +"%A, %B %d, %Y")
    echo
end

# 退出时的清理
function fish_exit
    clear
end
