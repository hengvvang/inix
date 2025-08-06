# 示例：在用户配置中添加自定义包

# 方法1：直接添加到用户的 laptop.nix 配置中
# 在 /home/hengvvang/config.d/users/hengvvang/laptop.nix 中添加：

{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.host == "laptop") {
    home.packages = with pkgs; [
      # 其他包...
      raycast-linux       # Linux 版本的 Raycast
      sherlock-launcher    # 更新版本的 Sherlock Launcher
    ];

    # 可选：为 Sherlock Launcher 创建快捷键绑定
    # 例如，对于使用 Hyprland 的情况：
    # wayland.windowManager.hyprland.settings = {
    #   bind = [
    #     "SUPER, SPACE, exec, sherlock"
    #   ];
    # };

    # 对于使用 i3/sway 的情况：
    # wayland.windowManager.sway.config.keybindings = {
    #   "Mod4+space" = "exec sherlock";
    # };
  };
}

# 方法2：在系统级别添加（在 hosts/laptop/default.nix 中）

{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # 其他系统包...
    raycast-linux
  ];
}

# 方法3：为所有架构的用户添加（修改 flake.nix 中的 makeCommonHomeModules）

makeCommonHomeModules = arch: [
  {
    home.packages = [
      zen-browser.packages.${arch}.twilight
      # 添加自定义包，会在所有用户配置中可用
      pkgsFor.${arch}.raycast-linux
    ];
  }
];
