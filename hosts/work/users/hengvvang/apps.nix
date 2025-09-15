{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    pkgs.google-chrome
    pkgs.firefox

    pkgs.zed-editor
    pkgs.vscode
  ] ++ (with pkgs; [
    #
    # toolkits
    #
    nh                    # NixOS/Home Manager 助手
    nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
    nix-tree             # 查看 Nix store 依赖关系
    nixos-rebuild        # NixOS 系统重建工具
    nvd                  # Nix 版本差异比较工具
  ]);
}
