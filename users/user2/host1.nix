{ config, lib, hosts, ... }:

{
  # host1 主机特定配置 - user2 轻量级配置
  config = lib.mkIf (config.host == hosts.host1) {
    myHome = {

      pkgs = {
        enable = true;
        apps.enable = true;
        toolkits.enable = true;
        workflows.enable = true;
      };

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
        javascript.enable = false;
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
        qutebrowser.enable = true;
      };
      

      profiles = {
        enable = true;
        
        fonts = {
          preset = "zen";   # 简洁专注的字体配置
        };
        stylix = {
          enable = true;
          # 跟随系统配置，仅配置用户级目标
          targets = {
            # 基于实际使用的应用启用主题
            editors.vim.enable = true;      # user2 使用 vim
            tools.bat.enable = false;       # 不使用 bat
            desktop.gtk.enable = true;      # GTK 应用主题
            browsers.qutebrowser.enable = true; # 使用 qutebrowser
            others = {
              rofi.enable = false;          # 不使用 rofi
              mako.enable = false;          # 不使用 mako
            };
          };
        };
      };
    };
  };
}
