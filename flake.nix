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
      hostMapping = {
        host1 = "laptop";
        host2 = "work";
        host3 = "daily";
      };
      userMapping = {
        user1 = "hengvvang";
        user2 = "zlritsu";
      };
    in {
      # 导出模块和工具
      inherit lib;
      inherit userMapping hostMapping;
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
        ${hostMapping.host1} = lib.nixosSystem {
          modules = [
            ./hosts/host1
          ];
          specialArgs = {
            inherit inputs outputs userMapping hostMapping;
          };
        };
        ${hostMapping.host2} = lib.nixosSystem {
          modules = [
            ./hosts/host2
          ];
          specialArgs = {
            inherit inputs outputs userMapping hostMapping;
          };
        };
      };

      darwinConfigurations = {
        ${hostMapping.host3} = lib.darwinSystem {
          modules = [
            ./hosts/host3
          ];
          specialArgs = {
            inherit inputs outputs userMapping hostMapping;
          };
        };
      };

      homeConfigurations = {
        # laptop主机上的用户配置 (x86_64-linux)
        "${userMapping.user1}@${hostMapping.host1}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./users/user1
          ];
          extraSpecialArgs = {
            inherit inputs outputs userMapping hostMapping;
            hostInstance = hostMapping.host1;
          };
        };
        "${userMapping.user2}@${hostMapping.host1}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./users/user2
          ];
          extraSpecialArgs = {
            inherit inputs outputs userMapping hostMapping;
            hostInstance = hostMapping.host1;
          };
        };

        # daily主机上的用户配置 (aarch64-darwin)
        "${userMapping.user1}@${hostMapping.host3}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./users/user1
          ];
          extraSpecialArgs = {
            inherit inputs outputs userMapping hostMapping;
            hostInstance = hostMapping.host3;
          };
        };
        "${userMapping.user2}@${hostMapping.host3}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            ./users/user2
          ];
          extraSpecialArgs = {
            inherit inputs outputs userMapping hostMapping;
            hostInstance = hostMapping.host3;
          };
        };

        # work主机上的用户配置 (aarch64-linux)
        "${userMapping.user1}@${hostMapping.host2}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./users/user1
          ];
          extraSpecialArgs = {
            inherit inputs outputs userMapping hostMapping;
            hostInstance = hostMapping.host2;
          };
        };
        "${userMapping.user2}@${hostMapping.host2}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./users/user2
          ];
          extraSpecialArgs = {
            inherit inputs outputs userMapping hostMapping;
            hostInstance = hostMapping.host2;
          };
        };
      };
    };
}
