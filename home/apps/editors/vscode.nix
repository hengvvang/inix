{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.editors.vscode {
  # VS Code 配置
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;  # 使用开源版本避免许可证问题
    
    # 基础设置
    profiles.default = {
      userSettings = {
        "editor.fontSize" = 14;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "files.autoSave" = "afterDelay";
        "workbench.colorTheme" = "Default Dark+";
      };
      
      # 基础扩展
      extensions = with pkgs.vscode-extensions; [
        ms-vscode.cpptools
        ms-python.python
        rust-lang.rust-analyzer
        bradlc.vscode-tailwindcss
      ];
    };
  };
  };
}