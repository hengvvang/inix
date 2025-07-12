{ config, lib, ... }:

{
  # laptop 主机特定配置
  config = lib.mkIf (config.host == "laptop") {
    myHome = {
      develop = {
        # devenv 项目环境管理配置
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = true;     # 安装项目模板工具（完整功能）
          cache = true;         # 启用构建缓存优化
        };
        # 按语言直接配置
        rust = {
          enable = true;
          embedded.enable = true;   # 启用 Rust 嵌入式开发
        };
        python.enable = true;
        javascript.enable = true;
        typescript.enable = true;
        cpp = {
          enable = true;
          embedded.enable = true;   # 启用 C/C++ 嵌入式开发
        };
      };
      
      dotfiles = {
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
        proxy.enable = false;
      };
      
      profiles = {
        fonts = {
          preset = "bauhaus";
        };
      };
    };
  };
}
