{pkgs, ...}: {
  # Custom packages
  raycast-linux = pkgs.callPackage ./raycast-linux {};
  sherlock-launcher = pkgs.callPackage ./sherlock-launcher {};
}
