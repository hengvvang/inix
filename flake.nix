{
  description = "";

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
  };
  outputs = {self, nixpkgs, home-manager, zen-browser, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop/system.nix
            {
            environment.systemPackages = [ 
              zen-browser.packages.${system}.twilight
            ];
            }
          ];
        };
      };
      homeConfigurations = {
        hengvvang = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/laptop/home.nix
            {
              user = "hengvvang";  # 设置用户类型
            }
          ];
        };
        zlritsu = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/laptop/home.nix
            {
              user = "zlritsu";    # 设置用户类型
            }
          ];
        };
      };
    };
}