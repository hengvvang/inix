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
      url = "github:hengvvang/zen-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, stylix, nix-darwin, rust-overlay, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib // nix-darwin.lib;
      mylib = import ./lib {
        inherit inputs;
      };
      inherit (mylib) supportedSystems pkgsForSystem forEachSystem;

      users = {
        user1 = "hengvvang";
        user2 = "zlritsu";
      };

      hosts = {
        host1 = "laptop";
        host2 = "work";
        host3 = "daily";
      };

      makeCommonHomeModules = arch: [
        stylix.homeManagerModules.stylix
        {
          home.packages = [
            zen-browser.packages.${arch}.twilight
          ];
        }
      ];

      makeHomeConfig = arch: userPath: host: home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsForSystem.${arch};
        modules = [
          userPath
          {
            inherit host;
          }
        ] ++ (makeCommonHomeModules arch);
        extraSpecialArgs = {
          inherit inputs outputs users hosts;
        };
      };

    in {
      # 导出模块和工具
      inherit lib;
      mylib = mylib;
      inherit users hosts;
      system = import ./system;
      home = import ./home;

      # 使用 forEachSystem 生成多架构输出
      packages = forEachSystem (pkgs: {
        # 导出我们的自定义包
        raycast-linux = pkgs.raycast-linux;
        sherlock-launcher = pkgs.sherlock-launcher;

        # 其他自定义包可以在这里添加
      });

      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [ nixfmt alejandra ];
        };
      });

      formatter = forEachSystem (pkgs: pkgs.alejandra);

      nixosConfigurations = {
        ${hosts.host1} = lib.nixosSystem {
          modules = [
            ./hosts/host1
            stylix.nixosModules.stylix
            {
              environment.systemPackages = [
                zen-browser.packages.x86_64-linux.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs users hosts;
          };
        };

        ${hosts.host2} = lib.nixosSystem {
          modules = [
            ./hosts/host2
            stylix.nixosModules.stylix
            {
              environment.systemPackages = [
                zen-browser.packages.aarch64-linux.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs users hosts;
          };
        };
      };

      darwinConfigurations = {
        ${hosts.host3} = lib.darwinSystem {
          modules = [
            ./hosts/host3
            stylix.darwinModules.stylix
            {
              environment.systemPackages = [
                zen-browser.packages.aarch64-darwin.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs users hosts;
          };
        };
      };

      homeConfigurations = {
        # laptop主机上的用户配置 (x86_64-linux)
        "${users.user1}@${hosts.host1}" = makeHomeConfig "x86_64-linux" ./users/user1 hosts.host1;
        "${users.user2}@${hosts.host1}" = makeHomeConfig "x86_64-linux" ./users/user2 hosts.host1;

        # daily主机上的用户配置 (aarch64-darwin)
        "${users.user1}@${hosts.host3}" = makeHomeConfig "aarch64-darwin" ./users/user1 hosts.host3;
        "${users.user2}@${hosts.host3}" = makeHomeConfig "aarch64-darwin" ./users/user2 hosts.host3;

        # work主机上的用户配置 (aarch64-linux)
        "${users.user1}@${hosts.host2}" = makeHomeConfig "aarch64-linux" ./users/user1 hosts.host2;
        "${users.user2}@${hosts.host2}" = makeHomeConfig "aarch64-linux" ./users/user2 hosts.host2;
      };
    };
}
