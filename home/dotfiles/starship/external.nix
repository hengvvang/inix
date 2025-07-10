{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "external") {
    # 方式3: 外部文件引用
    home.file.".config/starship.toml".source = ./configs/starship.toml;
    
    # 确保 starship 包已安装
    home.packages = with pkgs; [ starship ];
    
    # 为各个 Shell 启用 Starship
    programs.bash.enable = true;
    programs.bash.initExtra = ''
      eval "$(starship init bash)"
    '';
    
    programs.zsh.enable = true;
    programs.zsh.initExtra = ''
      eval "$(starship init zsh)"
    '';
    
    programs.fish.enable = true;
    programs.fish.interactiveShellInit = ''
      starship init fish | source
    '';
    
    # 注意: Nushell 的 Starship 初始化需要在其配置文件中设置
  };
}
