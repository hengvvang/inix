{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.editors.vscode.enable {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    
    #profiles.default = {
    #  userSettings = {
    #    "editor.fontSize" = 14;
    #    "editor.tabSize" = 2;
    #    "editor.insertSpaces" = true;
    #    "files.autoSave" = "afterDelay";
    #    "workbench.colorTheme" = "Default Dark+";
    #  };
    #  
    #  # 基础扩展
    #  extensions = with pkgs.vscode-extensions; [
    #    ms-vscode.cpptools
    #    ms-python.python
    #    rust-lang.rust-analyzer
    #    bradlc.vscode-tailwindcss
    #  ];
    #};
  };
  };
}