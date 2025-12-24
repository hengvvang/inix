{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.style == "nixStyle") {
    programs.git = {
      enable = true;
      package = pkgs.git;

      # ===== 代码签名配置 =====
      # GPG 签名提交和标签（如果不使用 GPG 签名可以禁用）
      signing = {
        key = null;              # GPG 密钥指纹，null 表示使用默认密钥
        signByDefault = false;   # 是否默认签名所有提交，false 节省时间
        # format = "openpgp";    # 暂时注释掉这行以避免配置冲突
        signer = null;           # 自定义签名工具路径，null 使用默认
      };

      # ===== Git LFS (大文件存储) =====
      # 对于大型二进制文件管理很有用
      lfs = {
        enable = false;          # 默认禁用，按需启用
        skipSmudge = false;      # 是否跳过 clone/pull 时自动下载对象
      };

      # ===== 新版配置格式 =====
      settings = {
        # 用户信息
        user = {
          name = "hengvvang";
          email = "hengvvang@proton.me";
        };

        # ===== 别名配置 =====
        # 提高工作效率的 Git 别名
        alias = {
          # 基础别名
          a = "add";
          aa = "add --all";
          ai = "add --interactive";
          ap = "add --patch";

          # 分支相关
          b = "branch";
          ba = "branch --all";
          bd = "branch --delete";
          bD = "branch --delete --force";
          br = "branch --remote";

          # 提交相关
          c = "commit";
          ca = "commit --all";
          cam = "commit --all --message";
          cm = "commit --message";
          co = "checkout";
          cob = "checkout -b";

          # 差异相关
          d = "diff";
          dc = "diff --cached";
          ds = "diff --stat";

          # 历史相关
          l = "log --oneline";
          lg = "log --oneline --graph";

          # 推送拉取
          p = "push";
          pf = "push --force-with-lease";
          pu = "push --set-upstream";
          pl = "pull";
          plo = "pull origin";
          plr = "pull --rebase";

          # 状态和显示
          s = "status";
          ss = "status --short";
          sh = "show";
          sho = "show --pretty='format:' --name-only";

          # 暂存相关
          st = "stash";
          sta = "stash apply";
          std = "stash drop";
          stl = "stash list";
          stp = "stash pop";
          sts = "stash show";

          # 远程相关
          r = "remote";
          ra = "remote add";
          rr = "remote remove";
          rv = "remote --verbose";

          # 重置相关
          unstage = "reset HEAD --";
          undo = "reset --soft HEAD^";
          undohard = "reset --hard HEAD^";

          # 高级操作
          amend = "commit --amend";
          amendn = "commit --amend --no-edit";
          rb = "rebase";
          rbi = "rebase --interactive";
          rbc = "rebase --continue";
          rba = "rebase --abort";

          # 查看贡献
          contributors = "shortlog --summary --numbered";

          # 文件历史
          filelog = "log -u";
          fl = "log -u";

          # 显示最近的标签
          lasttag = "describe --tags --abbrev=0";

          # 当前分支名
          current-branch = "rev-parse --abbrev-ref HEAD";
        };

        # 核心配置
        core = {
          editor = "vim";
          autocrlf = false;
          filemode = true;
          ignorecase = false;
          precomposeunicode = true;
          quotepath = false;
          trustctime = false;
          pager = "less -FMRiX";
          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
          excludesfile = "~/.gitignore";
        };

        # 应用配置
        apply = {
          whitespace = "fix";
        };

        # 分支配置
        branch = {
          autosetupmerge = "always";
          autosetuprebase = "always";
        };

        # 颜色配置
        color = {
          ui = "auto";
          branch = "auto";
          diff = "auto";
          interactive = "auto";
          status = "auto";
        };

        # 差异配置
        diff = {
          algorithm = "patience";
          renamelimit = 0;
          renames = "copies";
          mnemonicprefix = true;
          compactionHeuristic = true;
        };

        # 获取配置
        fetch = {
          prune = true;
          pruneTags = false;
        };

        # 初始化配置
        init = {
          defaultBranch = "main";
        };

        # 合并配置
        merge = {
          stat = true;
          conflictstyle = "diff3";
          tool = "vimdiff";
          guitool = "meld";
        };

        # 推送配置
        push = {
          default = "simple";
          followTags = true;
          autoSetupRemote = true;
        };

        # 拉取配置
        pull = {
          rebase = true;
          ff = "only";
        };

        # 变基配置
        rebase = {
          autoStash = true;
          autoSquash = true;
        };

        # 重新打包配置
        repack = {
          usedeltabaseoffset = true;
        };

        # 状态配置
        status = {
          showUntrackedFiles = "all";
          submoduleSummary = true;
        };

        # 标签配置
        tag = {
          sort = "version:refname";
        };

        # 传输配置
        transfer = {
          fsckobjects = true;
        };

        # 用户界面配置
        ui = {
          color = "auto";
        };

        # 网络配置
        url = {
          "https://github.com/".insteadOf = "gh:";
          "https://gist.github.com/".insteadOf = "gist:";
          "https://gitlab.com/".insteadOf = "gl:";
          "https://bitbucket.org/".insteadOf = "bb:";
        };

        # 帮助配置
        help = {
          autocorrect = 1;
        };

        # 安全配置
        safe = {
          directory = "*";
        };

        # 子模块配置
        submodule = {
          recurse = true;
        };

        # 日志配置
        log = {
          date = "iso";
        };

        # 格式配置
        format = {
          pretty = "format:%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)";
        };

        # 工具配置
        mergetool = {
          keepBackup = false;
          keepTemporaries = false;
          writeToTemp = true;
          prompt = false;
        };

        difftool = {
          prompt = false;
        };

        # 高级功能
        rerere = {
          enabled = true;
          autoupdate = true;
        };

        # 性能配置
        pack = {
          threads = 0;  # 使用所有可用 CPU 核心
        };

        # 垃圾收集配置
        gc = {
          auto = 256;
        };

        # 协议配置
        protocol = {
          version = 2;
        };

        # 实验性功能
        feature = {
          manyFiles = true;
        };

        # 文件系统监控
        filesystem = {
          useBuiltinFSMonitor = true;
        };
      }; # 结束 settings

      # ===== 忽略文件配置 =====
      ignores = [
        # === 系统文件 ===
        ".DS_Store"
        ".DS_Store?"
        "._*"
        ".Spotlight-V100"
        ".Trashes"
        "ehthumbs.db"
        "Thumbs.db"
        "Desktop.ini"

        # === 编辑器和IDE ===
        # VSCode
        ".vscode/"
        "*.code-workspace"

        # Vim
        "*~"
        "*.swp"
        "*.swo"
        ".vim/"

        # Emacs
        "*~"
        "\#*\#"
        "/.emacs.desktop"
        "/.emacs.desktop.lock"
        "*.elc"
        "auto-save-list"
        "tramp"
        ".\#*"

        # Sublime Text
        "*.sublime-workspace"

        # JetBrains IDEs
        ".idea/"
        "*.iml"
        "*.ipr"
        "*.iws"

        # === 语言相关 ===
        # Python
        "__pycache__/"
        "*.py[cod]"
        "*$py.class"
        "*.so"
        ".Python"
        "build/"
        "develop-eggs/"
        "dist/"
        "downloads/"
        "eggs/"
        ".eggs/"
        "lib/"
        "lib64/"
        "parts/"
        "sdist/"
        "var/"
        "wheels/"
        "*.egg-info/"
        ".installed.cfg"
        "*.egg"
        "MANIFEST"
        "*.manifest"
        "*.spec"
        "pip-log.txt"
        "pip-delete-this-directory.txt"
        ".tox/"
        ".coverage"
        ".pytest_cache/"
        "htmlcov/"
        ".env"
        ".venv"
        "env/"
        "venv/"
        "ENV/"
        "env.bak/"
        "venv.bak/"

        # Node.js
        "node_modules/"
        "npm-debug.log*"
        "yarn-debug.log*"
        "yarn-error.log*"
        ".npm"
        ".eslintcache"
        ".node_repl_history"
        "*.tgz"
        ".yarn-integrity"
        ".env.local"
        ".env.development.local"
        ".env.test.local"
        ".env.production.local"
        ".next/"
        "out/"
        ".nuxt/"
        "dist/"
        ".cache/"

        # Java
        "*.class"
        "*.log"
        "*.ctxt"
        ".mtj.tmp/"
        "*.jar"
        "*.war"
        "*.nar"
        "*.ear"
        "*.zip"
        "*.tar.gz"
        "*.rar"
        "hs_err_pid*"

        # C/C++
        "*.o"
        "*.ko"
        "*.obj"
        "*.elf"
        "*.ilk"
        "*.map"
        "*.exp"
        "*.gch"
        "*.pch"
        "*.lib"
        "*.a"
        "*.la"
        "*.lo"
        "*.dll"
        "*.so"
        "*.so.*"
        "*.dylib"
        "*.exe"
        "*.out"
        "*.app"

        # Rust
        "/target/"
        "**/*.rs.bk"
        "Cargo.lock"

        # Go
        "*.exe"
        "*.exe~"
        "*.dll"
        "*.so"
        "*.dylib"
        "*.test"
        "*.out"
        "/vendor/"

        # === 构建和部署 ===
        "build/"
        "dist/"
        "target/"
        "*.log"
        "*.tmp"
        "*.temp"
        ".cache/"
        ".sass-cache/"
        ".webpack/"

        # === 包管理器 ===
        "node_modules/"
        "bower_components/"
        "vendor/"

        # === 数据库 ===
        "*.db"
        "*.sqlite"
        "*.sqlite3"

        # === 配置和密钥 ===
        ".env"
        ".env.local"
        ".env.*.local"
        "*.key"
        "*.pem"
        "config.local.*"
        "secrets.*"

        # === 测试覆盖率 ===
        "coverage/"
        "*.lcov"
        ".nyc_output/"

        # === 文档生成 ===
        "_site/"
        ".jekyll-cache/"
        ".jekyll-metadata"

        # === 备份文件 ===
        "*~"
        "*.bak"
        "*.backup"
        "*.old"
        "*.orig"
        "*.rej"

        # === 压缩文件 ===
        "*.7z"
        "*.dmg"
        "*.gz"
        "*.iso"
        "*.jar"
        "*.rar"
        "*.tar"
        "*.zip"

        # === 自定义 ===
        "TODO"
        "NOTES"
        ".private/"
        "scratch/"
        "experiments/"
      ];

      # ===== 属性文件配置 =====
      attributes = [
        "*.pdf diff=astextplain"
        "*.PDF diff=astextplain"
        "*.rtf diff=astextplain"
        "*.RTF diff=astextplain"
        "*.jpg binary"
        "*.jpeg binary"
        "*.png binary"
        "*.gif binary"
        "*.ico binary"
        "*.mov binary"
        "*.mp4 binary"
        "*.mp3 binary"
        "*.flv binary"
        "*.fla binary"
        "*.swf binary"
        "*.gz binary"
        "*.zip binary"
        "*.7z binary"
        "*.ttf binary"
        "*.eot binary"
        "*.woff binary"
        "*.pyc binary"
        "*.pdf binary"
        "*.ez binary"
        "*.bz2 binary"
        "*.swp binary"
        "*.jar binary"
        "*.war binary"
        "*.ear binary"
        "*.db binary"
        "*.p binary"
        "*.pkl binary"
        "*.pickle binary"
        "*.pyc binary"
        "*.pyo binary"
        "*.pyd binary"
        "*.so binary"
        "*.egg binary"
        "*.exe binary"
        "*.dll binary"
        "*.o binary"
        "*.a binary"
        "*.lib binary"
        "*.so binary"
        "*.dylib binary"
        "*.ncb binary"
        "*.sdf binary"
        "*.suo binary"
        "*.pdb binary"
        "*.idb binary"
        "*.class binary"
        "*.psd binary"
        "*.db binary"
        "*.v11.suo binary"
        "*.v12.suo binary"
        "*.psess binary"
        "*.vsp binary"
        "*.vspx binary"
        "*.sap binary"
      ];

      # ===== 包含文件 =====
      includes = [
        # 可以在这里添加其他 Git 配置文件的路径
        # { path = "~/.gitconfig.local"; }
        # { path = "~/.gitconfig.work"; condition = "gitdir:~/work/"; }
      ];

      # ===== 钩子配置 =====
      hooks = {
        # 可以在这里定义 Git 钩子
        # pre-commit = pkgs.writeScript "pre-commit" ''
        #   #!/bin/sh
        #   echo "Running pre-commit hook..."
        # '';
      };
    };
  };
}
