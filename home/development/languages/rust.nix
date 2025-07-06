{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.development.languages.rust.enable {
    # Rust 开发环境 - 简化版
    home.packages = with pkgs; [
    # Rust 核心工具链
    rustc                # Rust 编译器
    cargo                # Rust 包管理器和构建工具
    rust-analyzer        # Rust 语言服务器
    rustfmt              # 代码格式化工具
    clippy               # Rust linter
  ];
  };
}

