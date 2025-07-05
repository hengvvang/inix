{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nano
    vim
    micro
    vscode
    zed-editor
  ];
  
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
}
