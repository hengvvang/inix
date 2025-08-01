{
  description = "NixOS configuration with multiple hosts and users";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermmanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/";
      inputs.nixpkgs.follows = "nixpkgs";
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
      
      # 简化的用户变量配置
      userVars = {
        # 只定义用户名映射
        userName = {
          hengvvang = "hengvvang";
          zlritsu = "zlritsu";
        };
      };
      
      # 系统变量配置
      systemVars = {
        # 主机名映射
        hostName = {
          laptop = "laptop";
          work = "work";
          daily = "daily";
        };
      };
      
      makeCommonHomeModules = arch: [
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
          inherit inputs outputs userVars;
        };
      };
      
    in {
      # 导出模块和工具
      inherit lib;
      mylib = mylib;
      inherit userVars systemVars;
      system = import ./system;
      home = import ./home;
      
      # 使用 forEachSystem 生成多架构输出
      packages = forEachSystem (pkgs: {
        # 导出我们的自定义包
        raycast-linux = pkgs.raycast-linux;
        
        # 其他自定义包可以在这里添加
      });
      
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [ nixfmt alejandra ];
        };
      });
      
      formatter = forEachSystem (pkgs: pkgs.alejandra);
      
      nixosConfigurations = {
        ${systemVars.hostName.laptop} = lib.nixosSystem {
          modules = [
            ./hosts/laptop
            {
              environment.systemPackages = [ 
                zen-browser.packages.x86_64-linux.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs userVars systemVars;
          };
        };
        
        ${systemVars.hostName.work} = lib.nixosSystem {
          modules = [
            ./hosts/work
            {
              environment.systemPackages = [ 
                zen-browser.packages.aarch64-linux.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs userVars systemVars;
          };
        };
      };
      
      darwinConfigurations = {
        ${systemVars.hostName.daily} = lib.darwinSystem {
          modules = [
            ./hosts/daily
            {
              environment.systemPackages = [ 
                zen-browser.packages.aarch64-darwin.twilight
              ];
            }
          ];
          specialArgs = {
            inherit inputs outputs userVars systemVars;
          };
        };
      };
      
      homeConfigurations = {
        # laptop主机上的用户配置 (x86_64-linux)
        "${userVars.userName.hengvvang}@${systemVars.hostName.laptop}" = makeHomeConfig "x86_64-linux" (./users + "/${userVars.userName.hengvvang}") systemVars.hostName.laptop;
        "${userVars.userName.zlritsu}@${systemVars.hostName.laptop}" = makeHomeConfig "x86_64-linux" (./users + "/${userVars.userName.zlritsu}") systemVars.hostName.laptop;
        
        # daily主机上的用户配置 (aarch64-darwin)
        "${userVars.userName.hengvvang}@${systemVars.hostName.daily}" = makeHomeConfig "aarch64-darwin" (./users + "/${userVars.userName.hengvvang}") systemVars.hostName.daily;
        "${userVars.userName.zlritsu}@${systemVars.hostName.daily}" = makeHomeConfig "aarch64-darwin" (./users + "/${userVars.userName.zlritsu}") systemVars.hostName.daily;
        
        # work主机上的用户配置 (aarch64-linux)
        "${userVars.userName.hengvvang}@${systemVars.hostName.work}" = makeHomeConfig "aarch64-linux" (./users + "/${userVars.userName.hengvvang}") systemVars.hostName.work;
        "${userVars.userName.zlritsu}@${systemVars.hostName.work}" = makeHomeConfig "aarch64-linux" (./users + "/${userVars.userName.zlritsu}") systemVars.hostName.work;
      };
    };
}