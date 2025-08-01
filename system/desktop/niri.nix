
{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.mySystem.desktop.enable && config.mySystem.desktop.preset == "niri") {

        # ========== Niri 核心配置 ==========
        # Niri 是一个基于 Rust 和 Smithay 的滚动平铺 Wayland 合成器
        programs.niri = {
            enable = true;                    # 启用 Niri 窗口管理器
            package = pkgs.niri;              # 使用稳定版本的 Niri
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

        # ========== 环境变量配置 ==========
        # 针对 Wayland 环境优化应用程序兼容性
        environment.sessionVariables = {
            # 启用 Chromium/Electron 应用的原生 Wayland 支持
            NIXOS_OZONE_WL = "1";
            
            # Qt 应用程序使用 Wayland 后端
            QT_QPA_PLATFORM = "wayland";
            
            # Mozilla 应用程序启用 Wayland 支持
            MOZ_ENABLE_WAYLAND = "1";
            
            # 设置默认会话类型为 Wayland
            XDG_SESSION_TYPE = "wayland";
            
            # 设置当前桌面环境
            XDG_CURRENT_DESKTOP = "niri";
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
    };
}
