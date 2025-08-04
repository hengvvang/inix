#!/bin/bash

# Ironbar 启动脚本
# 适用于 niri 窗口管理器

# 检查 ironbar 是否已经在运行
if pgrep -f "ironbar" > /dev/null; then
    echo "Ironbar 已经在运行中，重新加载配置..."
    ironbar reload
else
    echo "启动 Ironbar..."
    # 设置日志级别（可选）
    export IRONBAR_LOG=info
    export IRONBAR_FILE_LOG=warn
    
    # 启动 ironbar
    ironbar &
    
    echo "Ironbar 已启动"
fi
