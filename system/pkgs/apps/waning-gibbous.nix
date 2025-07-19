# 🌖 亏凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.waningGibbous.enable {
    environment.systemPackages = with pkgs; [

      vim
      git
      nano
      rio
      yazi
      zellij
      vscode
      zed-editor
      # Nix 系统管理工具
      nh                    # NixOS/Home Manager 助手
      nom                   # NixOS 选项管理工具
      nix-output-monitor    # 美化 Nix 构建输出 (nom)
      nix-tree             # 查看 Nix store 依赖关系
      nixos-rebuild        # NixOS 系统重建工具
      nvd                  # Nix 版本差异比较工具
    ];
    
    # NH 配置
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/hengvvang/inix";
    };
  };
}
