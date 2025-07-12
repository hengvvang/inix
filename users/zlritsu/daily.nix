{ config, lib, ... }:

{
  # daily 主机特定配置 - zlritsu 日常使用配置
  config = lib.mkIf (config.host == "daily") {
    myHome = {
      develop = {
        # 日常使用，基础开发配置
        devenv = {
          enable = false;       # zlritsu 不使用 devenv
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        # 基础语言支持
        rust.enable = false;
        python.enable = true;   # 日常可能需要 Python 脚本
        javascript.enable = false;
        typescript.enable = false;
        cpp.enable = false;
      };
      
      dotfiles = {
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
        proxy.enable = true;    # 日常使用可能需要代理
      };
      
      profiles = {
        fonts = {
          preset = "comfort";   # 日常使用舒适字体
        };
      };
    };
  };
}
