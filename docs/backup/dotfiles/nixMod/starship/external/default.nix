{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "external") {
    home.packages = lib.optionals config.myHome.dotfiles.starship.packageEnable (with pkgs; [ starship ]);

    home.file.".config/starship.toml" = {
      source = ./configs/starship.toml;
      # 设置为只读，确保配置文件不被意外修改
      # readonly = true;  # 可选，如果希望可以手动修改配置则注释此行
    };

    # 为各个 Shell 启用 Starship (可选)
    programs.bash.enable = true;
    programs.bash.initExtra = ''
      eval "$(starship init bash)"
    '';

    programs.zsh.enable = true;
    programs.zsh.initExtra = ''
      eval "$(starship init zsh)"
    '';

    programs.fish.enable = true;
    programs.fish.shellInit = ''
      starship init fish | source
    '';
  };
}
