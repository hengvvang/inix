{ inputs, outputs, ... }:
let
  inherit (inputs) nixpkgs;
in {
  # 直接为每个架构导入包定义
  x86_64-linux = import ./x86_64-linux {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  };

  aarch64-linux = import ./aarch64-linux {
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
  };

  aarch64-darwin = import ./aarch64-darwin {
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  };
}
