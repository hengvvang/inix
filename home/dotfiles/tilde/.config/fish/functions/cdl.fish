# ============================================================================
# 目录切换并列出内容函数
# ============================================================================
# 切换到指定目录并自动列出目录内容
# 用法: cdl <目录路径>

function cdl --description "切换目录并列出内容"
    # 检查是否提供了参数
    if test (count $argv) -eq 0
        # 如果没有参数，切换到家目录
        cd ~
    else
        # 切换到指定目录
        cd $argv[1]
    end

    # 如果切换成功，列出目录内容
    if test $status -eq 0
        if command -v eza >/dev/null 2>&1
            eza -la --icons --group-directories-first
        else
            ls -la
        end
    end
end
