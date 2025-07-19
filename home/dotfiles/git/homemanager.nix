{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "homemanager") {
    # Git Home Manager 完整配置
    programs.git = {
      # ===== 基础配置 =====
      enable = true;
      package = pkgs.git;  # 指定 Git 包，默认使用 nixpkgs 中的 git
      
      # 用户信息
      userName = "hengvvang";
      userEmail = "hengvvang@example.com";  # 请替换为您的邮箱
      
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
      
      # ===== Git 维护配置 =====
      # 自动执行 git maintenance 以保持仓库性能
      maintenance = {
        enable = false;          # 默认禁用自动维护
        repositories = [ ];      # 需要维护的仓库列表
        timers = {
          # 定时器配置示例（启用时可配置）
          # hourly = "hourly";
          # daily = "daily";
          # weekly = "weekly";
        };
      };
      
      # ===== 别名配置 =====
      # 简化常用命令（保持最基本的几个）
      aliases = {
        # 基本操作别名
        st = "status --short";
        co = "checkout";
        br = "branch";
        cm = "commit";
        
        # 日志查看
        lg = "log --oneline --graph --decorate --all";
        last = "log -1 HEAD --stat";
      };
      
      # ===== 全局忽略文件 =====
      ignores = [
        # === 系统文件 ===
        # ".DS_Store"              # macOS
        # ".DS_Store?"
        # "._*"
        # ".Spotlight-V100"
        # ".Trashes"
        # "ehthumbs.db"           # Windows
        # "Thumbs.db"
        # "Desktop.ini"
        # "$RECYCLE.BIN/"
        
        # === 编辑器和 IDE ===
        # "*.swp"                 # Vim
        # "*.swo"
        # "*~"
        # ".vscode/"              # VS Code
        # ".idea/"                # IntelliJ
        # "*.iml"
        # ".eclipse/"
        # ".metadata/"
        # ".project"
        # ".classpath"
        # ".settings/"
        
        # === 备份和临时文件 ===
        # "*.tmp"
        # "*.temp"
        # "*.bak"
        # "*.backup"
        # "*.orig"
        # "*.rej"
        # "*~"
        # "#*#"
        # ".#*"
        
        # === 日志文件 ===
        # "*.log"
        # "logs/"
        # "npm-debug.log*"
        # "yarn-debug.log*"
        # "yarn-error.log*"
        
        # === 构建输出 ===
        # "node_modules/"         # Node.js
        # "target/"               # Rust, Java
        # "build/"                # 通用构建目录
        # "dist/"                 # 分发目录
        # "out/"
        # ".cache/"
        # ".next/"                # Next.js
        # ".nuxt/"                # Nuxt.js
        # ".parcel-cache/"        # Parcel
        
        # === 环境和配置文件 ===
        # ".env"
        # ".env.*"
        # "!.env.example"
        # ".envrc"
        # ".direnv/"
        
        # === 压缩包 ===
        # "*.zip"
        # "*.tar.gz"
        # "*.tgz"
        # "*.rar"
        # "*.7z"
        
        # === Nix 相关 ===
        # "result"                # Nix build 结果
        # "result-*"
        # ".direnv/"
      ];
      
      # ===== Git 属性配置 =====
      # 定义文件如何处理（行尾、diff、合并等）
      attributes = [
        "* text=auto eol=lf"    # 统一使用 LF 行尾
        "*.txt text"
        "*.md text"
        "*.json text"
        "*.yml text"
        "*.yaml text"
        "*.toml text"
        "*.nix text"
        
        # 二进制文件
        "*.jpg binary"
        "*.jpeg binary"
        "*.png binary"
        "*.gif binary"
        "*.ico binary"
        "*.pdf binary"
        "*.zip binary"
        "*.tar.gz binary"
      ];
      
      # ===== Git Hooks 配置 =====
      # 自动化工作流程钩子（默认为空，按需配置）
      hooks = {
        # 示例：提交前检查
        # pre-commit = pkgs.writeShellScript "pre-commit" ''
        #   echo "Running pre-commit checks..."
        # '';
      };
      
      # ===== 包含其他配置文件 =====
      # 可以包含其他 Git 配置文件
      includes = [
        # 示例：工作相关配置
        # {
        #   condition = "gitdir:~/work/";
        #   path = "~/work/.gitconfig";
        # }
      ];
      
      # ===== Delta 配置 (增强的 diff 显示) =====
      delta = {
        enable = true;
        package = pkgs.delta;
        options = {
          # 导航功能
          navigate = true;           # 启用 n/N 键导航
          hyperlinks = true;         # 启用超链接
          
          # 显示选项
          side-by-side = true;       # 并排显示差异
          line-numbers = true;       # 显示行号
          line-numbers-left-format = " {nm:>3} │";
          line-numbers-right-format = " {np:>3} │";
          
          # 颜色和主题
          dark = true;               # 深色主题
          syntax-theme = "Dracula";  # 语法高亮主题
          
          # 文件头和代码栅栏
          file-style = "bold yellow ul";
          file-decoration-style = "none";
          file-added-label = "[+]";
          file-copied-label = "[==]";
          file-modified-label = "[*]";
          file-removed-label = "[-]";
          file-renamed-label = "[->]";
          
          # 差异行样式
          minus-style = "syntax \"#3f2d3d\"";
          minus-emph-style = "syntax \"#763842\"";
          plus-style = "syntax \"#283b4d\"";
          plus-emph-style = "syntax \"#316172\"";
          
          # 其他选项
          wrap-max-lines = "unlimited";
          width = -1;                # 自动宽度
        };
      };
      
      # ===== 其他 diff 工具配置示例 =====
      # 可选：difftastic (基于结构的 diff)
      # difftastic = {
      #   enable = false;
      #   background = "dark";
      #   color = "auto";
      #   display = "side-by-side-show-both";
      # };
      
      # 可选：diff-so-fancy
      # diff-so-fancy = {
      #   enable = false;
      #   changeHunkIndicators = true;
      #   markEmptyLines = true;
      #   stripLeadingSymbols = true;
      #   useUnicodeRuler = true;
      # };
      
      # ===== Git 核心配置 =====
      extraConfig = {
        # === 核心设置 ===
        core = {
          editor = "vim";            # 默认编辑器
          autocrlf = "input";         # 行尾转换（Linux/macOS 推荐）
          safecrlf = true;            # 安全的行尾转换
          filemode = true;            # 文件权限检测
          symlinks = true;            # 符号链接支持
          ignorecase = false;         # 文件名大小写敏感
          preloadindex = true;        # 预加载索引提升性能
          fscache = true;             # 文件系统缓存（Windows）
          longpaths = true;           # 长路径支持（Windows）
        };
        
        # === 初始化设置 ===
        init = {
          defaultBranch = "main";     # 默认分支名
          templateDir = "";           # 模板目录
        };
        
        # === 推送设置 ===
        push = {
          default = "simple";         # 推送策略：simple（安全）
          followTags = false;         # 不自动推送标签
          autoSetupRemote = false;    # 不自动设置远程分支
        };
        
        # === 拉取设置 ===
        pull = {
          rebase = false;             # 使用 merge 而非 rebase
          ff = "only";                # 仅快进合并
        };
        
        # === 获取设置 ===
        fetch = {
          prune = true;               # 自动清理删除的远程分支
          prunetags = false;          # 不自动清理标签
        };
        
        # === 分支设置 ===
        branch = {
          autosetupmerge = "always";  # 自动设置合并
          autosetuprebase = "never";  # 不自动设置 rebase
        };
        
        # === 合并设置 ===
        merge = {
          tool = "vimdiff";           # 合并工具
          conflictstyle = "merge";    # 冲突样式：merge, diff3, zdiff3
          autoStash = false;          # 不自动 stash
        };
        
        # === 差异设置 ===
        diff = {
          tool = "vimdiff";           # diff 工具
          algorithm = "histogram";    # diff 算法：myers, minimal, patience, histogram
          renames = "copies";         # 重命名检测
          mnemonicPrefix = true;      # 使用助记符前缀
          colorMoved = "default";     # 移动代码着色
        };
        
        # === 颜色设置 ===
        color = {
          ui = "auto";                # 自动颜色
          status = "auto";
          branch = "auto";
          interactive = "auto";
          diff = "auto";
          grep = "auto";
        };
        
        # === 状态设置 ===
        status = {
          showUntrackedFiles = "normal";  # 显示未跟踪文件
          submoduleSummary = false;       # 不显示子模块摘要
        };
        
        # === 日志设置 ===
        log = {
          date = "iso";               # 日期格式
          decorate = "short";         # 装饰显示
          follow = true;              # 跟踪文件重命名
        };
        
        # === 性能优化 ===
        pack = {
          # threads = "0";              # 使用所有可用 CPU 核心
          # deltaCacheSize = "2g";      # delta 缓存大小
          # windowMemory = "1g";        # 窗口内存大小
        };
        
        # === 其他有用设置 ===
        advice = {
          pushUpdateRejected = true;
          statusHints = true;
          statusUoption = true;
          commitBeforeMerge = true;
          resolveConflict = true;
          implicitIdentity = false;
          detachedHead = true;
        };
        
        # === 重写历史相关 ===
        rebase = {
          autoStash = false;          # 不自动 stash
          autoSquash = false;         # 不自动 squash
        };
        
        # === 子模块设置 ===
        submodule = {
          recurse = false;            # 不递归子模块
        };
        
        # === 网络设置 ===
        http = {
          # postBuffer = "524288000";   # 50MB 缓冲区
          # lowSpeedLimit = "1000";     # 最低速度限制
          # lowSpeedTime = "60";        # 最低速度时间
        };
        
        # === 清理设置 ===
        gc = {
          # auto = "6700";              # 自动垃圾回收阈值
          # autoPackLimit = "50";       # 自动打包限制
        };
      };
    };
  };
}
