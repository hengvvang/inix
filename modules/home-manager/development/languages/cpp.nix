{ config, lib, pkgs, ... }:

{
  # C/C++ 开发环境配置模块
  home.packages = with pkgs; [
    # 编译器
    gcc                  # GNU 编译器集合
    clang                # LLVM C/C++ 编译器
    llvm                 # LLVM 工具集
    
    # 构建系统
    cmake                # 跨平台构建系统
    ninja                # 快速构建系统
    meson                # 现代构建系统
    bazel                # Google 构建系统
    xmake                # 现代 C/C++ 构建工具
    
    # 包管理
    vcpkg                # Microsoft C++ 包管理器
    conan                # C/C++ 包管理器
    
    # 构建工具
    make                 # GNU Make
    automake             # 自动化构建
    autoconf             # 自动配置
    libtool              # 库工具
    pkg-config           # 包配置工具
    
    # 调试器
    gdb                  # GNU 调试器
    lldb                 # LLVM 调试器
    rr                   # 记录和重放调试器
    
    # 分析工具
    valgrind             # 内存分析工具
    cppcheck             # 静态代码分析
    clang-tools          # C/C++ 语言服务器和工具
    include-what-you-use # 头文件包含分析
    
    # 性能分析
    perf-tools           # 性能分析工具集
    flamegraph           # 火焰图生成工具
    hotspot              # 性能分析 GUI
    
    # 代码格式化
    clang-format         # 代码格式化工具
    uncrustify           # 代码美化工具
    
    # 文档工具
    doxygen              # 文档生成工具
    graphviz             # 图形绘制工具 (Doxygen 依赖)
    
    # 库和框架
    boost                # Boost C++ 库
    eigen                # 线性代数库
    catch2               # C++ 测试框架
    gtest                # Google 测试框架
    benchmark            # Google 基准测试库
    
    # 静态分析
    cppcheck             # C++ 静态分析
    splint               # C 静态分析
    
    # 内存检查
    address-sanitizer    # 地址检查器
    
    # 辅助工具
    ccache               # 编译缓存
    distcc               # 分布式编译
    bear                 # 编译数据库生成器
    
    # 二进制分析
    binutils             # 二进制工具集
    objdump              # 目标文件反汇编 (在 binutils 中)
    hexdump              # 十六进制查看器
    xxd                  # 十六进制编辑器
    
    # 交叉编译支持
    gcc-arm-embedded     # ARM GCC 工具链
  ];
  
  # C/C++ 环境变量
  home.sessionVariables = {
    # 编译器设置
    CC = "clang";
    CXX = "clang++";
    
    # 构建设置
    CMAKE_BUILD_TYPE = "Debug";
    CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
    
    # 包配置
    PKG_CONFIG_PATH = "$HOME/.local/lib/pkgconfig:/usr/local/lib/pkgconfig";
    
    # 调试设置
    ASAN_OPTIONS = "abort_on_error=1:check_initialization_order=1";
    MSAN_OPTIONS = "abort_on_error=1";
    UBSAN_OPTIONS = "abort_on_error=1";
  };
  
  # C/C++ 别名
  home.shellAliases = {
    # 编译快捷方式
    gcc-debug = "gcc -g -O0 -Wall -Wextra -std=c17";
    gcc-release = "gcc -O3 -DNDEBUG -std=c17";
    gpp-debug = "g++ -g -O0 -Wall -Wextra -std=c++20";
    gpp-release = "g++ -O3 -DNDEBUG -std=c++20";
    
    clang-debug = "clang -g -O0 -Wall -Wextra -std=c17";
    clang-release = "clang -O3 -DNDEBUG -std=c17";
    clangpp-debug = "clang++ -g -O0 -Wall -Wextra -std=c++20";
    clangpp-release = "clang++ -O3 -DNDEBUG -std=c++20";
    
    # CMake 快捷方式
    cmake-debug = "cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON";
    cmake-release = "cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON";
    cmake-build = "cmake --build .";
    cmake-clean = "cmake --build . --target clean";
    cmake-test = "cmake --build . --target test";
    
    # 调试快捷方式
    gdb-run = "gdb -ex run --args";
    gdb-bt = "gdb -batch -ex run -ex bt -ex quit --args";
    
    # 内存检查
    valgrind-leak = "valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes";
    valgrind-mem = "valgrind --tool=memcheck --track-origins=yes";
    
    # 性能分析
    perf-record = "perf record -g";
    perf-report = "perf report -g";
    
    # 代码分析
    cppcheck-all = "cppcheck --enable=all --std=c++20 --inconclusive";
    clang-analyze = "clang++ --analyze -Xanalyzer -analyzer-output=text";
    
    # 代码格式化
    format-c = "clang-format -i -style=Google";
    format-cpp = "clang-format -i -style=Google";
    
    # 快速编译和运行
    compile-run-c = "gcc -g -O0 -Wall -Wextra -std=c17 -o temp";
    compile-run-cpp = "g++ -g -O0 -Wall -Wextra -std=c++20 -o temp";
  };
  
  # C/C++ 项目配置文件
  home.file = {
    # CMake 模板
    "Templates/cpp-project/CMakeLists.txt".text = ''
      cmake_minimum_required(VERSION 3.20)
      project(cpp_project VERSION 1.0.0 LANGUAGES CXX)
      
      # 设置 C++ 标准
      set(CMAKE_CXX_STANDARD 20)
      set(CMAKE_CXX_STANDARD_REQUIRED ON)
      set(CMAKE_CXX_EXTENSIONS OFF)
      
      # 编译选项
      if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
          add_compile_options(-Wall -Wextra -Wpedantic)
      endif()
      
      # 调试信息
      if(CMAKE_BUILD_TYPE STREQUAL "Debug")
          add_compile_options(-g -O0)
          add_compile_definitions(DEBUG)
      else()
          add_compile_options(-O3 -DNDEBUG)
      endif()
      
      # 包含目录
      include_directories(include)
      
      # 源文件
      file(GLOB_RECURSE SOURCES "src/*.cpp")
      
      # 可执行文件
      add_executable(''${PROJECT_NAME} ''${SOURCES})
      
      # 链接库
      # target_link_libraries(''${PROJECT_NAME} PRIVATE some_library)
      
      # 测试
      enable_testing()
      find_package(GTest QUIET)
      if(GTest_FOUND)
          file(GLOB_RECURSE TEST_SOURCES "tests/*.cpp")
          add_executable(tests ''${TEST_SOURCES})
          target_link_libraries(tests PRIVATE GTest::gtest GTest::gtest_main)
          add_test(NAME all_tests COMMAND tests)
      endif()
      
      # 安装规则
      install(TARGETS ''${PROJECT_NAME} DESTINATION bin)
    '';
    
    # C++ 源文件模板
    "Templates/cpp-project/src/main.cpp".text = ''
      #include <iostream>
      #include <string>
      #include <vector>
      
      int main(int argc, char* argv[]) {
          std::cout << "Hello, C++20 World!" << std::endl;
          
          if (argc > 1) {
              std::cout << "Arguments:" << std::endl;
              for (int i = 1; i < argc; ++i) {
                  std::cout << "  " << i << ": " << argv[i] << std::endl;
              }
          }
          
          return 0;
      }
    '';
    
    # C 项目 Makefile 模板
    "Templates/c-project/Makefile".text = ''
      # C 项目 Makefile 模板
      
      # 编译器设置
      CC = clang
      CFLAGS = -std=c17 -Wall -Wextra -Wpedantic
      CFLAGS_DEBUG = -g -O0 -DDEBUG
      CFLAGS_RELEASE = -O3 -DNDEBUG
      
      # 目录设置
      SRCDIR = src
      INCDIR = include
      OBJDIR = obj
      BINDIR = bin
      
      # 文件设置
      TARGET = program
      SOURCES = $(wildcard $(SRCDIR)/*.c)
      OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
      HEADERS = $(wildcard $(INCDIR)/*.h)
      
      # 默认目标
      .PHONY: all clean debug release
      
      all: debug
      
      debug: CFLAGS += $(CFLAGS_DEBUG)
      debug: $(BINDIR)/$(TARGET)
      
      release: CFLAGS += $(CFLAGS_RELEASE)
      release: $(BINDIR)/$(TARGET)
      
      # 链接
      $(BINDIR)/$(TARGET): $(OBJECTS) | $(BINDIR)
      	$(CC) $(OBJECTS) -o $@
      
      # 编译
      $(OBJDIR)/%.o: $(SRCDIR)/%.c $(HEADERS) | $(OBJDIR)
      	$(CC) $(CFLAGS) -I$(INCDIR) -c $< -o $@
      
      # 创建目录
      $(OBJDIR):
      	mkdir -p $(OBJDIR)
      
      $(BINDIR):
      	mkdir -p $(BINDIR)
      
      # 清理
      clean:
      	rm -rf $(OBJDIR) $(BINDIR)
      
      # 运行
      run: debug
      	./$(BINDIR)/$(TARGET)
      
      # 调试
      gdb: debug
      	gdb ./$(BINDIR)/$(TARGET)
      
      # 内存检查
      valgrind: debug
      	valgrind --leak-check=full ./$(BINDIR)/$(TARGET)
    '';
    
    # .clang-format 配置
    ".clang-format".text = ''
      ---
      BasedOnStyle: Google
      IndentWidth: 4
      TabWidth: 4
      UseTab: Never
      ColumnLimit: 100
      
      AccessModifierOffset: -2
      AlignAfterOpenBracket: Align
      AlignConsecutiveAssignments: false
      AlignConsecutiveDeclarations: false
      AlignOperands: true
      AlignTrailingComments: true
      
      AllowAllParametersOfDeclarationOnNextLine: true
      AllowShortBlocksOnASingleLine: false
      AllowShortCaseLabelsOnASingleLine: false
      AllowShortFunctionsOnASingleLine: All
      AllowShortIfStatementsOnASingleLine: true
      AllowShortLoopsOnASingleLine: true
      
      BreakBeforeBraces: Attach
      BreakBeforeTernaryOperators: true
      BreakConstructorInitializersBeforeComma: false
      BreakAfterJavaFieldAnnotations: false
      BreakStringLiterals: true
      
      Cpp11BracedListStyle: true
      DerivePointerAlignment: false
      DisableFormat: false
      PointerAlignment: Left
      SpaceAfterCStyleCast: false
      SpaceAfterTemplateKeyword: true
      SpaceBeforeAssignmentOperators: true
      SpaceBeforeParens: ControlStatements
      SpaceInEmptyParentheses: false
      SpacesBeforeTrailingComments: 2
      SpacesInAngles: false
      SpacesInContainerLiterals: true
      SpacesInCStyleCastParentheses: false
      SpacesInParentheses: false
      SpacesInSquareBrackets: false
      
      Standard: c++20
      SortIncludes: true
      SortUsingDeclarations: true
    '';
  };
}
