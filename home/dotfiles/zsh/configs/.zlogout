# ============================================================================
# .zlogout - Zsh 退出时配置文件
# ============================================================================
# 此文件在登录 shell 退出时执行
# 用于清理工作和保存状态

# 清理临时文件
if [[ -d "$HOME/.cache/zsh" ]]; then
    find "$HOME/.cache/zsh" -name "*.tmp" -delete 2>/dev/null || true
fi

# 保存重要的会话信息
if [[ -n "$ZDOTDIR" ]] && [[ -d "$ZDOTDIR" ]]; then
    # 保存当前目录到文件（下次登录时可以恢复）
    echo "$(pwd)" > "$ZDOTDIR/.last_dir" 2>/dev/null || true
    
    # 压缩历史文件（如果太大）
    if [[ -f "$HISTFILE" ]] && [[ $(stat -f%z "$HISTFILE" 2>/dev/null || stat -c%s "$HISTFILE" 2>/dev/null || echo 0) -gt 1048576 ]]; then
        gzip -f "$HISTFILE" 2>/dev/null || true
    fi
fi

# 终止后台作业（可选）
# jobs -p | xargs kill 2>/dev/null || true

# 清屏（可选）
clear
