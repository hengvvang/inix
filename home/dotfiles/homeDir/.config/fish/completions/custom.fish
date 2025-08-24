# ============================================================================
# 自定义函数的补全配置
# ============================================================================
# 此文件定义了自定义函数的命令行补全规则

# extract 函数的补全 - 只补全压缩文件
complete -c extract -x -a "(__fish_complete_suffix .tar.bz2 .tar.gz .bz2 .rar .gz .tar .tbz2 .tgz .zip .Z .7z .xz .tar.xz)"

# backup 函数的补全 - 补全所有文件
complete -c backup -x -a "(__fish_complete_path)"

# weather 函数的补全 - 提供常见城市名
complete -c weather -x -a "Beijing Shanghai Guangzhou Shenzhen Hangzhou Nanjing Wuhan Chengdu Xi'an"

# cheat 函数的补全 - 提供常见命令
complete -c cheat -x -a "tar git ssh scp rsync find grep sed awk vim tmux docker kubectl"

# cdl 函数的补全 - 只补全目录
complete -c cdl -x -a "(__fish_complete_directories)"

# fcd 函数的补全 - 只补全目录
complete -c fcd -x -a "(__fish_complete_directories)"

# mkcd 函数的补全 - 补全现有目录路径（用于创建子目录）
complete -c mkcd -x -a "(__fish_complete_directories)"
