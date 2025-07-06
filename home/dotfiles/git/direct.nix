{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {
    # 方式2: 直接文件写入
    home.file.".gitconfig".text = ''
      [user]
          name = hengvvang
          email = hengvvang@example.com

      [init]
          defaultBranch = main

      [core]
          editor = nvim
          autocrlf = input
          safecrlf = true

      [push]
          default = simple

      [pull]
          rebase = false

      [color]
          ui = true
          status = auto
          branch = auto
          interactive = auto
          diff = auto

      [diff]
          tool = vimdiff

      [merge]
          tool = vimdiff

      [alias]
          st = status
          co = checkout
          br = branch
          cm = commit
          pl = pull
          ps = push
          lg = log --oneline --graph --decorate
          ll = log --pretty=format:'%h - %an, %ar : %s'
          unstage = reset HEAD --
          last = log -1 HEAD
          visual = !gitk

      # Delta 配置
      [core]
          pager = delta

      [interactive]
          diffFilter = delta --color-only

      [delta]
          navigate = true
          light = false
          side-by-side = true
          line-numbers = true
          syntax-theme = Dracula
    '';
    
    home.file.".gitignore_global".text = ''
      # 系统文件
      .DS_Store
      Thumbs.db
      
      # 编辑器文件
      *.swp
      *.swo
      *~
      .vscode/
      .idea/
      
      # 临时文件
      *.tmp
      *.temp
      *.log
      
      # 构建文件
      node_modules/
      target/
      build/
      dist/
      .cache/
      
      # 环境文件
      .env
      .env.local
      .env.*.local
    '';
  };
}
