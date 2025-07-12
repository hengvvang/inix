{ config, lib, ... }:

{
  # work 主机特定配置
  config = lib.mkIf (config.host == "work") {
    myHome = {
      develop = {
        # devenv 项目环境管理配置 - work 主机
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
        proxy.enable = true;        # 工作环境可能需要代理
      };
      
      profiles = {
        fonts = {
          preset = "tokyo";  # 专业字体配置
        };
      };
    };
  };
}
