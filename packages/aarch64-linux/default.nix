{ pkgs, ... }: {
  # ARM64 Linux 包
  # sherlock-launcher 可能支持 ARM64 Linux
  # sherlock-launcher = pkgs.callPackage ../x86_64-linux/sherlock-launcher {};

  # 跨平台包
  # my-script = pkgs.writeShellScriptBin "my-script" ''
  #   echo "Hello from ARM64 Linux!"
  # '';
}
