{pkgs, ...}: {
  # Custom packages
  raycast-linux = pkgs.callPackage ./raycast-linux {};
}
