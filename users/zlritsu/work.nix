{ config, lib, ... }:

{
  # work 主机特定配置 - zlritsu 工作环境配置
  config = lib.mkIf (config.host == "work") {
    myHome = {
      develop = {
        # 工作环境，可能需要更多开发工具
        devenv = {
          enable = false;       # zlritsu 不使用 devenv
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        # 工作可能需要的语言支持
        rust.enable = false;
        python.enable = true;   # 工作可能需要 Python
        javascript.enable = true; # 工作可能需要前端工具
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
        proxy.enable = true;    # 工作环境通常需要代理
      };
      
      profiles = {
        fonts = {
          preset = "professional";  # 专业工作字体
        };
      };
    };
  };
}
