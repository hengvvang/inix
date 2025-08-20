{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {

    home.file.".gitignore_global" = {
      text = ''
        # Git 全局忽略文件
        # 配置方式: direct - 直接文件配置

        # === 操作系统生成的文件 ===
        # macOS
        .DS_Store
        .DS_Store?
        ._*
        .Spotlight-V100
        .Trashes
        ehthumbs.db
        Thumbs.db

        # Windows
        Thumbs.db
        ehthumbs.db
        Desktop.ini
        $RECYCLE.BIN/

        # Linux
        *~
        .directory

        # === 编辑器和 IDE ===
        # Vim
        *.swp
        *.swo
        *~
        .viminfo

        # Emacs
        *~
        \#*\#
        /.emacs.desktop
        /.emacs.desktop.lock
        *.elc

        # VS Code
        .vscode/
        !.vscode/settings.json
        !.vscode/tasks.json
        !.vscode/launch.json
        !.vscode/extensions.json

        # JetBrains IDEs
        .idea/
        *.iml
        *.ipr
        *.iws

        # Sublime Text
        *.sublime-project
        *.sublime-workspace

        # === 编程语言特定 ===
        # Node.js
        node_modules/
        npm-debug.log*
        yarn-debug.log*
        yarn-error.log*
        .npm
        .yarn-integrity

        # Python
        __pycache__/
        *.py[cod]
        *$py.class
        *.so
        .Python
        build/
        develop-eggs/
        dist/
        downloads/
        eggs/
        .eggs/
        lib/
        lib64/
        parts/
        sdist/
        var/
        wheels/
        *.egg-info/
        .installed.cfg
        *.egg

        # Java
        *.class
        *.jar
        *.war
        *.ear

        # C/C++
        *.o
        *.so
        *.a
        *.exe

        # Rust
        target/
        Cargo.lock

        # Go
        *.exe
        *.exe~
        *.dll
        *.so
        *.dylib
        *.test
        *.out
        vendor/

        # === 构建工具 ===
        # CMake
        CMakeFiles/
        CMakeCache.txt
        cmake_install.cmake
        Makefile

        # Make
        *.d

        # === 包管理器 ===
        # npm
        node_modules/
        package-lock.json

        # Yarn
        yarn.lock

        # Composer (PHP)
        vendor/
        composer.lock

        # === 环境和配置 ===
        # 环境变量文件
        .env
        .env.local
        .env.development.local
        .env.test.local
        .env.production.local

        # 配置文件
        config.local.*
        *.local.conf

        # === 日志和临时文件 ===
        # 日志文件
        *.log
        logs/
        log/

        # 临时文件
        *.tmp
        *.temp
        *.cache
        .cache/
        tmp/
        temp/

        # 备份文件
        *.bak
        *.backup
        *.old

        # === 版本控制 ===
        # SVN
        .svn/

        # Mercurial
        .hg/

        # === 数据库 ===
        *.db
        *.sqlite
        *.sqlite3

        # === 压缩文件 ===
        *.zip
        *.tar
        *.tar.gz
        *.rar
        *.7z

        # === 其他 ===
        # 密钥文件
        *.pem
        *.key
        *.crt

        # 测试覆盖率
        coverage/
        .coverage
        .nyc_output

        # 依赖检查
        .snyk

        # Nix
        result
        result-*
        .direnv/
      '';
    };
  };
}
