{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "external") {

    home.packages = with pkgs; [
      vscode

      monaspace
      lxgw-wenkai
      nerd-fonts.sauce-code-pro
      nerd-fonts.jetbrains-mono
    ];

    home.file.".config/Code/User/tasks.json" = {
      source = ./configs/tasks.json;
      # 设置为只读，确保配置文件不被 VSCode 修改
      # readonly = true;  # 可选，如果希望 VSCode 可以修改配置则注释此行
    };
    home.file.".config/Code/User/settings.json" = {
      source = ./configs/settings.json;
      # 设置为只读，确保配置文件不被 VSCode 修改
      # readonly = true;  # 可选，如果希望 VSCode 可以修改配置则注释此行
    };
    home.file.".config/Code/User/keybindings.json" = {
      source = ./configs/keybindings.json;
      # readonly = true;  # 可选
    };
    home.file.".config/Code/User/extensions.json" = {
      source = ./configs/extensions.json;
    };
    home.file.".config/Code/User/snippets" = {
      source = ./configs/snippets;
      recursive = true;  # 递归复制整个目录
    };
  };
}
