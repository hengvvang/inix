{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "external") {

    home.packages = lib.optionals config.myHome.dotfiles.rio.packageEnable (with pkgs; [ rio ]);

    home.file.".config/rio/config.toml".source = ./configs/config.toml;

    home.file.".config/rio/themes".source = ./configs/themes;

    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # Rio Terminal 高级集成
      if test "$TERM_PROGRAM" = "rio"
        # 设置 Rio 特定环境
        set -gx RIO_TERMINAL 1
        set -gx COLORTERM truecolor

        # Rio 配置管理函数
        function rio-config
          $EDITOR ~/.config/rio/config.toml
        end

        function rio-reload
          echo "配置已更新，请重启 Rio 终端"
        end

        function rio-theme
          if test (count $argv) -eq 0
            echo "可用主题："
            ls ~/.config/rio/themes/
          else
            cp ~/.config/rio/themes/$argv[1].toml ~/.config/rio/config.toml
            echo "已切换到主题: $argv[1]"
            rio-reload
          end
        end

        # Rio 性能优化
        function rio-performance
          echo "Rio Terminal 性能信息："
          echo "GPU 加速: 启用"
          echo "WebGPU 渲染: 自动检测"
          echo "字体渲染: 硬件加速"
        end
      end
    '';

    # Bash 集成
    programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
      # Rio Terminal 高级 Bash 集成
      if [ "$TERM_PROGRAM" = "rio" ]; then
        export RIO_TERMINAL=1
        export COLORTERM=truecolor

        # Rio 配置函数
        rio-config() {
          $EDITOR ~/.config/rio/config.toml
        }

        rio-reload() {
          echo "配置已更新，请重启 Rio 终端"
        }

        rio-theme() {
          if [ $# -eq 0 ]; then
            echo "可用主题："
            ls ~/.config/rio/themes/
          else
            cp ~/.config/rio/themes/"$1".toml ~/.config/rio/config.toml
            echo "已切换到主题: $1"
            rio-reload
          fi
        }
      fi
    '';

    xdg.desktopEntries.rio-custom = lib.mkIf pkgs.stdenv.isLinux {
      name = "Rio Terminal (Custom)";
      comment = "Rio with custom configuration";
      exec = "${pkgs.rio}/bin/rio";
      icon = "terminal";
      terminal = false;
      type = "Application";
      categories = [ "System" "TerminalEmulator" ];
    };
  };
}
