{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "xdirect") {
    home.packages = lib.optionals config.myHome.dotfiles.starship.packageEnable (with pkgs; [ starship ]);

    home.file.".config/starship.toml" = {
      text = builtins.readFile ./configs/starship.toml;
      force = false;  # 不强制覆盖已存在的文件
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
