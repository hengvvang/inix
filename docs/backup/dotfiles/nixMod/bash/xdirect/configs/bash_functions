# === Bash 函数定义 ===

# 创建目录并进入
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# 提取各种压缩文件
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *.xz)        unxz "$1"        ;;
      *.lzma)      unlzma "$1"      ;;
      *)           echo "不支持的文件格式: '$1'" ;;
    esac
  else
    echo "文件不存在: '$1'"
  fi
}

# 快速搜索文件
ff() {
  find . -type f -iname "*$1*" 2>/dev/null
}

# 快速搜索目录
fd() {
  find . -type d -iname "*$1*" 2>/dev/null
}

# 显示路径中的目录
path() {
  echo "$PATH" | tr ':' '\n' | nl
}

# 快速返回父目录
up() {
  local d=""
  local limit="$1"
  
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi
  
  for ((i=1; i<=limit; i++)); do
    d="../$d"
  done
  
  if [ "$d" != "" ]; then
    cd "$d" || return
  fi
}

# 获取公网IP
myip() {
  curl -s ifconfig.me
}

# 快速启动HTTP服务器
server() {
  local port="${1:-8000}"
  echo "启动HTTP服务器在端口 $port"
  python3 -m http.server "$port"
}

# 显示目录大小
dirsize() {
  du -sh "${1:-.}" | sort -hr
}

# 快速备份文件
backup() {
  cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# 查找并终止进程
killp() {
  ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# 显示颜色代码
colors() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i
    if ! (( ($i + 1 ) % 8 )); then
      echo
    fi
  done
}

# 快速创建并编辑文件
touchedit() {
  touch "$1" && "$EDITOR" "$1"
}
