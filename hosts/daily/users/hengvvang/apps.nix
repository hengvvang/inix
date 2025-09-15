{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    # inputs.zen-browser.packages.${pkgs.system}.twilight
    # pkgs.google-chrome
    pkgs.firefox

    # inputs.zed-editor.packages.${pkgs.system}.default
    pkgs.zed-editor
    pkgs.vscode

    pkgs.qq
    pkgs.wechat
    pkgs.discord
    pkgs.element-desktop
    pkgs.telegram-desktop

  ] ++ (with pkgs; [
    #
    # toolkits
    #
    nh                    # NixOS/Home Manager 助手
    nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
    nix-tree             # 查看 Nix store 依赖关系
    nixos-rebuild        # NixOS 系统重建工具
    nvd                  # Nix 版本差异比较工具
  ]) ++ (with pkgs; [
    #
    # develop
    #
    mise                 # 多语言开发环境管理工具
    just                 # 命令行任务运行工具
    devenv               # 开发环境管理工具
  ]);
}
