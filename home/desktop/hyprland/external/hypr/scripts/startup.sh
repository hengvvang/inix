#!/usr/bin/env bash

# ========================================
# Hyprland 启动脚本
# ========================================

# 等待 Hyprland 完全启动
sleep 1

# 启动系统代理
/usr/lib/polkit-kde-authentication-agent-1 &

# 启动网络管理器托盘
nm-applet --indicator &

# 启动蓝牙管理器
blueman-applet &

# 启动输入法
fcitx5 &

# 设置 GTK 主题
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# 启动自动挂载
udisks2 &

# 启动 GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# 设置鼠标指针主题
hyprctl setcursor "Adwaita" 24

# 启动壁纸守护进程
hyprpaper &

# 启动状态栏
waybar &

# 启动通知守护进程
dunst &

# 启动空闲管理
hypridle &

# 初始化剪贴板历史
cliphist wipe
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

# 启动 XDG 桌面门户
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal &

echo "Hyprland startup script completed"
