{
  description = "NixOS configuration with multiple hosts and users";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/";
    };
    nix-sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sherlock = {
        url = "github:Skxxtz/sherlock";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    zed-editor = {
        url = "github:zed-industries/zed";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
        url = "github:YaLTeR/niri";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, stylix, nix-darwin, rust-overlay, sherlock, zed-editor, hyprland, niri, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib // nix-darwin.lib;
    in {
      # 导出模块和工具
      inherit lib;
      system = import ./system;
      home = import ./home;

      packages = import ./packages {
        inherit inputs outputs;
      };

      devShells = import ./devshells {
        inherit inputs outputs;
      };

      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
        aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      };

      nixosConfigurations = {
        laptop = lib.nixosSystem {
          modules = [
            ./hosts/laptop
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "laptop";
            user1 = "hengvvang";
            user2 = "rosenzwy";
          };
        };
        work = lib.nixosSystem {
          modules = [
            ./hosts/work
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "work";
            user1 = "hengvvang";
            user2 = "zlritsu";
          };
        };
        vm = lib.nixosSystem {
          modules = [
            ./hosts/vm
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "vm";
            user1 = "hengvvang";
            user2 = "zlritsu";
          };
        };
      };

      darwinConfigurations = {
        daily = lib.darwinSystem {
          modules = [
            ./hosts/daily
          ];
          specialArgs = {
            inherit inputs outputs;
            hostName = "daily";
            user1 = "hengvvang";
            user2 = "zlritsu";
          };
        };
      };

      homeConfigurations = {
        # laptop主机上的用户配置 (x86_64-linux)
        "laptop@hengvvang" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/laptop/users/hengvvang
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "hengvvang";
          };
        };
        "laptop@rosenzwy" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/laptop/users/rosenzwy
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "rosenzwy";
          };
        };

        # work主机上的用户配置 (aarch64-linux)
        "work@hengvvang" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./hosts/work/users/hengvvang
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "hengvvang";
          };
        };
        "work@zlritsu" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./hosts/work/users/zlritsu
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "zlritsu";
          };
        };

        # daily主机上的用户配置 (aarch64-darwin)
        "daily@hengvvang" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./hosts/daily/users/hengvvang
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "hengvvang";
          };
        };
        "daily@zlritsu" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./hosts/daily/users/zlritsu
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "zlritsu";
          };
        };

        "vm@hengvvang" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/vm/users/hengvvang
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "hengvvang";
          };
        };
        "vm@zlritsu" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/vm/users/zlritsu
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "zlritsu";
          };
        };
        #
        # wsl
        #
        "wsl-archlinux@hengvvang" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/wsl/archlinux/users/hengvvang
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "hengvvang";
          };
        };
        "wsl-archlinux@rosenzwy" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/wsl/archlinux/users/rosenzwy
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "rosenzwy";
          };
        };
        "wsl-ubuntu@hengvvang" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/wsl/ubuntu/users/hengvvang
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "hengvvang";
          };
        };
        "wsl-ubuntu@rosenzwy" = lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./hosts/wsl/ubuntu/users/rosenzwy
          ];
          extraSpecialArgs = {
            inherit inputs outputs;
            userName = "rosenzwy";
          };
        };
    };
  };
}
