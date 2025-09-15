{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.twilight
    # pkgs.qutebrowser
    pkgs.google-chrome
    # pkgs.firefox

    # inputs.zed-editor.packages.${pkgs.system}.default
    pkgs.zed-editor
    pkgs.vscode

    pkgs.qq
    pkgs.wechat

    pkgs.mise
    pkgs.just
    pkgs.devenv

    # Nix toolkits
    pkgs.nh                    # NixOS/Home Manager 助手
    pkgs.nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
    pkgs.nix-tree             # 查看 Nix store 依赖关系
    pkgs.nixos-rebuild        # NixOS 系统重建工具
    pkgs.nvd                  # Nix 版本差异比较工具
  ];
}
