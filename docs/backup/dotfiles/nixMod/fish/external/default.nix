{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "external") {
    home.packages = lib.optionals config.myHome.dotfiles.fish.packageEnable (with pkgs; [ fish ]);

    # Fish Shell 完整配置文件结构
    # 主配置文件
    home.file.".config/fish/config.fish" = {
      source = ./configs/config.fish;
      # 设置为只读，确保配置文件不被意外修改
      # readonly = true;  # 可选，如果希望可以手动修改配置则注释此行
    };

    # 自定义函数目录
    home.file.".config/fish/functions" = {
      source = ./configs/functions;
      recursive = true;  # 递归复制整个目录
      # readonly = true;  # 可选
    };

    # 自动加载的配置片段目录
    home.file.".config/fish/conf.d" = {
      source = ./configs/conf.d;
      recursive = true;
      # readonly = true;  # 可选
    };

    # 自定义补全目录
    home.file.".config/fish/completions" = {
      source = ./configs/completions;
      recursive = true;
      # readonly = true;  # 可选
    };
  };
}
