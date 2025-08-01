
{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "hyprland") {

        # ========== Hyprland 核心配置 ==========
        # Hyprland 是一个基于 wlroots 的动态平铺 Wayland 合成器
        # 提供现代化的窗口管理和动画效果
        programs.hyprland = {
            enable = true;                    # 启用 Hyprland 窗口管理器
            xwayland.enable = true;           # 启用 XWayland 支持 (运行 X11 应用)
            withUWSM = true;                  # 启用通用 Wayland 会话管理器
            package = pkgs.hyprland;          # 使用稳定版本的 Hyprland
        };

        # ========== 环境变量配置 ==========
        # 针对 Wayland 环境优化应用程序兼容性
        environment.sessionVariables = {
            # 启用 Chromium/Electron 应用的原生 Wayland 支持
            NIXOS_OZONE_WL = "1";
            
            # 禁用硬件光标，解决某些显卡的光标问题
            WLR_NO_HARDWARE_CURSORS = "1";
            
            # Qt 应用程序使用 Wayland 后端
            QT_QPA_PLATFORM = "wayland";
            
            # Mozilla 应用程序启用 Wayland 支持
            MOZ_ENABLE_WAYLAND = "1";
            
            # 设置默认会话类型为 Wayland
            XDG_SESSION_TYPE = "wayland";
            
            # 设置当前桌面环境
            XDG_CURRENT_DESKTOP = "Hyprland";
        };

        # ========== 安全和会话管理服务 ==========
        # Hyprlock - Hyprland 专用的屏幕锁定程序
        programs.hyprlock = {
            enable = true;                    # 启用屏幕锁定功能
        };

        # Hypridle - Hyprland 的空闲管理守护进程
        # 自动管理屏幕亮度、锁屏、待机等功能
        services.hypridle = {
            enable = true;                    # 启用空闲管理
        };

        # ========== 桌面门户服务 ==========
        # 为 Flatpak 应用和其他沙盒应用提供桌面集成
        xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                # Hyprland 专用门户，处理截图、屏幕共享等功能
                xdg-desktop-portal-hyprland
                # GTK 门户，提供文件选择器等 GTK 集成
                xdg-desktop-portal-gtk
            ];
            config = {
                common.default = "*";
                hyprland.default = [
                    "hyprland"                # 优先使用 Hyprland 门户
                    "gtk"                     # 备用 GTK 门户
                ];
            };
        };

        # ========== 系统级软件包 ==========
        # 仅包含 Hyprland 桌面环境运行所需的最基本包
        environment.systemPackages = with pkgs; [
            # ===== Hyprland 核心 =====
            hyprland          # Hyprland 窗口管理器（必需）
            
            # ===== 基础 Wayland 工具 =====
            xdg-utils         # XDG 规范工具（必需）
        ];

        # ========== 显示管理器配置 ==========
        # 使用 GDM 作为显示管理器启动 Hyprland 会话
        services.xserver.enable = true;
        services.displayManager.gdm = {
            enable = true;
            wayland = true;           # 启用 Wayland 支持
        };

        # ========== 系统服务配置 ==========
        # 启用必要的系统服务支持 Hyprland 桌面环境

        # GNOME Keyring - 密码和密钥管理
        services.gnome.gnome-keyring.enable = true;

        # PolicyKit - 权限管理服务 (Wayland 窗口管理器必需)
        security.polkit.enable = true;

        # D-Bus - 系统消息总线 (桌面应用通信必需)
        services.dbus.enable = true;

        # GVfs - 虚拟文件系统，支持网络位置和外部设备
        services.gvfs.enable = true;

        # UDISKS2 - 磁盘管理服务，支持自动挂载
        services.udisks2.enable = true;

        # ========== 硬件支持 ==========
        # 启用 Wayland 相关的硬件加速
        hardware.graphics = {
            enable = true;
            enable32Bit = true;           # 32位应用支持
        };
    };
}
