# ============================================================================
# 文件备份函数
# ============================================================================
# 创建文件的时间戳备份
# 用法: backup <文件路径>

function backup --description "创建文件的时间戳备份"
    # 检查是否提供了参数
    if test (count $argv) -eq 0
        echo "用法: backup <文件路径>"
        return 1
    end

    # 检查文件是否存在
    if not test -f $argv[1]
        echo "错误: 文件 '$argv[1]' 不存在"
        return 1
    end

    # 生成时间戳
    set timestamp (date +%Y%m%d_%H%M%S)
    set backup_file "$argv[1].backup.$timestamp"

    # 创建备份
    if cp $argv[1] $backup_file
        echo "备份完成: $backup_file"
    else
        echo "错误: 无法创建备份"
        return 1
    end
end
