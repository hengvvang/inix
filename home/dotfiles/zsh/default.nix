{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.zsh = {
    enable = lib.mkEnableOption "Zsh dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "template" ];
      default = "homemanager";
      description = "Zsh 配置方式";
    };
    
    # 模板配置选项
    historySize = lib.mkOption {
      type = lib.types.int;
      default = 10000;
      description = "历史记录大小";
    };
    
    theme = lib.mkOption {
      type = lib.types.str;
      default = "simple";
      description = "主题名称";
    };
    
    enableAutosuggestion = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "启用自动建议";
    };
    
    enableSyntaxHighlighting = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "启用语法高亮";
    };
    
    extraAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "额外的别名";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
    ./template.nix
  ];
}
