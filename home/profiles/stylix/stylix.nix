{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.myHome.profiles.stylix;
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

    # 图标主题配置
    stylix.icons = lib.mkIf cfg.icons.enable {
      enable = true;
      package = cfg.icons.package;
      light = cfg.icons.light;
      dark = cfg.icons.dark;
    };

    # 应用目标配置
    stylix.targets = {
      # 桌面环境
      gtk.enable = cfg.targets.gtk.enable;
      gtk.flatpakSupport.enable = cfg.targets.gtk.flatpak;
      gtk.extraCss = cfg.targets.gtk.extraCss;

      # 终端
      alacritty.enable = cfg.targets.alacritty.enable;
      kitty.enable = cfg.targets.kitty.enable;
      ghostty.enable = cfg.targets.ghostty.enable;
      foot.enable = cfg.targets.foot.enable;
      wezterm.enable = cfg.targets.wezterm.enable;

      # 编辑器
      vim.enable = cfg.targets.vim.enable;
      emacs.enable = cfg.targets.emacs.enable;
      vscode.enable = cfg.targets.vscode.enable;
      zed.enable = cfg.targets.zed.enable;

      # 浏览器
      firefox.enable = cfg.targets.firefox.enable;
      qutebrowser.enable = cfg.targets.qutebrowser.enable;

      # 媒体
      mpv.enable = cfg.targets.mpv.enable;

      # 系统工具
      btop.enable = cfg.targets.btop.enable;
      rofi.enable = cfg.targets.rofi.enable;
      dunst.enable = cfg.targets.dunst.enable;
      waybar.enable = cfg.targets.waybar.enable;
      swaync.enable = cfg.targets.swaync.enable;

      # 文件管理器
      yazi.enable = cfg.targets.yazi.enable;

      # 终端多路复用器
      tmux.enable = cfg.targets.tmux.enable;
      zellij.enable = cfg.targets.zellij.enable;
    };
  };
}
