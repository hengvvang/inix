{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.mySystem.profiles.stylix;
in
{
  config = lib.mkIf cfg.enable {
    # 启用 Stylix
    stylix.enable = true;

    # 自动启用配置
    stylix.autoEnable = cfg.advanced.autoEnable;

    # 覆盖层支持
    stylix.overlays.enable = cfg.advanced.overlays;

    # 版本检查
    stylix.enableReleaseChecks = cfg.advanced.releaseChecks;

    # 自定义覆盖
    stylix.override = cfg.advanced.override;

    # 色彩方案配置
    stylix.base16Scheme =
      if cfg.colorScheme.mode == "preset" then
        # 使用预设配色方案
        "${pkgs.base16-schemes}/share/themes/${cfg.colorScheme.preset.name}.yaml"

      else if cfg.colorScheme.mode == "image" then
        # 从图片生成配色方案
        null

      else if cfg.colorScheme.mode == "custom" then
        # 使用自定义配色方案
        if cfg.colorScheme.custom.colors != null then
          cfg.colorScheme.custom.colors
        else if cfg.colorScheme.custom.file != null then
          cfg.colorScheme.custom.file
        else
          "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"
      else
        # 默认配色
        "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # 极性配置
    stylix.polarity = cfg.polarity;

    # 壁纸配置
    stylix.image = lib.mkIf (cfg.wallpaper.enable && cfg.wallpaper.image != null) cfg.wallpaper.image;
    stylix.imageScalingMode = cfg.wallpaper.scalingMode;

    # 字体配置
    stylix.fonts = lib.mkIf cfg.fonts.enable {
      serif = {
        name = cfg.fonts.families.serif.name;
        package = cfg.fonts.families.serif.package;
      };
      sansSerif = {
        name = cfg.fonts.families.sansSerif.name;
        package = cfg.fonts.families.sansSerif.package;
      };
      monospace = {
        name = cfg.fonts.families.monospace.name;
        package = cfg.fonts.families.monospace.package;
      };
      emoji = {
        name = cfg.fonts.families.emoji.name;
        package = cfg.fonts.families.emoji.package;
      };
      sizes = {
        applications = cfg.fonts.sizes.applications;
        desktop = cfg.fonts.sizes.desktop;
        popups = cfg.fonts.sizes.popups;
        terminal = cfg.fonts.sizes.terminal;
      };
    };

    # 光标配置
    stylix.cursor = lib.mkIf cfg.cursor.enable {
      name = cfg.cursor.name;
      package = cfg.cursor.package;
      size = cfg.cursor.size;
    };

    # 透明度配置
    stylix.opacity = lib.mkIf cfg.opacity.enable {
      terminal = cfg.opacity.terminal;
      applications = cfg.opacity.applications;
      desktop = cfg.opacity.desktop;
      popups = cfg.opacity.popups;
    };

    # Home Manager 集成配置
    stylix.homeManagerIntegration = {
      autoImport = cfg.homeManagerIntegration.autoImport;
      followSystem = cfg.homeManagerIntegration.followSystem;
    };

    # 系统级目标配置
    stylix.targets = {
      # 系统级应用
      gtk.enable = cfg.targets.gtk.enable;
      qt.enable = cfg.targets.qt.enable;
      qt.platform = cfg.targets.qt.platform;

      # 系统级桌面环境
      gnome.enable = cfg.targets.gnome.enable;

      # 系统级显示管理器
      lightdm.enable = cfg.targets.lightdm.enable;
      lightdm.useWallpaper = cfg.targets.lightdm.useWallpaper;
      regreet.enable = cfg.targets.regreet.enable;
      regreet.useWallpaper = cfg.targets.regreet.useWallpaper;

      # 系统级启动主题
      plymouth.enable = cfg.targets.plymouth.enable;
      plymouth.logo = lib.mkIf (cfg.targets.plymouth.logo != null) cfg.targets.plymouth.logo;
      plymouth.logoAnimated = cfg.targets.plymouth.logoAnimated;

      # 系统级终端
      console.enable = cfg.targets.console.enable;
      kmscon.enable = cfg.targets.kmscon.enable;

      # 系统级浏览器
      chromium.enable = cfg.targets.chromium.enable;

      # 系统级字体包
      font-packages.enable = cfg.targets.fontPackages.enable;

      # 系统级桌面背景
      feh.enable = cfg.targets.feh.enable;

      # 系统级程序
      fish.enable = cfg.targets.fish.enable;
      glance.enable = cfg.targets.glance.enable;
    };
  };
}
