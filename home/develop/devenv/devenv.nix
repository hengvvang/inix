{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.develop.enable && config.myHome.develop.devenv.enable) {
    home.packages = with pkgs; [
      devenv              # devenv 核心工具
      direnv              # 目录环境自动切换
      nix-direnv          # direnv 的 nix 支持
      cachix              # devenv 构建缓存
    ] ++ lib.optionals config.myHome.develop.devenv.templates [
      # 项目模板工具
      cookiecutter
      
      # 版本控制增强
      pre-commit
      
      # 通用开发工具
      just        # 现代化的 make 替代品
      watchexec   # 文件变化监控
    ];

    # 配置 direnv - 仅在没有其他配置时启用
    programs.direnv = lib.mkIf (!config.programs.fish.enable) {
      enable = true;
      nix-direnv.enable = true;
      
      # 根据用户选择的 shell 配置
      enableBashIntegration = config.myHome.develop.devenv.shell == "bash";
      enableFishIntegration = config.myHome.develop.devenv.shell == "fish";
      enableZshIntegration = config.myHome.develop.devenv.shell == "zsh";
    };

    # Git 忽略 devenv 生成的文件
    programs.git.ignores = [
      ".devenv/"
      ".direnv/"
      "devenv.lock"
      "devenv.local.nix"
    ];

    # 配置 cachix 以加速 devenv 构建
    home.file.".config/cachix/cachix.dhall".text = ''
      { name = "devenv", publicKey = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" }
    '';

    # 创建用户级别的 devenv 配置目录
    home.file.".config/devenv/.keep".text = "";

    # 确保 direnv 和 nix-direnv 在当前 shell 中可用
    home.sessionVariables = {
      # direnv 配置目录
      DIRENV_CONFIG = "$HOME/.config/direnv";
    };
  };
}
