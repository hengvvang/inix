
{ config, lib, pkgs, inputs, ... }:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "hyprland") {

        # ========== Hyprland 核心配置 ==========
        # Hyprland 是一个基于 wlroots 的动态平铺 Wayland 合成器
        programs.hyprland = {
            enable = true;                    # 启用 Hyprland 窗口管理器
            xwayland.enable = true;           # 启用 XWayland 支持 (运行 X11 应用)
            withUWSM = true;                  # 启用通用 Wayland 会话管理器
            # package = pkgs.hyprland;          # 使用稳定版本的 Hyprland
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        };

        # ========== 环境变量配置 ==========
        environment.sessionVariables = {
            # 设置当前桌面环境
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_DESKTOP = "Hyprland";
            # 设置默认会话类型为 Wayland
            XDG_SESSION_TYPE = "wayland";
            # Wayland 相关环境变量
            WAYLAND_DISPLAY = "wayland-1";
            GDK_BACKEND = "wayland,x11";
            SDL_VIDEODRIVER = "wayland";
            CLUTTER_BACKEND = "wayland";

            # Qt 应用程序使用 Wayland 后端
            QT_QPA_PLATFORM = "wayland;";
            # 启用 Chromium/Electron 应用的原生 Wayland 支持
            NIXOS_OZONE_WL = "1";
            # Mozilla 应用程序启用 Wayland 支持
            MOZ_ENABLE_WAYLAND = "1";

            # 输入法支持
            QT_IM_MODULE = "fcitx";
            GTK_IM_MODULE = "fcitx";
            XMODIFIERS = "@im=fcitx";

            # ========== Xwayland 缩放配置 ==========
            # GTK 应用程序缩放
            GDK_SCALE = "1.5";
            GDK_DPI_SCALE = "1.0";

            # Qt 应用程序缩放
            QT_SCALE_FACTOR = "1.5";
            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_FONT_DPI = "144";  # 1.5 * 96 = 144

            # X11 光标大小
            XCURSOR_SIZE = "36";  # 1.5 * 24 = 36
            # 禁用硬件光标，解决某些显卡的光标问题
            WLR_NO_HARDWARE_CURSORS = "1";
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

        environment.systemPackages = with pkgs; [
            kitty
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
