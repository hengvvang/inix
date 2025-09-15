{ pkgs, ... }: {
  # 默认开发环境
  default = pkgs.mkShell {
    buildInputs = with pkgs; [ nixfmt alejandra ];
    shellHook = ''
      echo "🚀 NixOS 配置开发环境 (x86_64-linux)"
    '';
  };

  # Rust 开发环境 - 现代化工具链
  rust = pkgs.mkShell {
    buildInputs = with pkgs; [
      # Rust 核心工具链
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer

      # 现代化 Rust 工具
      cargo-watch        # 文件变化时自动重新编译和运行
      cargo-edit         # cargo add/rm/upgrade 命令
      cargo-audit        # 安全漏洞扫描
      cargo-outdated     # 检查过时依赖
      cargo-cache        # 管理 cargo 缓存
      cargo-expand       # 展开宏
      cargo-nextest      # 更快的测试运行器
      cargo-deny         # 依赖和许可证检查
      cargo-machete      # 检测未使用的依赖

      # 系统依赖
      pkg-config
      openssl

      # 调试和性能工具
      gdb
      valgrind
      heaptrack

      # 文档和基准测试
      mdbook            # Rust 文档生成
      criterion         # 基准测试
    ];

    # 环境变量
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    RUST_BACKTRACE = "1";

    shellHook = ''
      echo "🦀 Rust 现代化开发环境 (x86_64-linux)"
    '';
  };

  # Python 开发环境 - 最佳实践工具链
  python = pkgs.mkShell {
    buildInputs = with pkgs; [
      python3
      uv
      ruff
    ];

    # 环境变量
    PYTHONPATH = ".";
    PATH = "$(pwd)/_build/pip_packages/bin:$PATH";

    shellHook = ''
      echo "🐍 Python 开发环境 (x86_64-linux)"
    '';
  };
}
