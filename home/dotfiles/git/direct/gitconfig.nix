{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {
    
    home.file.".gitconfig" = {
      text = ''
        # Git 配置文件
        # 配置方式: direct - 直接文件配置

        [user]
            name = Your Name
            email = your.email@example.com
            # 如果你有 GPG 密钥，可以设置签名
            # signingkey = YOUR_GPG_KEY_ID

        [core]
            editor = vim
            autocrlf = input
            safecrlf = warn
            excludesfile = ~/.gitignore_global
            quotepath = false

        [init]
            defaultBranch = main

        [push]
            default = simple
            autoSetupRemote = true

        [pull]
            rebase = true

        [merge]
            tool = vimdiff
            conflictstyle = diff3

        [diff]
            tool = vimdiff
            colorMoved = default

        [color]
            ui = auto
            branch = auto
            diff = auto
            interactive = auto
            status = auto

        [color "branch"]
            current = yellow reverse
            local = yellow
            remote = green

        [color "diff"]
            meta = yellow bold
            frag = magenta bold
            old = red bold
            new = green bold

        [color "status"]
            added = green
            changed = yellow
            untracked = red

        [alias]
            # 基本别名
            co = checkout
            br = branch
            ci = commit
            st = status
            unstage = reset HEAD --
            last = log -1 HEAD
            visual = !gitk

            # 日志别名
            lg = log --oneline --graph --decorate
            lga = log --oneline --graph --decorate --all
            ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat
            ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
            
            # 状态和差异
            s = status -s
            d = diff
            dc = diff --cached
            
            # 分支操作
            bd = branch -d
            bdd = branch -D
            
            # 远程操作
            rao = remote add origin
            rso = remote set-url origin
            
            # 快速提交
            ac = !git add -A && git commit -m
            acam = !git add -A && git commit --amend --no-edit
            
            # 撤销操作
            undo = reset --soft HEAD^
            uncommit = reset --mixed HEAD~
            unstage = reset HEAD
            
            # 清理操作
            cleanup = !git branch --merged | grep -v '\\*\\|master\\|main\\|develop' | xargs -n 1 git branch -d

        [branch]
            autosetupmerge = always
            autosetuprebase = always

        [rebase]
            autoStash = true

        [fetch]
            prune = true

        [rerere]
            enabled = true

        [help]
            autocorrect = 1

        [commit]
            template = ~/.gitmessage
            # 如果你有 GPG 密钥，可以启用签名
            # gpgsign = true

        [tag]
            # 如果你有 GPG 密钥，可以启用签名
            # gpgsign = true

        [url "https://github.com/"]
            insteadOf = gh:

        [url "https://gitlab.com/"]
            insteadOf = gl:

        [credential]
            helper = store
      '';
    };

    # Git 提交消息模板
    home.file.".gitmessage" = {
      text = ''
        # <类型>: <描述>
        # 
        # 详细说明 (可选):
        # 
        # 相关问题 (可选):
        # Fixes #issue_number
        # 
        # 类型说明:
        # feat:     新功能
        # fix:      修复 bug
        # docs:     文档更新
        # style:    代码格式化
        # refactor: 重构代码
        # test:     测试相关
        # chore:    构建过程或辅助工具的变动
        # perf:     性能优化
        # ci:       持续集成相关
        # revert:   回退提交
      '';
    };
  };
}
