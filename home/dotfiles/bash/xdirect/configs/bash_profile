# === Bash Profile 配置 ===
# 外部文件引用方式

# 设置默认权限
umask 022

# 启动SSH代理
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null 2>&1
fi

# 加载 .bashrc
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi
