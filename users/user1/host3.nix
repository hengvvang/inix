{ config, lib, hosts, ... }:

{
  # host3 主机特定配置
  config = lib.mkIf (config.host == hosts.host3) {
    myHome = {
      develop = {
        enable = true;
        devenv = {
          enable = true;        # 启用 devenv
          autoSwitch = true;    # 启用自动环境切换（direnv）
          shell = "fish";       # 使用 fish shell
          templates = false;    # 轻量级配置，不安装额外模板工具
          cache = true;         # 启用构建缓存优化
        };
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
          preset = "bauhaus";
        };
      };
    };
  };
}
