{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.vim = {
    enable = lib.mkEnableOption "Vim dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "template" ];
      default = "homemanager";
      description = "Vim 配置方式";
    };
    
    # 模板配置选项
    tabSize = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "Tab 大小";
    };
    
    leader = lib.mkOption {
      type = lib.types.str;
      default = " ";
      description = "Leader 键";
    };
    
    colorScheme = lib.mkOption {
      type = lib.types.str;
      default = "default";
      description = "颜色主题";
    };
    
    showLineNumbers = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "显示行号";
    };
    
    enableMouse = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "启用鼠标支持";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
    ./template.nix
  ];
}
