{config, lib, pkgs, inputs, ...}:

{
    config = lib.mkIf config.mySystem.pkgs.apps.enable {
        environment.systemPackages = with pkgs; [
            inputs.zen-browser.packages.${pkgs.system}.twilight

            pkgs.google-chrome
            pkgs.clash-verge-rev
            pkgs.git
            pkgs.vim
            # 浏览器
            # pkgs.zed-editor
            # pkgs.vscode

            # pkgs.rio
            # pkgs.zellij
            # pkgs.rmpc
            # pkgs.yazi

            pkgs.mise
            pkgs.just
            pkgs.devenv

            # pkgs.wechat
            # pkgs.qq
            # pkgs.spotify
            pkgs.kdePackages.kdenlive

            (pkgs.wrapOBS {
                plugins = with pkgs.obs-studio-plugins; [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
                obs-vaapi #optional AMD hardware acceleration
                obs-gstreamer
                obs-vkcapture
                ];
            })

            # Nix 系统管理工具
            pkgs.nh                    # NixOS/Home Manager 助手
            pkgs.nom                   # NixOS 选项管理工具
            pkgs.nix-output-monitor    # 美化 Nix 构建输出 (nom)
            pkgs.nix-tree             # 查看 Nix store 依赖关系
            pkgs.nixos-rebuild        # NixOS 系统重建工具
            pkgs.nvd                  # Nix 版本差异比较工具
        ];

        # NH 配置
        # programs.nh = {
        #     enable = true;
        #     clean.enable = true;
        #     clean.extraArgs = "--keep-since 4d --keep 3";
        #     flake = "path/to/flake.nix";  # Replace with your actual flake path
        # };

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        };
    };
}
