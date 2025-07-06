{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.dotfiles.nushell.enable {
    # 方式2: 直接文件写入
    home.file.".config/nushell/config.nu".text = ''
      # Nushell 配置文件 - 直接文件写入方式
      
      # 别名
      alias ll = ls -la
      alias la = ls -a
      alias l = ls
      alias .. = cd ..
      alias ... = cd ../..
      alias .... = cd ../../..
      
      # Git 别名
      alias gs = git status
      alias ga = git add
      alias gc = git commit
      alias gp = git push
      alias gl = git log --oneline
      alias gd = git diff
      alias gb = git branch
      alias gco = git checkout
      
      # 现代工具别名
      alias cat = bat
      alias find = fd
      alias grep = rg
      alias du = dust
      alias df = duf
      alias ps = procs
      alias top = btop
      
      # 自定义命令
      def mkcd [dir: string] {
          mkdir $dir
          cd $dir
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
      
      # 配置设置
      $env.config = {
          show_banner: false
          completions: {
              case_sensitive: false
              quick: true
              partial: true
              algorithm: "fuzzy"
          }
          history: {
              max_size: 10000
              sync_on_enter: true
              file_format: "plaintext"
          }
          edit_mode: emacs
          shell_integration: true
          cursor_shape: {
              emacs: line
              vi_insert: line
              vi_normal: block
          }
      }
    '';
    
    home.file.".config/nushell/env.nu".text = ''
      # Nushell 环境配置文件 - 直接文件写入方式
      
      # 环境变量
      $env.EDITOR = "vim"
      $env.BROWSER = "google-chrome"
      $env.TERM = "xterm-256color"
      
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
          
          $"(ansi cyan)($user)@($host)(ansi reset):(ansi blue)($dir)(ansi reset)$ "
      }
      
      def create_right_prompt [] {
          let time_segment = ([
              (date now | format date '%H:%M:%S')
          ] | str join)
          
          $time_segment
      }
      
      $env.PROMPT_COMMAND = {|| create_left_prompt }
      $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
      $env.PROMPT_INDICATOR = "〉"
      $env.PROMPT_INDICATOR_VI_INSERT = ": "
      $env.PROMPT_INDICATOR_VI_NORMAL = "〉"
      $env.PROMPT_MULTILINE_INDICATOR = "::: "
    '';
  };
}
