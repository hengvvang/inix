# Rust 项目 devenv 模板
{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    cargo-watch
    cargo-edit
    cargo-audit
    rust-analyzer
  ];

  # https://devenv.sh/languages/
  languages.rust = {
    enable = true;
    channel = "stable";
  };

  # https://devenv.sh/processes/
  processes = {
    cargo-watch.exec = "cargo watch -x check -x test -x run";
    doc-serve.exec = "cargo doc --open --no-deps";
  };

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    echo "🦀 Rust 开发环境已激活！"
    echo "可用命令："
    echo "  devenv up           - 启动所有进程"
    echo "  cargo watch         - 自动监控并运行测试"
    echo "  cargo doc --open    - 打开文档"
    echo "  hello               - 测试脚本"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "运行测试..."
    cargo test
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks.rustfmt.enable = true;
  pre-commit.hooks.clippy.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
