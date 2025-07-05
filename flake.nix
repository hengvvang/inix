{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager, zen-browser, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        hengvvang = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop/configuration.nix
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
          ];
        };
      };
    };
}




# {
#   description = "";
# 
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     home-manager = {
#       url = github:nix-community/home-manager;
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#   };
# 
#   outputs = { nixpkgs, home-manager,  ... }:
#   let
#     system = "x86_64-linux";
#   in
#   {
#     nixosConfigurations = {
#       hengvvang = nixpkgs.lib.nixosSystem {
#         inherit system;
#         modules = [
#           ./nixos/configuration.nix
#           home-manager.nixosModules.home-manager
#           {
#             home-manager = {
#               useUserPackages = true;
#               useGlobalPkgs = true;
#               users.hengvvang = ./home-manager/home.nix;
#             };
#           }
#         ];
#       };
#     };
#   };
# }
