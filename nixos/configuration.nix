{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # boot.kernelModules = [ "tun"];


  networking.hostName = "hengvvang"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-gtk
        fcitx5-rime
        fcitx5-nord
       ];
  };


  # 启用 NVIDIA 闭源驱动
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;               # 使用闭源驱动
    nvidiaSettings = true;      # 安装 nvidia-settings 图形工具
  };


  

# ------ Plasma ------
  # services = {
  #   desktopManager.plasma6.enable = true;
  #   displayManager.sddm.enable = true;
  #   displayManager.sddm.wayland.enable = true;
  # };

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   plasma-browser-integration # Comment out this line if you use KDE Connect
  #   kdepim-runtime # Unneeded if you use Thunderbird, etc.
  #   konsole # Comment out this line if you use KDE's default terminal app
  #   oxygen
  # ];

# ------ Gnome ------
  #  --- before---
  # services.xserver = {
  #   enable = true; 
  #   displayManager.gdm.enable = true; 
  #   desktopManager.gnome.enable = true; 
  # }
  #  --- now ---
  # services = {
  #   desktopManager.gnome.enable = true;
  #   displayManager.gdm.enable = true;
  # };

# ----- cosmic ----- 
  services = {
     displayManager.cosmic-greeter.enable = true;
     desktopManager.cosmic.enable = true;
     desktopManager.cosmic.xwayland.enable = true;
  };
  # environment.cosmic.excludePackages = [
  #    pkgs.cosmic-player
  # ];
# --------------------



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;   # Uncomment the following line if you want to use JACK applications
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hengvvang = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
 

  # home-manager.users.hengvvang = { pkgs, ...} : {
  #       home.packages = [ pkgs.atool pkgs.httpie ];
  #       home.stateVersion = "25.05";
  # };
  # home-manager = {
  #       useGlobalPkgs = true;
  #       useUserPackages = true;
  #       users.hengvvang = import ./home.nix;
  # };

  programs.fish.enable = true;
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
   pkgs.wget
   pkgs.wpsoffice-cn
   pkgs.vim
   pkgs.wget
   pkgs.firefox
   pkgs.clash-verge-rev 
   pkgs.zed-editor
   pkgs.vscode
   pkgs.google-chrome
   pkgs.shadowsocks-rust
   pkgs.spotify
   pkgs.obs-studio 
   pkgs.qq
   pkgs.wechat-uos
   pkgs.fish
   pkgs.git
   pkgs.rustup
   pkgs.htop
   pkgs.docker
   pkgs.telegram-desktop
   pkgs.discord
   pkgs.yazi
   pkgs.wezterm
   pkgs.ghostty
   pkgs.steam
   pkgs.nushell
   pkgs.fishPlugins.pure
   pkgs.nushellPlugins.gstat

   # ---- gnome extentsion ----
   # pkgs.gnome-tweaks # required
   # pkgs.gnomeExtensions.user-themes
   # pkgs.gnomeExtensions.blur-my-shell
   # pkgs.gnomeExtensions.extension-list
   # pkgs.gnomeExtensions.dash-to-dock
   # pkgs.gnomeExtensions.logo-menu
   # pkgs.gnomeExtensions.clipboard-indicator
   # pkgs.gnomeExtensions.caffeine
   # pkgs.gnomeExtensions.kimpanel # fcitx need;   recommand extension: Fcitx HUD  

   # ---- kde plasma packages ----
   # kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
   # kdePackages.kcalc # Calculator
   # kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
   # kdePackages.kcolorchooser # A small utility to select a color
   # kdePackages.kolourpaint # Easy-to-use paint program
   # kdePackages.ksystemlog # KDE SystemLog Application
   # kdePackages.sddm-kcm # Configuration module for SDDM
   # kdiff3 # Compares and merges 2 or 3 files or directories
   # hardinfo2 # System information and benchmarks for Linux systems
   # haruna # Open source video player built with Qt/QML and libmpv
   # xclip # Tool to access the X clipboard from a console application
  ];  



  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;


  # nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  #      				      "https://mirrors.ustc.edu.cn/nix-channels/store"
  # ];

  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

