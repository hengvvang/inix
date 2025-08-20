{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "direct") {
    
    home.file.".config/nushell/config.nu" = {
      text = ''
        # Nushell 配置文件
        # 配置方式: direct - 直接文件配置

        # 基本设置
        $env.config = {
          show_banner: false
          use_grid_icons: true
          footer_mode: "25"
          float_precision: 2
          use_ansi_coloring: true
          edit_mode: emacs
          shell_integration: true
          render_right_prompt_on_last_line: false

          # 历史设置
          history: {
            max_size: 10000
            sync_on_enter: true
            file_format: "plaintext"
          }

          # 补全设置
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "prefix"
            external: {
              enable: true
              max_results: 100
              completer: null
            }
          }

          # 文件管理器设置
          filesize: {
            metric: true
            format: "auto"
          }

          # 光标形状
          cursor_shape: {
            emacs: line
            vi_insert: line
            vi_normal: block
          }

          # 颜色设置
          color_config: {
            separator: white
            leading_trailing_space_bg: { attr: n }
            header: green_bold
            empty: blue
            bool: white
            int: white
            filesize: white
            duration: white
            date: white
            range: white
            float: white
            string: white
            nothing: white
            binary: white
            cellpath: white
            row_index: green_bold
            record: white
            list: white
            block: white
            hints: dark_gray
            search_result: {bg: red fg: white}
          }

          # 表格设置
          table: {
            mode: rounded
            index_mode: always
            show_empty: true
            trim: {
              methodology: wrapping
              wrapping_try_keep_words: true
              truncating_suffix: "..."
            }
          }

          # 错误设置
          error_style: "fancy"

          # 日期时间格式
          datetime_format: {
            normal: '%a, %d %b %Y %H:%M:%S %z'
            table: '%m/%d/%y %I:%M:%S%p'
          }

          # 探索模式
          explore: {
            help_banner: true
            exit_esc: true
            command_bar_text: '#C4C9C6'
            status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6'}
            highlight: {bg: 'yellow' fg: 'black'}
            status: {
              error: {fg: 'white' bg: 'red'}
              warn: {}
              info: {}
            }
            try: {
              border_color: 'red'
              highlighted_color: 'blue'
            }
            table: {
              split_line: '#404040'
              cursor: true
              line_index: true
              line_shift: true
              line_head_top: true
              line_head_bottom: true
              show_head: true
              show_index: true
            }
            config: {
              cursor_color: {bg: 'yellow' fg: 'black'}
            }
          }

          # 菜单设置
          menus: [
            {
              name: completion_menu
              only_buffer_difference: false
              marker: "| "
              type: {
                layout: columnar
                columns: 4
                col_width: 20
                col_padding: 2
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
            {
              name: history_menu
              only_buffer_difference: true
              marker: "? "
              type: {
                layout: list
                page_size: 10
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
            {
              name: help_menu
              only_buffer_difference: true
              marker: "? "
              type: {
                layout: description
                columns: 4
                col_width: 20
                col_padding: 2
                selection_rows: 4
                description_rows: 10
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
          ]

          # 键绑定
          keybindings: [
            {
              name: completion_menu
              modifier: none
              keycode: tab
              mode: [emacs vi_normal vi_insert]
              event: {
                until: [
                  { send: menu name: completion_menu }
                  { send: menunext }
                ]
              }
            }
            {
              name: completion_previous
              modifier: shift
              keycode: backtab
              mode: [emacs, vi_normal, vi_insert]
              event: { send: menuprevious }
            }
            {
              name: history_menu
              modifier: control
              keycode: char_r
              mode: emacs
              event: { send: menu name: history_menu }
            }
            {
              name: next_page
              modifier: control
              keycode: char_x
              mode: emacs
              event: { send: menupagenext }
            }
            {
              name: undo_or_previous_page
              modifier: control
              keycode: char_z
              mode: emacs
              event: {
                until: [
                  { send: menupageprevious }
                  { edit: undo }
                ]
              }
            }
            {
              name: yank
              modifier: control
              keycode: char_y
              mode: emacs
              event: {
                until: [
                  {edit: pastecutbufferafter}
                ]
              }
            }
            {
              name: unix-line-discard
              modifier: control
              keycode: char_u
              mode: [emacs, vi_normal, vi_insert]
              event: {
                until: [
                  {edit: cutfromlinestart}
                ]
              }
            }
            {
              name: kill-line
              modifier: control
              keycode: char_k
              mode: [emacs, vi_normal, vi_insert]
              event: {
                until: [
                  {edit: cuttolineend}
                ]
              }
            }
            {
              name: commands_menu
              modifier: control
              keycode: char_t
              mode: [emacs, vi_normal, vi_insert]
              event: { send: menu name: commands_menu }
            }
            {
              name: vars_menu
              modifier: alt
              keycode: char_o
              mode: [emacs, vi_normal, vi_insert]
              event: { send: menu name: vars_menu }
            }
            {
              name: commands_with_description
              modifier: control
              keycode: char_s
              mode: [emacs, vi_normal, vi_insert]
              event: { send: menu name: commands_with_description }
            }
          ]
        }

        # 自定义命令和别名
        alias ll = ls -la
        alias la = ls -a
        alias l = ls
        alias grep = grep --color=auto
        alias cat = bat
        alias find = fd
        alias ps = procs

        # Git 别名
        alias g = git
        alias gs = git status
        alias ga = git add
        alias gc = git commit
        alias gp = git push
        alias gl = git log --oneline

        # 系统别名
        alias df = df -h
        alias du = du -h
        alias free = free -h

        # Nix 别名
        alias rebuild = sudo nixos-rebuild switch
        alias home-rebuild = home-manager switch

        # 自定义函数
        def mkcd [path: string] {
          mkdir $path
          cd $path
        }

        def extract [file: string] {
          match ($file | path extension) {
            "zip" => { unzip $file }
            "tar" => { tar -xf $file }
            "gz" => { 
              if ($file | str ends-with ".tar.gz") {
                tar -xzf $file
              } else {
                gunzip $file
              }
            }
            "bz2" => { 
              if ($file | str ends-with ".tar.bz2") {
                tar -xjf $file
              } else {
                bunzip2 $file
              }
            }
            "7z" => { 7z x $file }
            "rar" => { unrar x $file }
            _ => { echo $"不支持的文件格式: ($file)" }
          }
        }

        def sysinfo [] {
          echo "=== 系统信息 ==="
          echo $"主机名: (hostname)"
          echo $"操作系统: (uname -s)"
          echo $"内核版本: (uname -r)"
          echo $"CPU 架构: (uname -m)"
          echo $"当前用户: (whoami)"
          echo $"Shell: Nushell"
          echo $"Nu 版本: (version | get version)"
        }

        def weather [city?: string] {
          if ($city | is-empty) {
            http get "http://wttr.in/?format=3"
          } else {
            http get $"http://wttr.in/($city)?format=3"
          }
        }

        # 启动消息
        echo "🚀 Nushell Direct Mode Loaded"
        echo $"📅 (date now | format date '%Y-%m-%d %H:%M:%S')"
        echo $"💻 (hostname) | 👤 (whoami)"
        echo $"🗂️  (pwd)"
      '';
    };

    home.file.".config/nushell/env.nu" = {
      text = ''
        # Nushell 环境配置文件
        # 配置方式: direct - 直接文件配置

        # 环境变量设置
        $env.EDITOR = "vim"
        $env.VISUAL = $env.EDITOR
        $env.PAGER = "less"
        $env.LESS = "-R"

        # 路径设置
        $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/bin")

        # Nushell 特定环境变量
        $env.PROMPT_COMMAND = {|| 
          let home = $nu.home-path
          let dir = ([
            ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
            ($env.PWD | str substring ($home | str length)..)
          ] | str join)
          
          $"(ansi green_bold)($env.USER)(ansi reset)@(ansi blue_bold)(hostname)(ansi reset):(ansi purple_bold)($dir)(ansi reset)$ "
        }

        $env.PROMPT_COMMAND_RIGHT = {|| 
          let time = (date now | format date '%H:%M:%S')
          $"(ansi cyan)($time)(ansi reset)"
        }

        $env.PROMPT_INDICATOR = ""
        $env.PROMPT_INDICATOR_VI_INSERT = ": "
        $env.PROMPT_INDICATOR_VI_NORMAL = "〉"
        $env.PROMPT_MULTILINE_INDICATOR = "::: "

        # Git 相关环境变量
        $env.GIT_EDITOR = $env.EDITOR

        # 开发工具路径
        $env.CARGO_HOME = $"($env.HOME)/.cargo"
        $env.RUSTUP_HOME = $"($env.HOME)/.rustup"

        # 如果 cargo 目录存在，添加到 PATH
        if ($"($env.CARGO_HOME)/bin" | path exists) {
          $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.CARGO_HOME)/bin")
        }

        # Node.js 环境
        $env.NODE_OPTIONS = "--max-old-space-size=4096"

        # Python 环境
        $env.PYTHONPATH = ($env.PYTHONPATH? | default "" | split row (char esep) | prepend $"($env.HOME)/.local/lib/python3.11/site-packages" | str join (char esep))

        # 颜色支持
        $env.CLICOLOR = "1"
        $env.LSCOLORS = "ExFxBxDxCxegedabagacad"

        # 历史文件
        $env.NU_HISTORY_FILE = $"($env.HOME)/.config/nushell/history.txt"

        # 自定义配置目录
        $env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
        $env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
        $env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

        # 语言和地区设置
        $env.LANG = "en_US.UTF-8"
        $env.LC_ALL = "en_US.UTF-8"

        # 终端设置
        $env.TERM = "xterm-256color"
        $env.COLORTERM = "truecolor"

        # Starship 提示符（如果安装了）
        # mkdir ~/.cache/starship
        # starship init nu | save -f ~/.cache/starship/init.nu
      '';
    };
  };
}
