#!/usr/bin/env bash

# Rofi 主启动器脚本
# 智能选择合适的模式启动 Rofi

set -euo pipefail

# 配置变量
ROFI_CONFIG_DIR="${HOME}/.config/rofi"
ROFI_THEME="${ROFI_CONFIG_DIR}/theme.rasi"

# 默认配置
DEFAULT_MODE="drun"
DEFAULT_PROMPT=" 启动器"

# 帮助信息
show_help() {
    cat << EOF
Rofi 启动器 - 智能应用程序启动器

用法: $(basename "$0") [选项] [模式]

模式:
    apps, drun          应用程序启动器（默认）
    run                 运行命令
    window, win         窗口切换器  
    ssh                 SSH 连接
    files, file         文件浏览器
    calc                计算器
    emoji               Emoji 选择器
    combi               组合模式
    power               电源菜单
    network, net        网络管理
    audio               音频设备
    bluetooth, bt       蓝牙设备

选项:
    -h, --help          显示此帮助信息
    -t, --theme THEME   使用指定主题
    -p, --prompt PROMPT 设置提示符
    -l, --lines LINES   设置显示行数
    -w, --width WIDTH   设置窗口宽度
    -c, --config CONFIG 使用指定配置文件
    -d, --dmenu         以 dmenu 模式运行
    -f, --fullscreen    全屏模式
    -i, --case-insensitive 不区分大小写
    -m, --multi-select  多选模式
    -r, --run-command CMD 直接运行命令

示例:
    $(basename "$0")                    # 启动应用程序启动器
    $(basename "$0") window             # 启动窗口切换器
    $(basename "$0") -l 15 calc         # 启动计算器，显示15行
    $(basename "$0") -f drun            # 全屏应用程序启动器
    $(basename "$0") -p "运行: " run    # 自定义提示符的运行模式

环境变量:
    ROFI_CONFIG_DIR     Rofi 配置目录（默认: ~/.config/rofi）
    ROFI_THEME          主题文件路径
    ROFI_TERMINAL       默认终端程序
    ROFI_FILE_MANAGER   默认文件管理器

EOF
}

# 错误处理
error_exit() {
    echo "错误: $1" >&2
    exit 1
}

# 检查依赖
check_dependencies() {
    local deps=("rofi")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            error_exit "未找到依赖程序: $dep"
        fi
    done
}

# 检查主题文件
check_theme() {
    local theme="$1"
    if [[ -n "$theme" && ! -f "$theme" ]]; then
        echo "警告: 主题文件不存在: $theme" >&2
        return 1
    fi
    return 0
}

# 构建 Rofi 命令
build_rofi_command() {
    local mode="$1"
    shift
    local cmd=("rofi" "-show" "$mode")
    
    # 添加其他参数
    cmd+=("$@")
    
    # 添加配置文件
    if [[ -f "${ROFI_CONFIG_DIR}/config.rasi" ]]; then
        cmd+=("-config" "${ROFI_CONFIG_DIR}/config.rasi")
    fi
    
    echo "${cmd[@]}"
}

# 启动特定模式
launch_mode() {
    local mode="$1"
    shift
    local args=("$@")
    
    case "$mode" in
        "apps"|"drun")
            exec rofi -show drun "${args[@]}"
            ;;
        "run")
            exec rofi -show run "${args[@]}"
            ;;
        "window"|"win")
            exec rofi -show window "${args[@]}"
            ;;
        "ssh")
            exec rofi -show ssh "${args[@]}"
            ;;
        "files"|"file")
            exec rofi -show filebrowser "${args[@]}"
            ;;
        "calc")
            if command -v rofi-calc >/dev/null 2>&1; then
                exec rofi-calc "${args[@]}"
            else
                exec rofi -show calc -modi calc -no-show-match -no-sort "${args[@]}"
            fi
            ;;
        "emoji")
            if command -v rofi-emoji >/dev/null 2>&1; then
                exec rofi-emoji "${args[@]}"
            else
                exec rofi -show emoji -modi emoji "${args[@]}"
            fi
            ;;
        "combi")
            exec rofi -show combi -combi-modi "drun,run,window" "${args[@]}"
            ;;
        "power")
            if command -v rofi-power >/dev/null 2>&1; then
                exec rofi-power "${args[@]}"
            else
                error_exit "电源菜单脚本未找到"
            fi
            ;;
        "network"|"net")
            if command -v rofi-network >/dev/null 2>&1; then
                exec rofi-network "${args[@]}"
            else
                error_exit "网络管理脚本未找到"
            fi
            ;;
        "audio")
            if command -v rofi-audio >/dev/null 2>&1; then
                exec rofi-audio "${args[@]}"
            else
                error_exit "音频设备脚本未找到"
            fi
            ;;
        "bluetooth"|"bt")
            if command -v rofi-bluetooth >/dev/null 2>&1; then
                exec rofi-bluetooth "${args[@]}"
            else
                error_exit "蓝牙设备脚本未找到"
            fi
            ;;
        *)
            error_exit "未知模式: $mode"
            ;;
    esac
}

# 主函数
main() {
    local mode="$DEFAULT_MODE"
    local args=()
    local dmenu_mode=false
    
    # 检查依赖
    check_dependencies
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -t|--theme)
                if [[ -n "${2:-}" ]]; then
                    if check_theme "$2"; then
                        args+=("-theme" "$2")
                    fi
                    shift 2
                else
                    error_exit "选项 $1 需要参数"
                fi
                ;;
            -p|--prompt)
                if [[ -n "${2:-}" ]]; then
                    args+=("-p" "$2")
                    shift 2
                else
                    error_exit "选项 $1 需要参数"
                fi
                ;;
            -l|--lines)
                if [[ -n "${2:-}" && "$2" =~ ^[0-9]+$ ]]; then
                    args+=("-lines" "$2")
                    shift 2
                else
                    error_exit "选项 $1 需要数字参数"
                fi
                ;;
            -w|--width)
                if [[ -n "${2:-}" ]]; then
                    args+=("-width" "$2")
                    shift 2
                else
                    error_exit "选项 $1 需要参数"
                fi
                ;;
            -c|--config)
                if [[ -n "${2:-}" && -f "$2" ]]; then
                    args+=("-config" "$2")
                    shift 2
                else
                    error_exit "配置文件不存在: ${2:-}"
                fi
                ;;
            -d|--dmenu)
                dmenu_mode=true
                args+=("-dmenu")
                shift
                ;;
            -f|--fullscreen)
                args+=("-fullscreen")
                shift
                ;;
            -i|--case-insensitive)
                args+=("-case-sensitive" "false")
                shift
                ;;
            -m|--multi-select)
                args+=("-multi-select")
                shift
                ;;
            -r|--run-command)
                if [[ -n "${2:-}" ]]; then
                    exec bash -c "$2"
                else
                    error_exit "选项 $1 需要命令参数"
                fi
                ;;
            -*)
                error_exit "未知选项: $1"
                ;;
            *)
                mode="$1"
                shift
                break
                ;;
        esac
    done
    
    # dmenu 模式处理
    if [[ "$dmenu_mode" == true ]]; then
        exec rofi -dmenu "${args[@]}" "$@"
    fi
    
    # 启动指定模式
    launch_mode "$mode" "${args[@]}" "$@"
}

# 执行主函数
main "$@"
