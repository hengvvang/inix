{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "homemanager") {
    # Zsh Shell 配置 - 使用 Home Manager
    programs.zsh = {
      enable = true;
      package = pkgs.zsh;
      # 自动补全配置
      enableCompletion = true;           # 启用命令补全 (推荐)
      autosuggestion.enable = true;      # 启用自动建议 (基于历史记录)
      syntaxHighlighting.enable = true;  # 启用语法高亮
      # 自动切换目录 - 输入目录名即可切换
      autocd = true;                     # 启用autocd功能

      # 历史记录配置
      history = {
        size = 10000;                    # 内存中保存的历史命令数量
        save = 100000;                   # 文件中保存的历史命令数量
        path = "$HOME/.zsh_history";     # 历史文件路径
        ignoreDups = true;               # 忽略重复命令
        ignoreSpace = true;              # 忽略以空格开头的命令
        expireDuplicatesFirst = true;    # 优先删除重复的历史记录
        extended = true;                 # 保存命令执行时间
        share = true;                    # 在多个shell会话间共享历史
      };

      shellAliases = {
        zj = "zellij";
        zed = "zeditor";
      };

      # Shell选项配置
      defaultKeymap = "emacs";           # 默认键映射模式 (emacs/vi)

      # 自定义补全初始化
      completionInit = ''
        # 补全系统配置
        autoload -Uz compinit
        compinit

        # 补全样式配置
        zstyle ':completion:*' menu select                    # 使用菜单选择补全
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 大小写不敏感匹配
        zstyle ':completion:*' list-colors ""                 # 使用默认颜色
        zstyle ':completion:*:descriptions' format '%B%d%b'   # 补全分组描述格式
        zstyle ':completion:*:warnings' format 'No matches for: %d'  # 无匹配时的提示

        # 路径补全优化
        zstyle ':completion:*' squeeze-slashes true           # 压缩多个斜杠
        zstyle ':completion:*' special-dirs true              # 补全 . 和 ..
      '';

      # 交互式Shell初始化
      initContent = ''
        export EDITOR="''${EDITOR:-vim}"

        # Zsh选项配置
        setopt AUTO_CD                   # 自动切换目录
        setopt AUTO_PUSHD               # 自动将目录推入栈
        setopt PUSHD_IGNORE_DUPS        # 忽略重复的目录
        setopt PUSHD_MINUS              # 交换 +/- 的含义
        setopt EXTENDED_GLOB            # 扩展通配符
        setopt GLOB_DOTS                # 通配符匹配点文件
        setopt NUMERIC_GLOB_SORT        # 数字排序
        setopt NO_CASE_GLOB             # 大小写不敏感通配符

        # 历史记录选项
        setopt HIST_VERIFY              # 历史扩展前确认
        setopt HIST_NO_STORE            # 不保存history命令


        # 输入/输出
        setopt CORRECT                  # 命令纠错
        setopt NO_CORRECT_ALL           # 不纠错参数
        setopt INTERACTIVE_COMMENTS     # 允许交互式注释
      '';

      # 环境变量配置
      envExtra = ''
      '';

      # 配置目录
      dotDir = "${config.xdg.configHome}/zsh";

      # Oh My Zsh 配置（可选，默认关闭）
      oh-my-zsh = {
        enable = false;                  # 默认关闭，避免过度配置
        # 如果启用，可以配置以下选项：
        # plugins = [ "git" "sudo" "docker" "kubectl" ];
        # theme = "robbyrussell";
        # custom = "$HOME/.oh-my-zsh/custom";
      };

      # Zsh插件配置（轻量级替代oh-my-zsh）
      plugins = [
        # 可以在这里添加轻量级插件
        # 例如：z跳转、fzf集成等
        # {
        #   name = "zsh-z";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "agkozak";
        #     repo = "zsh-z";
        #     rev = "v1.12";
        #     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #   };
        # }
      ];
    };
  };
}
