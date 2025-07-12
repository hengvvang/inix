# Python 项目 devenv 模板
{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    mypy
    ruff  # 快速的 Python linter
  ];

  # https://devenv.sh/languages/
  languages.python = {
    enable = true;
    version = "3.11";
    venv.enable = true;
    venv.requirements = "./requirements.txt";
  };

  # https://devenv.sh/processes/
  processes = {
    dev-server.exec = "python -m http.server 8000";
  };

  # https://devenv.sh/services/
  # services.postgres.enable = true;
  # services.redis.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    format.exec = "ruff format .";
    lint.exec = "ruff check .";
    type-check.exec = "mypy .";
  };

  enterShell = ''
    echo "🐍 Python 开发环境已激活！"
    echo "虚拟环境位置: $VIRTUAL_ENV"
    echo "可用命令："
    echo "  devenv up     - 启动开发服务器"
    echo "  format        - 格式化代码"
    echo "  lint          - 检查代码质量"
    echo "  type-check    - 类型检查"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "运行 Python 测试..."
    python -m pytest
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    ruff.enable = true;
    mypy.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
