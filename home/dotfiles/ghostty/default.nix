{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.ghostty = {
    enable = lib.mkEnableOption "Ghostty dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "template" ];
      default = "direct";
      description = "Ghostty 配置方式";
    };

    # Template 方式专用选项
    fontSize = lib.mkOption {
      type = lib.types.int;
      default = 12;
      description = "字体大小";
    };

    fontFamily = lib.mkOption {
      type = lib.types.str;
      default = "JetBrains Mono";
      description = "字体族";
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "tokyo-night";
      description = "主题名称";
    };

    opacity = lib.mkOption {
      type = lib.types.float;
      default = 0.95;
      description = "透明度 (0.0-1.0)";
    };

    scrollbackLines = lib.mkOption {
      type = lib.types.int;
      default = 10000;
      description = "回滚缓冲区行数";
    };

    cursorStyle = lib.mkOption {
      type = lib.types.str;
      default = "block";
      description = "光标样式";
    };

    mouseHideWhileTyping = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "输入时隐藏鼠标";
    };

    copyOnSelect = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "选择时复制";
    };

    windowDecorations = lib.mkOption {
      type = lib.types.str;
      default = "true";
      description = "窗口装饰";
    };

    shell = lib.mkOption {
      type = lib.types.str;
      default = "fish";
      description = "默认 shell";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
    ./template.nix
  ];
}
