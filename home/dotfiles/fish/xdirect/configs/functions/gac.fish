# ============================================================================
# Git 快速提交函数
# ============================================================================
# 添加所有更改并提交，支持自定义提交信息
# 用法: gac [提交信息]

function gac --description "Git add all 并 commit"
    # 检查是否在 Git 仓库中
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "错误: 当前目录不是 Git 仓库"
        return 1
    end

    # 添加所有更改
    git add -A

    # 检查是否有更改
    if git diff --cached --quiet
        echo "没有要提交的更改"
        return 0
    end

    # 提交更改
    if test (count $argv) -eq 0
        # 如果没有提供提交信息，使用默认信息
        git commit -m "Auto commit: $(date)"
    else
        # 使用提供的提交信息
        git commit -m "$argv"
    end
end
