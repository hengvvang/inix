{ inputs, architectures ? import ./architectures.nix }:
let
  inherit (inputs) nixpkgs rust-overlay;
  pkgsFor = import ./pkgsFor.nix { inherit inputs architectures; };
in
{
  inherit architectures pkgsFor;
  forEachSystem = f: nixpkgs.lib.genAttrs architectures (arch: f pkgsFor.${arch});
}
