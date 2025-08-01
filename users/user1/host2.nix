{ config, lib, hosts, ... }:

{
  # host2 主机特定配置
  config = lib.mkIf (config.host == hosts.host2) {
    myHome = {
      develop = {
        enable = true;
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = false;    # 工作环境轻量级配置
          cache = true;         # 启用构建缓存优化
        };
        # 工作环境的开发配置
        rust.enable = true;
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp.enable = true;
      };
      
      dotfiles = {
        enable = true;

        vim.enable = true;
        zsh.enable = true;
        bash.enable = true;
        fish.enable = true;
        nushell.enable = true;
        yazi.enable = true;
        ghostty.enable = true;
        alacritty.enable = true;
        tmux.enable = true;
        git.enable = true;
        lazygit.enable = true;
        starship.enable = true;
      };
      
      profiles = {
        enable = true;
        fonts = {
          preset = "tokyo";  # 专业字体配置
        };

        stylix = {
          enable = false;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "sea";
          };
          fonts = {
            enable = true;
            # 使用默认字体配置，也可以自定义
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;  # 避免与现有 alacritty 配置冲突
              kitty.enable = true;
            };
            editors = {
              vim.enable = true;
              neovim.enable = true;
            };
            tools = {
              tmux.enable = true;
              bat.enable = true;
              fzf.enable = true;
            };
            desktop = {
              gtk.enable = true;
            };
            browsers = {
              firefox.enable = true;
            };
          };
        };
      };
    };
  };
}
