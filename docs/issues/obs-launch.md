```
nix-shell -p obs-studio --run "env -i PATH=/run/current-system/sw/bin:/usr/bin:/bin WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR HOME=$HOME obs"
```
