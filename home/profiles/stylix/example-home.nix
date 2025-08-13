# Home Manager Stylix 使用示例
{ config, lib, pkgs, ... }:

{
  # 基础用例：跟随系统配置
  myHome.profiles.stylix = {
    enable = true;
    # 所有配置跟随系统，只需启用目标应用
    targets = {
      terminals.alacritty.enable = true;  # 如果使用 Alacritty
      editors.neovim.enable = true;       # 如果使用 Neovim
      tools.tmux.enable = true;           # 如果使用 Tmux
      browsers.firefox.enable = true;     # 如果使用 Firefox
    };
  };

  # 高级用例：用户自定义主题
  # myHome.profiles.stylix = {
  #   enable = true;
  #   
  #   # 用户使用不同的壁纸和颜色方案
  #   image = ./my-wallpaper.jpg;
  #   colorScheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  #   polarity = "light";
  #   
  #   # 调整字体大小
  #   fontSize = {
  #     terminal = 14;      # 更大的终端字体
  #     applications = 12;  # 更大的应用字体
  #   };
  #   
  #   targets = {
  #     # 只为实际使用的应用启用主题
  #     terminals.alacritty.enable = true;
  #     editors.neovim.enable = true;
  #     tools = {
  #       tmux.enable = true;
  #       bat.enable = true;
  #       fzf.enable = true;
  #     };
  #     desktop = {
  #       gtk.enable = true;
  #       qt.enable = true;
  #     };
  #   };
  # };
}
