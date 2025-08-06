{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "xdirect") {
    home.packages = with pkgs; [ fish ];
    
    # 使用 builtins.readFile 读取配置文件
    home.file.".config/fish/config.fish" = {
      text = builtins.readFile ./configs/config.fish;
      force = false;  # 不强制覆盖已存在的文件
    };
    
    # 读取自定义函数
    home.file.".config/fish/functions/fish_prompt.fish" = {
      text = builtins.readFile ./configs/functions/fish_prompt.fish;
      force = false;
    };
    
    home.file.".config/fish/functions/fish_right_prompt.fish" = {
      text = builtins.readFile ./configs/functions/fish_right_prompt.fish;
      force = false;
    };
  };
}
