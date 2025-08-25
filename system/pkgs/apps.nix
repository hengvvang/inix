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
        programs.clash-verge = {
            enable = true;
            package = pkgs.clash-verge-rev;
            tunMode = true;
            # autoStart = true;
            serviceMode = true;
        };
        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
        };
    };
}
