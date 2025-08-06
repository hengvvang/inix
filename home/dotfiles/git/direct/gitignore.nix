{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {
    home.file.".gitignore" = {
      text = ''
        # === 系统文件 ===
        .DS_Store
        .DS_Store?
        ._*
        .Spotlight-V100
        .Trashes
        ehthumbs.db
        Thumbs.db
        Desktop.ini

        # === 编辑器和IDE ===
        # VSCode
        .vscode/
        *.code-workspace

        # Vim
        *~
        *.swp
        *.swo
        .vim/

        # JetBrains IDEs
        .idea/
        *.iml
        *.ipr
        *.iws

        # === 语言相关 ===
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
        .env
        .venv
        env/
        venv/
        ENV/

        # Node.js
        node_modules/
        npm-debug.log*
        yarn-debug.log*
        yarn-error.log*
        .npm
        .eslintcache
        .node_repl_history
        *.tgz
        .yarn-integrity
        .env.local
        .env.development.local
        .env.test.local
        .env.production.local

        # Rust
        /target/
        **/*.rs.bk
        Cargo.lock

        # Go
        *.exe
        *.exe~
        *.dll
        *.so
        *.dylib
        *.test
        *.out
        /vendor/

        # === 构建和部署 ===
        build/
        dist/
        target/
        *.log
        *.tmp
        *.temp
        .cache/

        # === 数据库 ===
        *.db
        *.sqlite
        *.sqlite3

        # === 配置和密钥 ===
        .env
        .env.local
        .env.*.local
        *.key
        *.pem
        config.local.*
        secrets.*

        # === 备份文件 ===
        *~
        *.bak
        *.backup
        *.old
        *.orig
        *.rej

        # === 压缩文件 ===
        *.7z
        *.dmg
        *.gz
        *.iso
        *.jar
        *.rar
        *.tar
        *.zip

        # === 自定义 ===
        TODO
        NOTES
        .private/
        scratch/
        experiments/
      '';
    };
  };
}
