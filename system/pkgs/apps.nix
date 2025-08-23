{config, lib, pkgs, inputs, ...}:

{
    config = lib.mkIf config.mySystem.pkgs.apps.enable {
        environment.systemPackages = [
            pkgs.git
            pkgs.vim

            # pkgs.clash-verge-rev

            # inputs.zen-browser.packages.${pkgs.system}.twilight
            # pkgs.google-chrome

            # inputs.zed-editor.packages.${pkgs.system}.default
            # pkgs.zed-editor
            # pkgs.vscode
        ];

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        };
    };
}
