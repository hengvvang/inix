{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.yazi = {
    enable = lib.mkEnableOption "Yazi dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "template" ];
      default = "homemanager";
      description = "Yazi 配置方式";
    };

    # Template 方式专用选项
    enableShellIntegration = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否启用 shell 集成";
    };

    managerRatio = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 1 4 3 ];
      description = "管理器面板比例";
    };

    sortBy = lib.mkOption {
      type = lib.types.str;
      default = "alphabetical";
      description = "排序方式";
    };

    sortSensitive = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "大小写敏感排序";
    };

    sortReverse = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "反向排序";
    };

    sortDirFirst = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "目录优先";
    };

    lineMode = lib.mkOption {
      type = lib.types.str;
      default = "none";
      description = "行模式";
    };

    showHidden = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "显示隐藏文件";
    };

    showSymlink = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "显示符号链接";
    };

    scrolloff = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "滚动偏移量";
    };

    tabSize = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "制表符大小";
    };

    previewMaxWidth = lib.mkOption {
      type = lib.types.int;
      default = 600;
      description = "预览最大宽度";
    };

    previewMaxHeight = lib.mkOption {
      type = lib.types.int;
      default = 900;
      description = "预览最大高度";
    };

    editor = lib.mkOption {
      type = lib.types.str;
      default = "nvim";
      description = "默认编辑器";
    };

    fileOpener = lib.mkOption {
      type = lib.types.str;
      default = "xdg-open";
      description = "文件打开器";
    };

    archiveExtractor = lib.mkOption {
      type = lib.types.str;
      default = "unar";
      description = "压缩包解压器";
    };

    mediaPlayer = lib.mkOption {
      type = lib.types.str;
      default = "mpv";
      description = "媒体播放器";
    };

    theme = {
      colors = {
        primary = lib.mkOption {
          type = lib.types.str;
          default = "#7aa2f7";
          description = "主色调";
        };

        secondary = lib.mkOption {
          type = lib.types.str;
          default = "#bb9af7";
          description = "辅助色调";
        };

        success = lib.mkOption {
          type = lib.types.str;
          default = "#9ece6a";
          description = "成功色";
        };

        warning = lib.mkOption {
          type = lib.types.str;
          default = "#e0af68";
          description = "警告色";
        };

        error = lib.mkOption {
          type = lib.types.str;
          default = "#f7768e";
          description = "错误色";
        };

        blue = lib.mkOption {
          type = lib.types.str;
          default = "#7aa2f7";
          description = "蓝色";
        };

        green = lib.mkOption {
          type = lib.types.str;
          default = "#9ece6a";
          description = "绿色";
        };

        yellow = lib.mkOption {
          type = lib.types.str;
          default = "#e0af68";
          description = "黄色";
        };

        red = lib.mkOption {
          type = lib.types.str;
          default = "#f7768e";
          description = "红色";
        };

        magenta = lib.mkOption {
          type = lib.types.str;
          default = "#bb9af7";
          description = "洋红色";
        };

        cyan = lib.mkOption {
          type = lib.types.str;
          default = "#7dcfff";
          description = "青色";
        };

        gray = lib.mkOption {
          type = lib.types.str;
          default = "#565f89";
          description = "灰色";
        };

        darkgray = lib.mkOption {
          type = lib.types.str;
          default = "#414868";
          description = "深灰色";
        };

        tab = {
          active = {
            fg = lib.mkOption {
              type = lib.types.str;
              default = "#1a1b26";
              description = "活动标签前景色";
            };

            bg = lib.mkOption {
              type = lib.types.str;
              default = "#7aa2f7";
              description = "活动标签背景色";
            };
          };

          inactive = {
            fg = lib.mkOption {
              type = lib.types.str;
              default = "#c0caf5";
              description = "非活动标签前景色";
            };

            bg = lib.mkOption {
              type = lib.types.str;
              default = "#1a1b26";
              description = "非活动标签背景色";
            };
          };
        };
      };

      icons = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "图标配置";
      };
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
    ./template.nix
  ];
}
