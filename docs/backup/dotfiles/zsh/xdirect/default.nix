{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "xdirect") {

    home.packages = lib.optionals config.myHome.dotfiles.zsh.packageEnable (with pkgs; [ zsh ]);

    # Zsh 官方配置文件结构
    home.file.".config/zsh/.zshenv".text = builtins.readFile ./configs/.zshenv;
    home.file.".config/zsh/.zprofile".text = builtins.readFile ./configs/.zprofile;
    home.file.".config/zsh/.zshrc".text = builtins.readFile ./configs/.zshrc;
    home.file.".config/zsh/.zlogin".text = builtins.readFile ./configs/.zlogin;
    home.file.".config/zsh/.zlogout".text = builtins.readFile ./configs/.zlogout;
  };
}
