{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors.micro.enable = lib.mkEnableOption "Micro 编辑器配置";

  config = lib.mkIf config.myHome.apps.editors.micro.enable {
  # Micro 编辑器配置
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;              # 自动保存
      colorscheme = "monokai";    # 颜色主题
      cursorline = true;          # 高亮当前行
      tabsize = 4;                # Tab 大小
      tabstospaces = true;        # Tab 转换为空格
      syntax = true;              # 语法高亮
    };
  };
  };
}
