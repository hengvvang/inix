{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.configStyle == "homeManager") {

    programs.fish = {
      enable = true;
      package = pkgs.fish;
      # 自动生成补全 - 基于已安装的man页面自动生成命令补全
      generateCompletions = true;
      # 偏好缩写而非别名 - 当其他模块定义别名时优先使用缩写
      preferAbbrs = true;  # 默认值：false，设为true以优先使用缩写
      # 简化的别名配置 - 仅保留最常用的
      shellAliases = {
        zj = "zellij";
        zd = "zeditor";
        ya = "yazi";
        yz = "yazi";
      };
      # 缩写配置 - Fish特有功能，输入后自动扩展为完整命令
      shellAbbrs = {
        # 终端工具缩写
        zj = "zellij";
        zed = "zeditor";
        ya = "yazi";
        # 导航缩写
        ".." = "cd ..";
        "..." = "cd ../..";
        # 特殊位置缩写 - 可以在命令中任何位置扩展
        "-h" = {
          position = "anywhere";
          expansion = "--help";
        };
        # "-v" = {
        #   position = "anywhere";
        #   expansion = "--version";
        # };
      };
      # 插件配置 - 扩展Fish功能
      plugins = [
        # 注意：z 插件已被移除，因为我们使用 zoxide 作为目录跳转工具
        # zoxide 通过 develop/devenv 模块自动配置，提供更好的功能

        # 其他插件可以在这里添加
        # 例如：fzf fish集成、git提示等
      ];
      # Shell初始化 - 在所有shell启动时执行（包括非交互式）
      shellInit = ''
        # 简洁的欢迎信息
        set -g fish_greeting ""

        # 核心环境变量
        set -gx EDITOR vim
        set -gx TERM xterm-256color

        # 路径配置
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin

        # 现代化工具配置
        set -gx BAT_THEME "TwoDark"
        set -gx FZF_DEFAULT_OPTS "--height 40% --border"
      '';
      # 登录Shell初始化 - 仅在登录shell启动时执行
      loginShellInit = ''
        # 登录时的特定设置
        # 例如:启动SSH代理、设置特殊权限等
        # 通常保持为空，除非有特殊需求
      '';
      # 交互式Shell初始化 - 仅在交互式shell启动时执行
      interactiveShellInit = ''
        # 键绑定配置
        bind \e\[1\;5C forward-word      # Ctrl+Right: 前进一个单词
        bind \e\[1\;5D backward-word     # Ctrl+Left: 后退一个单词
        bind \cf 'fzf_cd'                # Ctrl+F: fzf目录导航

        # 历史设置
        set -g fish_history_timeout 60   # 历史超时时间

        # 禁用Fish默认提示符 (如果使用Starship等外部提示符)
        # functions --erase fish_prompt
        # functions --erase fish_right_prompt

        # Starship提示符配置 (如果使用)
        # set -gx STARSHIP_CONFIG ~/.config/starship.toml

        # 终端标题设置
        function fish_title
          echo (prompt_pwd) (__fish_git_prompt " (%s)")
        end
      '';
      # 最后执行的初始化 - 在所有其他初始化完成后执行
      shellInitLast = ''
        # 最后的配置调整
        # 例如：覆盖其他模块的设置、加载用户特定配置等

        # 如果存在本地配置文件则加载
        if test -f ~/.config/fish/local.fish
          source ~/.config/fish/local.fish
        end
      '';
      # 函数定义 - 简化为几个核心实用函数
      functions = {
        # 获取公网IP
        myip = {
          description = "获取公网IP地址";
          body = ''
            curl -s ifconfig.me
          '';
        };
      };
    };
  };
}
