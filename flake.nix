{
  description = "NixOS configuration with multiple hosts and users";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
  outputs = {self, nixpkgs, home-manager, zen-browser, stylix, nix-darwin, rust-overlay, ... } @ inputs:
    let
      inherit (self) outputs;
      
      # 为每个系统创建 pkgs，集成 rust-overlay
      pkgsFor = arch: import nixpkgs {
        system = arch;
        overlays = [ rust-overlay.overlays.default ];
      };
      
      # 生成通用系统模块的函数（针对 NixOS 系统）
      makeCommonSystemModules = arch: [
        stylix.nixosModules.stylix
        {
          environment.systemPackages = [ 
            zen-browser.packages.${arch}.twilight
          ];
        }
      ];
      
      # 生成通用的 Home Manager 模块列表
      makeCommonHomeModules = arch: [
        stylix.homeModules.stylix
        {
          home.packages = [ 
            zen-browser.packages.${arch}.twilight
          ];
        }
      ];
      
      # 生成通用 Darwin 模块的函数（针对 macOS 系统）
      makeCommonDarwinModules = arch: [
        stylix.darwinModules.stylix
        {
          environment.systemPackages = [ 
            zen-browser.packages.${arch}.twilight
          ];
        }
      ];
      
      # 为特定架构生成 NixOS 配置的函数
      makeNixosConfig = arch: hostPath: nixpkgs.lib.nixosSystem {
        system = arch;
        modules = [
          hostPath
        ] ++ (makeCommonSystemModules arch);
        specialArgs = {
          inherit inputs outputs;
        };
      };
      
      # 为特定架构生成 Darwin 配置的函数
      makeDarwinConfig = arch: hostPath: nix-darwin.lib.darwinSystem {
        system = arch;
        modules = [
          hostPath
        ] ++ (makeCommonDarwinModules arch);
        specialArgs = {
          inherit inputs outputs;
        };
      };
      
      # 为特定架构生成 Home Manager 配置的函数
      makeHomeConfig = arch: userPath: host: home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor arch;
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
      # 导出模块供其他 flake 使用
      system = import ./system;
      home = import ./home;
      
      nixosConfigurations = {
        # laptop - x86_64-linux
        laptop = makeNixosConfig "x86_64-linux" ./hosts/laptop;
        
        # work - aarch64-linux  
        work = makeNixosConfig "aarch64-linux" ./hosts/work;
      };
      
      # macOS 使用 nix-darwin，不是 nixosConfigurations
      darwinConfigurations = {
        # daily - aarch64-darwin (需要 nix-darwin)
        daily = makeDarwinConfig "aarch64-darwin" ./hosts/daily;
      };
      
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