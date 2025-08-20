# ============================================================================
# 模糊查找并进入目录函数
# ============================================================================
# 使用 fzf 和 fd 查找目录并进入
# 用法: fcd [搜索路径]

function fcd --description "模糊查找并进入目录"
    # 检查是否安装了必要工具
    if not command -v fzf >/dev/null 2>&1
        echo "错误: 需要安装 fzf"
        return 1
    end

    if not command -v fd >/dev/null 2>&1
        echo "错误: 需要安装 fd"
        return 1
    end

    # 设置搜索路径
    set search_path "."
    if test (count $argv) -gt 0
        set search_path $argv[1]
    end

    # 使用 fzf 选择目录
    set selected_dir (fd -t d . $search_path | fzf --preview 'eza -la --icons --group-directories-first {}' --preview-window=right:60%)

    # 如果选择了目录，进入该目录
    if test -n "$selected_dir"
        cd $selected_dir
        echo "进入目录: "(pwd)
        # 列出目录内容
        if command -v eza >/dev/null 2>&1
            eza -la --icons --group-directories-first
        else
            ls -la
        end
    end
end
