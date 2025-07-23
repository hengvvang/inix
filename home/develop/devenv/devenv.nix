{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.develop.enable && config.myHome.develop.devenv.enable) {

    # ====================================================================
    # 软件包安装配置
    # ====================================================================

    home.packages = with pkgs; [
      # devenv 核心工具 - 项目环境定义和管理
      devenv
    ]
    # 自动环境切换工具 - 仅在启用 autoSwitch 时安装
    ++ lib.optionals config.myHome.develop.devenv.autoSwitch [
      direnv              # 目录环境自动切换核心
      nix-direnv          # direnv 的 Nix 集成支持
    ]
    # 构建缓存工具 - 仅在启用 cache 时安装
    ++ lib.optionals config.myHome.develop.devenv.cache [
      cachix              # devenv 构建缓存，大幅提升构建速度
    ]
    # 项目模板和开发辅助工具 - 仅在启用 templates 时安装
    ++ lib.optionals config.myHome.develop.devenv.templates [
      cookiecutter        # 项目模板生成器
      pre-commit          # Git 提交前钩子管理
      just                # 现代化的 make 替代品
      watchexec           # 文件变化监控和自动执行
    ];

    # ====================================================================
    # direnv 自动环境切换配置
    # ====================================================================

    # 配置 direnv 程序 - 仅在启用自动切换时
    programs.direnv = lib.mkIf config.myHome.develop.devenv.autoSwitch {
      enable = true;
      nix-direnv.enable = true;

      # 注意：shell 集成由 Home Manager 自动处理，无需手动配置
      # 避免与其他模块的 direnv 配置冲突
    };

    # ====================================================================
    # Git 集成配置
    # ====================================================================

    # 自动忽略 devenv 和 direnv 生成的文件
    programs.git.ignores = [
      # devenv 生成的目录和文件
      ".devenv/"          # devenv 环境目录
      "devenv.lock"       # devenv 锁定文件
      "devenv.local.nix"  # 本地 devenv 配置文件

      # direnv 生成的目录（仅在启用自动切换时相关）
    ] ++ lib.optionals config.myHome.develop.devenv.autoSwitch [
      ".direnv/"          # direnv 缓存目录
    ];

    # ====================================================================
    # 缓存和性能优化配置
    # ====================================================================

    # 配置 cachix 以加速 devenv 构建 - 仅在启用 cache 时
    home.file.".config/cachix/cachix.dhall" = lib.mkIf config.myHome.develop.devenv.cache {
      text = ''
        -- devenv 官方缓存配置
        -- 大幅减少重复构建时间，提高开发体验
        { name = "devenv", publicKey = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" }
      '';
    };

    # ====================================================================
    # 用户环境和目录配置
    # ====================================================================

    # 创建用户级别的 devenv 配置目录
    home.file.".config/devenv/.keep".text = ''
      # devenv 用户配置目录
      # 用于存放全局 devenv 配置和缓存
    '';

    # 环境变量配置 - 仅在启用自动切换时设置
    home.sessionVariables = lib.mkIf config.myHome.develop.devenv.autoSwitch {
      # direnv 配置目录
      DIRENV_CONFIG = "$HOME/.config/direnv";

      # 确保 direnv 能找到 nix-direnv
      NIX_DIRENV_FLAKE_CACHE = "$HOME/.cache/nix-direnv";
    };

    # ====================================================================
    # 用户提示和文档
    # ====================================================================

    # 在激活时显示配置信息（通过 activation script）
    home.activation.devenvInfo = lib.hm.dag.entryAfter ["writeBoundary"] (
      let
        autoSwitchStatus = if config.myHome.develop.devenv.autoSwitch then "✅ 启用" else "❌ 禁用";
        templatesStatus = if config.myHome.develop.devenv.templates then "✅ 启用" else "❌ 禁用";
        cacheStatus = if config.myHome.develop.devenv.cache then "✅ 启用" else "❌ 禁用";
      in ''
        echo "🚀 devenv 开发环境配置已激活"
        echo "  自动环境切换: ${autoSwitchStatus}"
        echo "  项目模板工具: ${templatesStatus}"
        echo "  构建缓存优化: ${cacheStatus}"
        echo "  Shell 集成: ${config.myHome.develop.devenv.shell}"
      ''
    );
  };
}
