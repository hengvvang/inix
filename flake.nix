{
  description = "NixOS configuration with multiple hosts and users";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:hengvvang/zen-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager, zen-browser, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      # 定义通用系统模块列表，可被多个主机配置共享
      commonSystemModules = [
        {
          environment.systemPackages = [ 
            zen-browser.packages.${system}.twilight
          ];
        }
      ];
      
      # 定义通用的 Home Manager 模块列表
      commonHomeModules = [
        stylix.homeModules.stylix
      ];
    in {
      nixosConfigurations = {
        # 现有的笔记本配置
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop/system.nix
          ] ++ commonSystemModules;
        };
        
        # 新增日常使用主机配置
        daily = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/daily/system.nix
          ] ++ commonSystemModules;
        };
        
        # 新增工作主机配置
        work = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/work/system.nix
          ] ++ commonSystemModules;
        };
      };
      
      homeConfigurations = {
        # laptop主机上的用户配置
        "hengvvang@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/hengvvang
            {
              host = "laptop";
            }
          ] ++ commonHomeModules;
        };
        
        "zlritsu@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/zlritsu
            {
              host = "laptop";
            }
          ] ++ commonHomeModules;
        };
        
        # daily主机上的用户配置
        "hengvvang@daily" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/hengvvang
            {
              host = "daily";
            }
          ] ++ commonHomeModules;
        };
        
        "zlritsu@daily" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/zlritsu
            {
              host = "daily";
            }
          ] ++ commonHomeModules;
        };
        
        # work主机上的用户配置
        "hengvvang@work" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/hengvvang
            {
              host = "work";
            }
          ] ++ commonHomeModules;
        };
        
        "zlritsu@work" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/zlritsu
            {
              host = "work";
            }
          ] ++ commonHomeModules;
        };
      };
    };
}