{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.configStyle == "homeManager") {
    # Visual Studio Code 配置 - 使用 Home Manager
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;                    # 官方 VSCode (默认)
      # package = pkgs.vscodium;                # 开源版本 VSCodium
      # package = pkgs.vscode-fhs;              # FHS 版本 (兼容性更好)

      # 扩展管理配置
      mutableExtensionsDir = true;              # 允许手动安装扩展 (推荐)

      # 精选扩展列表 - 核心开发工具
      extensions = with pkgs.vscode-extensions; [
        # === 语言支持 ===
        ms-python.python                       # Python 开发
        ms-vscode.cpptools                     # C/C++ 开发
        rust-lang.rust-analyzer               # Rust 开发
        bradlc.vscode-tailwindcss             # Tailwind CSS
        jnoortheen.nix-ide                    # Nix 语言支持

        # === 前端开发 ===
        ms-vscode.vscode-typescript-next      # TypeScript
        ms-vscode.vscode-json                 # JSON 支持
        ms-vscode.vscode-html-language-features # HTML
        ms-vscode.vscode-css-language-features # CSS

        # === Git 版本控制 ===
        eamodio.gitlens                       # Git 增强工具

        # === 编辑器增强 ===
        ms-vscode.vscode-eslint               # ESLint 代码检查
        ms-vscode.vscode-prettier             # Prettier 代码格式化
        vscodevim.vim                         # Vim 键位绑定

        # === 主题和界面 ===
        catppuccin.catppuccin-vsc             # Catppuccin 主题
        pkief.material-icon-theme             # Material 图标主题

        # === 实用工具 ===
        ms-vscode-remote.remote-ssh           # SSH 远程开发
        ms-vscode.vscode-docker               # Docker 支持
      ];

      # 用户设置配置
      userSettings = {
        # === 编辑器基础设置 ===
        "editor.fontSize" = 14;                          # 字体大小
        "editor.fontFamily" = "'JetBrains Mono', 'Fira Code', 'Cascadia Code', monospace"; # 字体家族
        "editor.fontLigatures" = true;                   # 启用字体连字
        "editor.lineHeight" = 1.5;                       # 行高
        "editor.tabSize" = 2;                           # Tab 大小
        "editor.insertSpaces" = true;                    # 使用空格替代 Tab
        "editor.wordWrap" = "on";                        # 自动换行
        "editor.minimap.enabled" = true;                 # 显示迷你地图
        "editor.lineNumbers" = "on";                     # 显示行号
        "editor.renderWhitespace" = "boundary";          # 显示空白字符
        "editor.rulers" = [ 80 120 ];                    # 显示参考线

        # === 格式化设置 ===
        "editor.formatOnSave" = true;                    # 保存时自动格式化
        "editor.formatOnPaste" = true;                   # 粘贴时自动格式化
        "editor.defaultFormatter" = "esbenp.prettier-vscode"; # 默认格式化工具

        # === 搜索设置 ===
        "search.exclude" = {
          "**/.git" = true;
          "**/node_modules" = true;
          "**/dist" = true;
          "**/build" = true;
          "**/.next" = true;
        };

        # === 文件设置 ===
        "files.autoSave" = "afterDelay";                 # 自动保存
        "files.autoSaveDelay" = 1000;                    # 自动保存延迟 (毫秒)
        "files.trimTrailingWhitespace" = true;           # 删除行尾空格
        "files.insertFinalNewline" = true;               # 文件末尾插入换行

        # === 工作区设置 ===
        "workbench.colorTheme" = "Catppuccin Mocha";     # 主题
        "workbench.iconTheme" = "material-icon-theme";   # 图标主题
        "workbench.startupEditor" = "welcomePage";       # 启动页面
        "workbench.sideBar.location" = "left";           # 侧边栏位置
        "workbench.editor.enablePreview" = false;        # 禁用预览模式

        # === 终端设置 ===
        "terminal.integrated.fontFamily" = "'JetBrains Mono', 'Fira Code', monospace";
        "terminal.integrated.fontSize" = 13;             # 终端字体大小
        "terminal.integrated.shell.linux" = "${pkgs.fish}/bin/fish"; # 默认 Shell

        # === Git 设置 ===
        "git.enableSmartCommit" = true;                  # 智能提交
        "git.confirmSync" = false;                       # 关闭同步确认
        "git.autofetch" = true;                          # 自动获取

        # === 语言特定设置 ===
        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
        };
        "[python]" = {
          "editor.tabSize" = 4;
          "editor.insertSpaces" = true;
        };
        "[javascript]" = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
        };
        "[typescript]" = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
        };
        "[json]" = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
        };

        # === 安全和隐私 ===
        "telemetry.telemetryLevel" = "off";              # 关闭遥测
        "update.mode" = "manual";                         # 手动更新

        # === Vim 模式设置 (如果启用) ===
        "vim.useSystemClipboard" = true;                 # 使用系统剪贴板
        "vim.useCtrlKeys" = true;                        # 启用 Ctrl 键
        "vim.hlsearch" = true;                           # 搜索高亮
      };

      # 键盘快捷键配置
      keybindings = [
        # === 自定义快捷键 ===
        {
          "key" = "ctrl+shift+p";
          "command" = "workbench.action.showCommands";
        }
        {
          "key" = "ctrl+shift+e";
          "command" = "workbench.view.explorer";
        }
        {
          "key" = "ctrl+shift+g";
          "command" = "workbench.view.scm";
        }
        {
          "key" = "ctrl+shift+d";
          "command" = "workbench.view.debug";
        }
        {
          "key" = "ctrl+shift+x";
          "command" = "workbench.view.extensions";
        }
        # === Vim 风格快捷键 ===
        {
          "key" = "ctrl+h";
          "command" = "workbench.action.navigateLeft";
        }
        {
          "key" = "ctrl+l";
          "command" = "workbench.action.navigateRight";
        }
        {
          "key" = "ctrl+k";
          "command" = "workbench.action.navigateUp";
        }
        {
          "key" = "ctrl+j";
          "command" = "workbench.action.navigateDown";
        }
      ];
    };
  };
}
