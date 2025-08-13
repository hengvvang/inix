{ config, lib, hosts, ... }:

{
  # host2 主机特定配置 - user2 工作环境配置
  config = lib.mkIf (config.host == hosts.host2) {
    myHome = {
      develop = {
        enable = true;

        devenv = {
          enable = false;
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        rust.enable = false;
        python.enable = true;
        javascript.enable = true;
        typescript.enable = false;
        cpp.enable = false;
      };
      
      dotfiles = {
        enable = true;

        vim.enable = true;
        zsh.enable = false;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = false;
        yazi.enable = true;
        ghostty.enable = false;
        alacritty.enable = false;
        tmux.enable = false;
        git.enable = true;
        lazygit.enable = false;
        starship.enable = true;
      };
      
      profiles = {
        enable = true;

        fonts = {
          preset = "nordic";
        };
        stylix = {
          enable = true;
          # user2 在 work 主机上的配置
          fontSize = {
            applications = 10;  # 较小的字体适合工作环境
            terminal = 11;
          };
          targets = {
            editors.vim.enable = true;        # 使用 vim
            desktop.gtk.enable = true;        # GTK 应用主题
            browsers.firefox.enable = true;   # 使用 Firefox
            # 其他应用跟随自动检测
          };
        };
      };
    };
  };
}
