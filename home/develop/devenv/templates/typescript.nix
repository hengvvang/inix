# Node.js/TypeScript 项目 devenv 模板
{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
  ];

  # https://devenv.sh/languages/
  languages.javascript = {
    enable = true;
    npm.enable = true;
    npm.install.enable = true;
  };

  languages.typescript.enable = true;

  # https://devenv.sh/processes/
  processes = {
    dev-server.exec = "npm run dev";
    type-check.exec = "npm run type-check";
  };

  # https://devenv.sh/services/
  # services.postgres.enable = true;
  # services.redis.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    build.exec = "npm run build";
    test.exec = "npm test";
    lint.exec = "npm run lint";
    format.exec = "npm run format";
  };

  enterShell = ''
    echo "📦 Node.js/TypeScript 开发环境已激活！"
    echo "Node.js 版本: $(node --version)"
    echo "npm 版本: $(npm --version)"
    echo "可用命令："
    echo "  devenv up     - 启动开发服务器"
    echo "  build         - 构建项目"
    echo "  test          - 运行测试"
    echo "  lint          - 检查代码质量"
    echo "  format        - 格式化代码"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "运行 TypeScript 测试..."
    npm test
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    eslint.enable = true;
    prettier.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
