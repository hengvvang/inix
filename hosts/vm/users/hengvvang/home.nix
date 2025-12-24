{ config, pkgs, lib, inputs, outputs, ... }:

{
  myHome = {
    desktop = {
      enable = true;
      preset = "gnome";
    };

    dotfiles = {
      enable = true;
      zsh = {
        enable = true;
        style = "nixStyle";
      };
      fish = {
        enable = true;
        style = "nixStyle";
      };
      starship = {
        enable = true;
        style = "nixStyle";
      };
      ghostty = {
        enable = true;
        style = "nixStyle";
      };
      yazi = {
        enable = true;
        style = "copyStyle";
      };
      zellij = {
        enable = true;
        style = "copyStyle";
      };
    };

    develop = {
      enable = true;
      devenv = {
        enable = true;
        autoSwitch = true;    # 启用自动环境切换（direnv）
        shell = "fish";
        templates = true;     # 安装项目模板工具（完整功能）
        cache = true;         # 启用构建缓存优化
      };
    };

    profiles = {
      enable = true;
      fonts = {
        enable = true;
        preset = "zen";
      };
    };
  };
}
