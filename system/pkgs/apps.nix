{config, lib, pkgs, ...}:

{
    config = lib.mkIf config.mySystem.pkgs.apps.enable {
        environment.systemPackages = with pkgs; [

        google-chrome

        clash-verge-rev    # 代理工具（主要）
        mihomo             # Clash 内核

        # clash-nyanpasu     # 代理工具（备用）
        # webkitgtk_4_1
        # gtk3
        # glib

        # wechat

        pkgs.spotify
        #pkgs.cider-2
        pkgs.kdePackages.kdenlive

        (wrapOBS {
            plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            input-overlay
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-vaapi #optional AMD hardware acceleration
            obs-gstreamer
            obs-vkcapture
            ];
        })

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
