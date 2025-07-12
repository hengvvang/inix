{ config, pkgs, lib, ... }:

{
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./colors.nix
  ];

  # 根据主机类型应用不同主题
  stylix = {
    enable = true;
    autoEnable = false;  # 禁用自动启用，手动控制目标
    
    # 根据主机选择壁纸
    image = 
      if (config.host or "") == "laptop" then ./wallpapers/sea.jpg
      else if (config.host or "") == "daily" then ./wallpapers/sea.jpg
      else if (config.host or "") == "work" then ./wallpapers/sea.jpg
      else ./wallpapers/sea.jpg; # 默认壁纸
      
    # 工作环境使用深色主题
    polarity = if (config.host or "") == "work" then "dark" else "dark";
  };
}
