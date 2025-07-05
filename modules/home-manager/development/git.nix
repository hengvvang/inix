{ config, lib, pkgs, ... }:

{
  # Git 配置 - 版本控制系统
  programs.git = {
    enable = true;
    userName = "hengvvang";
    userEmail = "your-email@example.com"; # 请修改为你的邮箱
    
    # Git 别名 - 提高效率的快捷命令
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      ca = "commit -a";
      cam = "commit -am";
      lg = "log --oneline --graph --decorate --all";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
    };
    
    # Git 额外配置
    extraConfig = {
      # 默认分支名称
      init.defaultBranch = "main";
      
      # 推送配置
      push.default = "simple";
      push.autoSetupRemote = true;
      
      # 拉取配置
      pull.rebase = false;
      
      # 颜色配置
      color.ui = true;
      
      # 编辑器配置
      core.editor = "micro";
      
      # 忽略文件权限变化
      core.filemode = false;
      
      # 自动修正命令拼写错误
      help.autoCorrect = 1;
    };
  };

  # Lazygit - 优雅的 Git 终端界面
  programs.lazygit = {
    enable = true;
    
    # Lazygit 基础配置
    settings = {
      # 界面配置
      gui = {
        showFileTree = true;
        mouseEvents = true;
      };
      
      # Git 配置
      git = {
        commit.signOff = false;
      };
    };
  };
}
