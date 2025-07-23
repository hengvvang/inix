# ============================================================================
# .zprofile - Zsh 登录 Shell 配置文件
# ============================================================================
# 此文件只在登录 shell 启动时读取，在 .zshrc 之前执行
# 用于设置登录 shell 特有的配置

# 只在登录 shell 中执行
if [[ "$SHLVL" = 1 ]]; then
    # 登录时的欢迎信息
    echo "Welcome to Zsh Shell!"
    echo "Today is $(date '+%A, %B %d, %Y')"
    
    # 检查系统更新（可选）
    # if command -v checkupdates &> /dev/null; then
    #     echo "System updates available: $(checkupdates | wc -l)"
    # fi
fi

# 登录特定的路径添加
# 例如：添加系统特定的路径
if [[ -d "/usr/local/sbin" ]]; then
    path=("/usr/local/sbin" $path)
fi

# 启动 SSH 代理（如果需要）
# if [[ -z "$SSH_AUTH_SOCK" ]]; then
#     eval "$(ssh-agent -s)" > /dev/null
# fi

# 设置 GPG TTY（用于 GPG 签名）
export GPG_TTY=$(tty)

# 清理临时文件（登录时执行一次）
if [[ -d "$HOME/.cache/zsh" ]]; then
    find "$HOME/.cache/zsh" -name "*.tmp" -mtime +7 -delete 2>/dev/null || true
fi
