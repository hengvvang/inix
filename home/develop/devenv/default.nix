{ config, lib, pkgs, ... }:

{
  options.myHome.develop.devenv = {
    enable = lib.mkEnableOption "devenv 项目环境管理";
    
    # 自动环境切换配置
    autoSwitch = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        启用自动环境切换功能（使用 direnv）
        - true: 进入项目目录自动激活环境
        - false: 仅安装 devenv，需手动执行 `devenv shell`
      '';
    };
    
    # Shell 集成配置
    shell = lib.mkOption {
      type = lib.types.enum [ "bash" "fish" "zsh" ];
      default = "fish";
      description = ''
        direnv 集成的默认 shell
        注意：仅在 autoSwitch = true 时生效
      '';
    };
    
    # 项目模板工具配置
    templates = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        安装项目模板和辅助开发工具
        包括：cookiecutter, pre-commit, just, watchexec
        轻量级用户建议设为 false
      '';
    };
    
    # 构建缓存配置
    cache = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        启用 cachix 构建缓存以加速 devenv 构建
        建议保持启用以获得更好的性能
      '';
    };
  };

  imports = [
    ./devenv.nix
  ];
}
