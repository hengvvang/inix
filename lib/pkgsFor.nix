# 用于生成多架构 pkgs 集合
{ inputs, architectures ? import ./architectures.nix }:

let
  inherit (inputs) nixpkgs rust-overlay;
in
nixpkgs.lib.genAttrs architectures (
  system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        rust-overlay.overlays.default
        (final: prev: import ../pkgs { pkgs = final; })
      ];
    }
)
