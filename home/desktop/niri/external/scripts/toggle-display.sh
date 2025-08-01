#!/usr/bin/env bash

# Niri 显示器电源切换脚本

# 获取所有输出设备
outputs=$(niri msg outputs | jq -r '.[].name')

for output in $outputs; do
    # 获取当前输出状态
    current_state=$(niri msg outputs | jq -r ".[] | select(.name == \"$output\") | .logical")
    
    if [ "$current_state" != "null" ]; then
        # 输出当前开启，关闭它
        niri msg action output --name "$output" off
        notify-send "显示器" "已关闭显示器: $output"
    else
        # 输出当前关闭，开启它
        niri msg action output --name "$output" on
        notify-send "显示器" "已开启显示器: $output"
    fi
done
