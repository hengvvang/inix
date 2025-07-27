{
  description = "NixOS configuration with multiple hosts and users";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:hengvvang/zen-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager, systems, zen-browser, stylix, nix-darwin, rust-overlay, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      
      # 使用 systems 像 examples 一样
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ rust-overlay.overlays.default ];
          }
      );
      
      # 保留 makeCommonHomeModules - 为 Home Manager 提供通用模块
      makeCommonHomeModules = arch: [
        {
          home.packages = [ 
            zen-browser.packages.${arch}.twilight
          ];
        }
      ];
      
      # 保留 makeHomeConfig - 因为用户配置确实都一样
      makeHomeConfig = arch: userPath: host: home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor.${arch};
        modules = [
          userPath
          {
            inherit host;
          }
        ] ++ (makeCommonHomeModules arch);
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
      
    in {
      # 导出模块和工具
      inherit lib;
      system = import ./system;
      home = import ./home;
      
      # 使用 forEachSystem 生成多架构输出
      packages = forEachSystem (pkgs: {
        # 你的自定义包
      });
      
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [ nixfmt alejandra ];
        };
      });
      
      formatter = forEachSystem (pkgs: pkgs.alejandra);
      
      # 直接定义系统配置，减少复杂度
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          modules = [
            ./hosts/laptop
            {
              environment.systemPackages = [ 
                zen-browser.packages.x86_64-linux.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        
        work = lib.nixosSystem {
          modules = [
            ./hosts/work
            {
              environment.systemPackages = [ 
                zen-browser.packages.aarch64-linux.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
      
      # macOS 使用 nix-darwin，不是 nixosConfigurations
      darwinConfigurations = {
        daily = nix-darwin.lib.darwinSystem {
          modules = [
            ./hosts/daily
            {
              environment.systemPackages = [ 
                zen-browser.packages.aarch64-darwin.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
      
      # 使用 makeHomeConfig 和 makeCommonHomeModules
      homeConfigurations = {
        # laptop主机上的用户配置 (x86_64-linux)
        "hengvvang@laptop" = makeHomeConfig "x86_64-linux" ./users/hengvvang "laptop";
        "zlritsu@laptop" = makeHomeConfig "x86_64-linux" ./users/zlritsu "laptop";
        
        # daily主机上的用户配置 (aarch64-darwin)
        "hengvvang@daily" = makeHomeConfig "aarch64-darwin" ./users/hengvvang "daily";
        "zlritsu@daily" = makeHomeConfig "aarch64-darwin" ./users/zlritsu "daily";
        
        # work主机上的用户配置 (aarch64-linux)
        "hengvvang@work" = makeHomeConfig "aarch64-linux" ./users/hengvvang "work";
        "zlritsu@work" = makeHomeConfig "aarch64-linux" ./users/zlritsu "work";
      };
    };
}