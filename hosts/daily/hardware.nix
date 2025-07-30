# your hardware-configuration.nix
# if you use disko : please configure the corresponding configuration in disko :
# ```
# fileSystems."/" =
#   { device = "/dev/disk/by-uuid/7b48b3c8-91aa-49ed-9f93-9619d77948fa";
#     fsType = "btrfs";
#     options = [ "subvol=@" ];
#   };

# fileSystems."/boot" =
#   { device = "/dev/disk/by-uuid/38ED-9FE2";
#     fsType = "vfat";
#     options = [ "fmask=0077" "dmask=0077" ];
#   };

# swapDevices =
#   [ { device = "/dev/disk/by-uuid/4038dac9-ff87-432c-9589-0baf46d575e5"; }
#   ];
# ```
