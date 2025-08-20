# ============================================================================
# 文件解压函数
# ============================================================================
# 智能解压各种格式的压缩文件
# 用法: extract <文件名>

function extract --description "智能解压各种格式的压缩文件"
    # 检查是否提供了参数
    if test (count $argv) -eq 0
        echo "用法: extract <文件名>"
        echo "支持的格式: .tar.bz2, .tar.gz, .bz2, .rar, .gz, .tar, .tbz2, .tgz, .zip, .Z, .7z"
        return 1
    end

    # 检查文件是否存在
    if not test -f $argv[1]
        echo "错误: 文件 '$argv[1]' 不存在"
        return 1
    end

    # 根据文件扩展名选择解压方法
    switch $argv[1]
        case '*.tar.bz2'
            tar xjf $argv[1]
        case '*.tar.gz'
            tar xzf $argv[1]
        case '*.bz2'
            bunzip2 $argv[1]
        case '*.rar'
            unrar x $argv[1]
        case '*.gz'
            gunzip $argv[1]
        case '*.tar'
            tar xf $argv[1]
        case '*.tbz2'
            tar xjf $argv[1]
        case '*.tgz'
            tar xzf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.Z'
            uncompress $argv[1]
        case '*.7z'
            7z x $argv[1]
        case '*.xz'
            unxz $argv[1]
        case '*.tar.xz'
            tar xJf $argv[1]
        case '*'
            echo "错误: 不支持的文件格式 '$argv[1]'"
            echo "支持的格式: .tar.bz2, .tar.gz, .bz2, .rar, .gz, .tar, .tbz2, .tgz, .zip, .Z, .7z, .xz, .tar.xz"
            return 1
    end

    echo "解压完成: $argv[1]"
end
