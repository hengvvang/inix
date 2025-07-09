{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "homemanager") {
    # 方式1: Home Manager 程序模块（推荐）
    # 特点：声明式配置，与 Home Manager 深度集成，易于管理
    programs.nushell = {
      enable = true;
      
      # 主配置文件
      configFile.text = ''
        # Nushell 现代化配置
        $env.config = {
          show_banner: false
          
          # 智能补全
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: null
            }
          }
          
          # 历史记录
          history: {
            max_size: 100000
            sync_on_enter: true
            file_format: "plaintext"
            isolation: false
          }
          
          # 编辑模式
          edit_mode: vi
          
          # 表格显示
          table: {
            mode: markdown
            index_mode: always
            show_empty: true
            trim: {
              methodology: wrapping
              wrapping_try_keep_words: true
              truncating_suffix: "..."
            }
          }
          
          # 光标形状
          cursor_shape: {
            emacs: line
            vi_insert: line
            vi_normal: block
          }
          
          # 颜色配置
          color_config: {
            separator: white
            leading_trailing_space_bg: { attr: n }
            header: green_bold
            empty: blue
            bool: {
              true: light_cyan
              false: light_red
            }
            int: white
            filesize: cyan
            duration: white
            date: purple
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
          }
          
          # 钩子
          hooks: {
            pre_prompt: [{ ||
              null
            }]
            pre_execution: [{ ||
              null
            }]
            env_change: {
              PWD: [{ |before, after|
                null
              }]
            }
            display_output: { ||
              if (term size).columns >= 100 { table -e } else { table }
            }
          }
          
          # 菜单样式
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
          
          # 键位绑定
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
                  { edit: complete }
                ]
              }
            }
            {
              name: history_menu
              modifier: control
              keycode: char_r
              mode: [emacs, vi_insert, vi_normal]
              event: { send: menu name: history_menu }
            }
            {
              name: help_menu
              modifier: none
              keycode: f1
              mode: [emacs, vi_insert, vi_normal]
              event: { send: menu name: help_menu }
            }
          ]
        }
        
        # 自定义命令
        def mkcd [dir: string] {
          mkdir $dir
          cd $dir
        }
        
        def la [] {
          ls -la
        }
        
        def weather [city?: string] {
          let location = if ($city == null) { "Shanghai" } else { $city }
          http get $"https://wttr.in/($location)?format=3"
        }
        
        def extract [file: string] {
          if ($file | path exists) {
            let ext = ($file | path parse | get extension)
            match $ext {
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
              _ => { echo $"Cannot extract ($file): unsupported format" }
            }
          } else {
            echo $"File ($file) does not exist"
          }
        }
      '';
      
      # 环境配置
      envFile.text = ''
        # Nushell 环境配置
        $env.EDITOR = "vim"
        $env.BROWSER = "google-chrome"
        $env.TERM = "xterm-256color"
        $env.COLORTERM = "truecolor"
        
        # 路径设置
        $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/bin" | prepend $"($env.HOME)/.cargo/bin")
        
        # 自定义提示符
        def create_left_prompt [] {
          let home = $nu.home-path
          let dir = (
            if ($env.PWD | path relative-to $home | is-empty) {
              "~"
            } else {
              ($env.PWD | str replace $home "~")
            }
          )
          
          let user = (whoami)
          let host = (hostname)
          
          $"(ansi cyan_bold)($user)@($host)(ansi reset):(ansi blue_bold)($dir)(ansi reset)$ "
        }
        
        def create_right_prompt [] {
          let time_segment = ([
            (date now | format date '%H:%M:%S')
          ] | str join)
          
          $"(ansi green)($time_segment)(ansi reset)"
        }
        
        $env.PROMPT_COMMAND = {|| create_left_prompt }
        $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
        $env.PROMPT_INDICATOR = "〉"
        $env.PROMPT_INDICATOR_VI_INSERT = ": "
        $env.PROMPT_INDICATOR_VI_NORMAL = "〉"
        $env.PROMPT_MULTILINE_INDICATOR = "::: "
      '';
      
      # 现代化别名
      shellAliases = {
        # 基础命令
        ll = "ls -la";
        la = "ls -a";
        l = "ls";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        
        # Git 别名
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline";
        gd = "git diff";
        gb = "git branch";
        gco = "git checkout";
        
        # 现代工具别名
        cat = "bat";
        find = "fd";
        grep = "rg";
        du = "dust";
        df = "duf";
        ps = "procs";
        top = "btop";
        ping = "gping";
        
        # 便捷别名
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        
        # 网络和系统
        ports = "ss -tuln";
        myip = "curl -s https://ipinfo.io/ip";
        weather = "curl -s wttr.in/Shanghai";
      };
    };
  };
}
