{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {
    # 直接文件写入 - 演示用简化配置
    home.file.".gitconfig".text = ''
      [user]
          name = hengvvang
          email = hengvvang@example.com

      [init]
          defaultBranch = main

      [core]
          editor = nvim
          autocrlf = input

      [color]
          ui = true

      [alias]
          st = status
          co = checkout
          br = branch
          cm = commit
          lg = log --oneline --graph --decorate
    '';
  };
}
