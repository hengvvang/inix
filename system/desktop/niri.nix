
{ config, lib, pkgs, inputs, ... }:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "niri") {

        # ========== Niri 核心配置 ==========
        # Niri 是一个基于 Rust 和 Smithay 的滚动平铺 Wayland 合成器
        programs.niri = {
            enable = true;
            # package = pkgs.niri;
            package = inputs.niri.packages.${pkgs.system}.niri;
        };

        # ========== 显示管理器配置 ==========
        # 使用 GDM 作为显示管理器来启动 Niri 会话
        services.xserver.enable = true;
        services.displayManager.gdm = {
            enable = true;
            wayland = true;                   # 启用 Wayland 支持
        };

        # ========== 系统服务配置 ==========
        # 启用必要的系统服务支持 Niri 桌面环境
        services.dbus.enable = true;         # D-Bus 系统消息总线
        security.polkit.enable = true;       # PolicyKit 权限管理

        environment.sessionVariables = {
            XDG_CURRENT_DESKTOP = "niri";
            XDG_SESSION_DESKTOP = "niri";
            # 设置默认会话类型为 Wayland
            XDG_SESSION_TYPE = "wayland";
            # Wayland 相关环境变量
            WAYLAND_DISPLAY = "wayland-1";
            GDK_BACKEND = "wayland,x11";
            SDL_VIDEODRIVER = "wayland";
            CLUTTER_BACKEND = "wayland";

            # Qt 应用程序使用 Wayland 后端
            QT_QPA_PLATFORM = "wayland";
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
            GDK_SCALE = "1.00";
            GDK_DPI_SCALE = "1.0";

            # Qt 应用程序缩放
            QT_SCALE_FACTOR = "1.00";
            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_FONT_DPI = "144";  # 1.5 * 96 = 144

            # X11 光标大小
            XCURSOR_SIZE = "36";  # 1.5 * 24 = 36
            # 禁用硬件光标，解决某些显卡的光标问题
            WLR_NO_HARDWARE_CURSORS = "1";
        };

        # ========== XDG 桌面门户配置 ==========
        # Niri 推荐使用 GNOME 的桌面门户实现
        xdg.portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
            config = {
                common = { default = [ "gnome" ]; };
                niri = { default = [ "gnome" ]; };
            };
        };

        # 仅包含 Niri 桌面环境运行所需的最基本包
        environment.systemPackages = with pkgs; [
            fuzzel     # default application launcher
            alacritty  # default terminal emulator
        ];
    };
}
