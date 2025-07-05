{ config, lib, pkgs, ... }:

{
  # 编程语言开发环境配置
  home.packages = with pkgs; [
    # Rust 开发环境
    rustup               # Rust 工具链管理器
    rust-analyzer        # Rust 语言服务器
    cargo-watch          # 自动重新编译
    cargo-edit           # cargo add/rm 命令
    cargo-generate       # 项目模板生成器
    cargo-expand         # 宏展开工具
    cargo-outdated       # 检查过时依赖
    cargo-audit          # 安全审计
    
    # Rust 嵌入式开发工具 (可选，部分工具可能需要特定版本)
    cargo-binutils       # 二进制工具 (objdump, size 等)
    
    # C/C++ 开发环境  
    gcc                  # GNU 编译器集合
    clang                # LLVM C/C++ 编译器
    cmake                # 构建系统
    ninja                # 快速构建系统
    meson                # 现代构建系统
    gdb                  # 调试器
    clang-tools          # C/C++ 语言服务器和工具
    ccache               # 编译缓存
    
    # C/C++ 嵌入式开发
    gcc-arm-embedded     # ARM 嵌入式 GCC
    
    # Python 开发环境
    python3              # Python 解释器
    python3Packages.pip  # Python 包管理器
    python3Packages.virtualenv # 虚拟环境
    pyright              # Python 语言服务器
    python3Packages.black # Python 代码格式化
    python3Packages.isort # Python import 排序
    python3Packages.flake8 # Python 代码检查
    
    # Node.js 和 TypeScript/JavaScript 开发环境
    nodejs               # Node.js 运行时
    nodePackages.npm     # npm 包管理器
    nodePackages.typescript # TypeScript 编译器
    nodePackages.typescript-language-server # TS 语言服务器
    nodePackages.prettier # 代码格式化工具
    nodePackages.eslint  # JavaScript/TypeScript 代码检查
    
    # Nix 开发环境
    nil                  # Nix 语言服务器
    nixpkgs-fmt         # Nix 代码格式化工具
    nix-tree            # Nix 依赖树查看
    
    # 通用开发工具
    git                  # 版本控制
    lazygit             # Git 终端界面
    httpie              # HTTP 客户端
    curl                # URL 工具
    
    # 现代化终端工具 (基础工具，更多工具在 modern-tools.nix 中)
    fd                  # 现代化的 find
    ripgrep             # 现代化的 grep  
    bat                 # 现代化的 cat
    htop                # 系统监控
    tree                # 目录树显示
    
    # 构建和包管理工具
    pkg-config          # 包配置工具
    autoconf            # 自动配置
    automake            # 自动化构建
    libtool             # 库工具
    
    # 调试和分析工具
    strace              # 系统调用跟踪
    ltrace              # 库调用跟踪
    valgrind            # 内存分析
    
    # 文档和标准
    man-pages           # Linux 手册页
    man-pages-posix     # POSIX 手册页
  ];

  # direnv - 自动环境变量管理 (项目级别的环境设置)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;  # Nix 集成，支持 shell.nix
  };

  # 开发环境变量
  home.sessionVariables = {
    # 默认编辑器
    EDITOR = "micro";
    VISUAL = "micro";
    
    # Rust 环境
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    
    # Python 环境
    PYTHONPATH = "${config.home.homeDirectory}/.local/lib/python3.11/site-packages";
    
    # Node.js 环境
    NODE_PATH = "${config.home.homeDirectory}/.local/lib/node_modules";
    
    # C/C++ 编译优化
    CCACHE_DIR = "${config.home.homeDirectory}/.cache/ccache";
    
    # 构建工具
    CMAKE_GENERATOR = "Ninja";
  };

  # PATH 扩展
  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"  # Rust 工具
    "${config.home.homeDirectory}/.local/bin"  # 本地安装的工具
  ];

  # 开发相关的 shell 别名 (特定语言工具别名)
  home.shellAliases = {
    # 开发快捷命令
    # Rust
    cr = "cargo run";
    cb = "cargo build";
    ct = "cargo test";
    cc = "cargo check";
    cf = "cargo fmt";
    ccl = "cargo clippy";
    cfl = "cargo flash";
    csize = "cargo size";
    
    # C/C++ 开发
    mk = "make";
    cmk = "cmake";
    ninja-build = "ninja";
    
    # Python
    py = "python3";
    pip = "pip3";
    pyformat = "black . && isort .";
    pylint = "flake8";
    
    # Node.js/TypeScript
    nr = "npm run";
    nrd = "npm run dev";
    nrb = "npm run build";
    nrt = "npm run test";
    
    # 构建系统
    configure = "./configure";
    autogen = "./autogen.sh";
    
    # Git 快捷命令  
    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gl = "git pull";
    lg = "lazygit";
    
    # 调试工具
    trace = "strace -f";
    mem = "valgrind --tool=memcheck";
    
    # 系统信息
    ports = "ss -tulpn";
    procs = "ps aux";
  };

  # 创建开发环境设置脚本
  home.file.".local/bin/setup-dev-env".text = ''
    #!/bin/bash
    # 开发环境设置脚本
    
    echo "🛠️  设置开发环境..."
    
    # 安装 Rust 嵌入式目标
    echo "🦀 安装 Rust 嵌入式目标..."
    rustup target add thumbv7em-none-eabihf  # Cortex-M4/M7
    rustup target add thumbv6m-none-eabi     # Cortex-M0/M0+
    rustup target add thumbv7m-none-eabi     # Cortex-M3
    rustup target add riscv32imac-unknown-none-elf  # RISC-V
    
    # 安装 Rust 嵌入式工具
    echo "🔧 安装 Rust 嵌入式工具..."
    rustup component add llvm-tools-preview
    cargo install cargo-binutils
    cargo install cargo-embed
    cargo install cargo-flash
    
    # 创建开发目录
    echo "📁 创建开发目录..."
    mkdir -p ~/Projects/{rust,c-cpp,embedded,web,python}
    mkdir -p ~/.config/{openocd,gdb}
    
    # 设置 Git 全局配置
    echo "🔧 配置 Git..."
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    git config --global core.editor micro
    
    echo "✅ 开发环境设置完成!"
    echo "📖 使用 'dev-info' 命令查看环境信息"
    echo "📖 使用 'embed-setup' 命令检查嵌入式环境"
  '';
}
