# ============================================================================
# .zlogin - Zsh 登录后配置文件
# ============================================================================
# 此文件在登录 shell 启动时读取，在 .zshrc 之后执行
# 用于需要在所有初始化完成后执行的命令

# 显示系统信息（可选）
if command -v neofetch &> /dev/null; then
    neofetch
elif command -v fastfetch &> /dev/null; then
    fastfetch
else
    # 简单的系统信息显示
    echo "System: $(uname -s) $(uname -r)"
    echo "Shell: $SHELL"
    echo "Zsh version: $ZSH_VERSION"
fi

# 检查邮件（如果有邮件系统）
# if [[ -s "$MAIL" ]]; then
#     echo "You have mail."
# fi

# 显示最后登录信息
# last -1 $USER 2>/dev/null | head -1

# 清理旧的历史文件（保留最近的）
if [[ -f "$HISTFILE" ]] && [[ $(wc -l < "$HISTFILE") -gt 100000 ]]; then
    tail -50000 "$HISTFILE" > "${HISTFILE}.tmp" && mv "${HISTFILE}.tmp" "$HISTFILE"
fi
