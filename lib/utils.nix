# Nix 工具函数库
{ inputs, architectures ? import ./architectures.nix }:

let
  inherit (inputs) nixpkgs rust-overlay;
in
rec {
  # 支持的系统架构列表
  supportedSystems = architectures;

  # 为每个系统生成 pkgs 集合
  pkgsForSystem = nixpkgs.lib.genAttrs supportedSystems (
    system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          rust-overlay.overlays.default
          (final: prev: import ../pkgs { pkgs = final; })
        ];
      }
  );

  # 为每个系统执行函数的辅助工具
  forEachSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f pkgsForSystem.${system});

  # 为特定系统获取 pkgs
  pkgsFor = system: pkgsForSystem.${system};
}
