{ config, lib, pkgs, ... }:

{
  # Rust 核心开发环境
  home.packages = with pkgs; [
    # Rust 核心工具链
    rustc                # Rust 编译器
    cargo                # Rust 包管理器和构建工具
    rust-analyzer        # Rust 语言服务器 (LSP)
    rustfmt              # 代码格式化工具
    clippy               # Rust 代码检查工具
    
    # 常用 Cargo 扩展
    cargo-edit           # cargo add/rm 命令
    cargo-watch          # 自动重新编译
    cargo-tree           # 依赖树显示
  ];
  
  # Rust 开发别名
  home.shellAliases = {
    # 基础 Cargo 命令
    cr = "cargo run";
    cb = "cargo build";
    ct = "cargo test";
    cc = "cargo check";
    cf = "cargo fmt";
    ccl = "cargo clippy";
    
    # 发布构建
    cbr = "cargo build --release";
    crr = "cargo run --release";
    
    # 监视模式 (需要 cargo-watch)
    cw = "cargo watch -x run";
    cwt = "cargo watch -x test";
    cwc = "cargo watch -x check";
    
    # 文档和信息
    cdo = "cargo doc --open";
    ctree = "cargo tree";
    
    # 项目管理
    cnew = "cargo new";
    cinit = "cargo init";
    cadd = "cargo add";
    crm = "cargo remove";
    
    # 清理
    cclean = "cargo clean";
    
    # 更新
    cupdate = "cargo update";
    
    # 测试相关
    ct-all = "cargo test --all-features";
    ct-doc = "cargo test --doc";
  };
}

