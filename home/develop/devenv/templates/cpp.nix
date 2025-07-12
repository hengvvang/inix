# C/C++ 项目 devenv 模板
{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    cmake
    ninja
    pkg-config
    gdb
    valgrind
    clang-tools  # clang-format, clang-tidy
  ];

  # https://devenv.sh/languages/
  languages.c.enable = true;
  languages.cplusplus.enable = true;

  # https://devenv.sh/processes/
  processes = {
    build-watch.exec = "find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' | entr -c make";
  };

  # https://devenv.sh/scripts/
  scripts = {
    build.exec = "cmake -B build && cmake --build build";
    clean.exec = "rm -rf build";
    debug.exec = "gdb ./build/main";
    format.exec = "find . -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' | xargs clang-format -i";
  };

  enterShell = ''
    echo "⚙️  C/C++ 开发环境已激活！"
    echo "编译器版本:"
    echo "  gcc: $(gcc --version | head -n1)"
    echo "  clang: $(clang --version | head -n1)"
    echo "可用命令："
    echo "  build         - 构建项目"
    echo "  clean         - 清理构建文件"
    echo "  debug         - 启动 GDB 调试器"
    echo "  format        - 格式化代码"
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "构建并运行测试..."
    cmake -B build && cmake --build build && ./build/test
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    clang-format.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
