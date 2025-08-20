# ============================================================================
# 模糊查找并编辑文件函数
# ============================================================================
# 使用 fzf 和 fd 查找文件并在编辑器中打开
# 用法: fe [搜索路径]

function fe --description "模糊查找并编辑文件"
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

    # 使用 fzf 选择文件
    set selected_file (fd . $search_path | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' --preview-window=right:60%)

    # 如果选择了文件，用编辑器打开
    if test -n "$selected_file"
        $EDITOR $selected_file
    end
end
