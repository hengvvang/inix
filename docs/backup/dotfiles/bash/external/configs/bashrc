# === Bash 配置文件 ===
# 外部文件引用方式

# 如果不是交互式shell，直接返回
case $- in
  *i*) ;;
    *) return;;
esac

# === 历史设置 ===
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=20000

# === Shell 选项 ===
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
shopt -s globstar
shopt -s checkjobs

# === 环境变量 ===
export EDITOR="vim"
export VISUAL="vim"
export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# === 颜色支持 ===
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# === 加载别名 ===
if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

# === 加载函数 ===
if [ -f "$HOME/.bash_functions" ]; then
  source "$HOME/.bash_functions"
fi

# === 键绑定设置 ===
set -o emacs

# === 补全设置 ===
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# === 开发工具集成 ===

# Node.js 版本管理
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Rust 环境
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# === 终端标题设置 ===
case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
  *)
    ;;
esac

# === Starship 提示符 ===
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# 初始化 Starship (如果已安装)
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# === 本地自定义配置 ===
if [ -f "$HOME/.bashrc.local" ]; then
  source "$HOME/.bashrc.local"
fi
