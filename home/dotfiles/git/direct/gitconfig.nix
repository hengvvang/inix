{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {
    home.file.".gitconfig" = {
      text = ''
        [user]
            name = hengvvang
            email = hengvvang@example.com

        [core]
            editor = vim
            autocrlf = false
            filemode = true
            ignorecase = false
            precomposeunicode = true
            quotepath = false
            trustctime = false
            pager = less -FMRiX
            whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol
            excludesfile = ~/.gitignore

        [init]
            defaultBranch = main

        [push]
            default = simple
            followTags = true
            autoSetupRemote = true

        [pull]
            rebase = true
            ff = only

        [merge]
            conflictstyle = diff3
            tool = vimdiff

        [color]
            ui = auto
            branch = auto
            diff = auto
            status = auto

        [alias]
            # 基础操作
            a = add
            aa = add --all
            c = commit
            ca = commit --all
            cm = commit --message
            s = status
            ss = status --short
            l = log --oneline
            p = push
            pl = pull
            co = checkout
            b = branch
            d = diff
            
            # 高级操作
            lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
            unstage = reset HEAD --
            undo = reset --soft HEAD^
            amend = commit --amend
            
            # 分支管理
            cob = checkout -b
            bd = branch --delete
            ba = branch --all
            
            # 暂存操作
            st = stash
            stp = stash pop
            stl = stash list

        [fetch]
            prune = true

        [rebase]
            autoStash = true

        [help]
            autocorrect = 1

        [safe]
            directory = *
      '';
    };
  };
}
