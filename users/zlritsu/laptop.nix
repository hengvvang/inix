{ config, lib, ... }:

{
  # laptop 主机特定配置 - zlritsu 轻量级配置
  config = lib.mkIf (config.host == "laptop") {
    myHome = {
      develop = {
        # 基础开发配置，不启用重型工具
        devenv = {
          enable = false;       # zlritsu 不使用 devenv
          autoSwitch = false;
          shell = "fish";
          templates = false;
          cache = false;
        };
        # 基础语言支持
        rust.enable = false;    # zlritsu 不开发 Rust
        python.enable = true;   # 基础 Python 支持
        javascript.enable = false;
        typescript.enable = false;
        cpp.enable = false;
      };
      
      dotfiles = {
        vim.enable = true;
        zsh.enable = false;     # zlritsu 只用 fish
        bash.enable = true;     # 保留基础 bash
        fish.enable = true;
        nushell.enable = false; # 轻量级配置
        yazi.enable = true;     # 文件管理器
        ghostty.enable = false; # 使用系统默认终端
        alacritty.enable = false;
        tmux.enable = false;    # 不使用 tmux
        git.enable = true;      # 基础 git
        lazygit.enable = false; # 不使用图形化 git
        starship.enable = true; # 保留美观的提示符
        proxy.enable = false;
      };
      
      profiles = {
        fonts = {
          preset = "minimal";   # 轻量级字体配置
        };
      };
    };
  };
}
