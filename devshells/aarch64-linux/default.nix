{ pkgs, ... }: {
  # 默认开发环境
  default = pkgs.mkShell {
    buildInputs = with pkgs; [ nixfmt alejandra ];
    shellHook = ''
      echo "🚀 NixOS 配置开发环境 (aarch64-linux)"
    '';
  };

  # Rust 开发环境
  rust = pkgs.mkShell {
    buildInputs = with pkgs; [
      rustc cargo rustfmt rust-analyzer clippy
      pkg-config openssl
    ];
    shellHook = ''
      echo "🦀 Rust 开发环境 (aarch64-linux)"
    '';
  };

  # Python 开发环境
  python = pkgs.mkShell {
    buildInputs = with pkgs; [
      python3 python3Packages.pip python3Packages.poetry
      python3Packages.pytest python3Packages.black
    ];
    shellHook = ''
      echo "🐍 Python 开发环境 (aarch64-linux)"
    '';
  };
}
