{ config, lib, pkgs, inputs, outputs, ... }:

{
  imports = [
    outputs.system
    ./hardware.nix
    ./system.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
  nix = {
    package = pkgs.nix;
    # trusted-users = [ hengvvang zlritsu ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  users.users.hengvvang = {
    isNormalUser = true;
    description = "hengvvang";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };

  users.users.zlritsu = {
    isNormalUser = true;
    description = "zlritsu";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = [
      pkgs.git
      pkgs.vim
      # inputs.zen-browser.packages.${pkgs.system}.twilight
      # pkgs.google-chrome
      # inputs.zed-editor.packages.${pkgs.system}.default
      # pkgs.zed-editor
      pkgs.vscode

      # pkgs.nh                    # NixOS/Home Manager 助手
      # pkgs.nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
      # pkgs.nix-tree             # 查看 Nix store 依赖关系
      # pkgs.nixos-rebuild        # NixOS 系统重建工具
      # pkgs.nvd                  # Nix 版本差异比较工具
  ];
  programs.fish.enable = true;
  programs.firefox.enable = true;
}
