{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "direct") {
    home.file.".config/Code/User/extensions.json" = {

      text = ''
        {
          /**
          * 推荐扩展列表
          *
          * 工作区推荐扩展功能说明：
          * - 当团队成员首次打开此工作区时,<VSCode 会自动提示安装这些推荐的扩展
          * - 可以通过命令面板执行 "Extensions: Show Recommended Extensions" 查看推荐列表
          * - 扩展ID格式为,{发布者}.{扩展名},可在扩展详情页面找到完整ID
          * - 这些扩展有助于团队保持一致的开发环境和工具链
          */
          "recommendations": [
            // ===========================
            // 代码质量和格式化工具
            // ===========================

            // 代码注释增强工具，支持不同类型的注释高亮
            "aaron-bond.better-comments",

            // 代码格式化工具，支持多种语言的统一格式化
            "esbenp.prettier-vscode",

            // EditorConfig 支持，确保编辑器配置的一致性
            "editorconfig.editorconfig",

            // JavaScript/TypeScript 代码检查工具
            "dbaeumer.vscode-eslint",

            // Python 代码检查和格式化工具 (Ruff)
            "charliermarsh.ruff",

            // 拼写检查工具
            "streetsidesoftware.code-spell-checker",

            // 错误高亮显示工具
            "usernamehw.errorlens",

            // Markdown 格式检查工具
            "davidanson.vscode-markdownlint",

            // 彩虹缩进，提高代码可读性
            "oderwat.indent-rainbow",

            // ===========================
            // 语言支持和开发工具
            // ===========================

            // Python 语言支持套件
            "donjayamanne.python-extension-pack",
            "ms-python.python",
            "ms-python.vscode-pylance",
            "ms-python.debugpy",
            "ms-python.vscode-python-envs",
            "kevinrose.vsc-python-indent",
            "njpwerner.autodocstring",
            "donjayamanne.python-environment-manager",

            // Django 开发支持
            "batisteo.vscode-django",

            // PyRefly 类型检查工具
            "meta.pyrefly",

            // Rust 语言支持
            "rust-lang.rust-analyzer",

            // C/C++ 开发套件
            "ms-vscode.cpptools-extension-pack",
            "ms-vscode.cpptools",
            "jeff-hykin.better-cpp-syntax",
            "llvm-vs-code-extensions.vscode-clangd",

            // 嵌入式开发工具
            "marus25.cortex-debug",
            "mcu-debug.debug-tracker-vscode",
            "mcu-debug.memory-view",
            "mcu-debug.peripheral-viewer",
            "mcu-debug.rtos-views",
            "probe-rs.probe-rs-debugger",
            "vadimcn.vscode-lldb",

            // CMake 支持
            "twxs.cmake",
            "ms-vscode.cmake-tools",
            "josetr.cmake-language-support-vscode",

            // Nix 语言支持
            "bbenoist.nix",

            // JavaScript/TypeScript 开发工具
            "ms-vscode.vscode-typescript-next",
            "xabikos.javascriptsnippets",
            "dsznajder.es7-react-js-snippets",
            "christian-kohler.npm-intellisense",
            "steoates.autoimport",

            // Vue.js 支持
            "vue.volar",

            // Dioxus (Rust GUI) 支持
            "dioxuslabs.dioxus",

            // Tauri 应用开发支持
            "tauri-apps.tauri-vscode",

            // .NET 运行时支持
            "ms-dotnettools.vscode-dotnet-runtime",

            // PowerShell 支持
            "ms-vscode.powershell",

            // ===========================
            // Web 开发工具
            // ===========================

            // TailwindCSS 智能提示
            "bradlc.vscode-tailwindcss",

            // HTML/CSS 支持增强
            "ecmel.vscode-html-css",

            // 自动重命名标签
            "formulahendry.auto-rename-tag",

            // 实时服务器预览
            "ritwickdey.liveserver",

            // XML 支持
            "dotjoshjohnson.xml",

            // ===========================
            // 标记语言和文档工具
            // ===========================

            // Markdown 全功能支持
            "yzhang.markdown-all-in-one",

            // Mermaid 图表支持
            "bierner.markdown-mermaid",
            "mermaidchart.vscode-mermaid-chart",

            // TOML 配置文件支持
            "tamasfe.even-better-toml",

            // YAML 配置文件支持
            "redhat.vscode-yaml",

            // PDF 查看器
            "tomoki1207.pdf",

            // SVG 预览
            "simonsiefke.svg-preview",

            // Jinja 模板支持
            "wholroyd.jinja",

            // ===========================
            // Git 版本控制工具
            // ===========================

            // Git 增强工具
            "eamodio.gitlens",

            // Git 历史查看
            "donjayamanne.githistory",

            // Git 图形化界面
            "mhutchie.git-graph",

            // GitHub 集成
            "github.vscode-pull-request-github",
            "github.vscode-github-actions",

            // ===========================
            // Docker 和容器化工具
            // ===========================

            // Docker 支持
            "ms-azuretools.vscode-docker",
            "docker.docker",

            // 容器开发支持
            "ms-azuretools.vscode-containers",

            // Kubernetes 工具
            "ms-kubernetes-tools.vscode-kubernetes-tools",

            // ===========================
            // 远程开发工具
            // ===========================

            // 远程开发扩展包
            "ms-vscode-remote.vscode-remote-extensionpack",
            "ms-vscode-remote.remote-ssh",
            "ms-vscode-remote.remote-ssh-edit",
            "ms-vscode-remote.remote-wsl",
            "ms-vscode-remote.remote-containers",
            "ms-vscode.remote-explorer",
            "ms-vscode.remote-server",

            // ===========================
            // 协作和智能编程工具
            // ===========================

            // GitHub Copilot AI 编程助手
            "github.copilot",
            "github.copilot-chat",

            // Visual Studio IntelliCode
            "visualstudioexptteam.vscodeintellicode",
            "visualstudioexptteam.intellicode-api-usage-examples",

            // Live Share 实时协作
            "ms-vsliveshare.vsliveshare",

            // ===========================
            // 实用工具和生产力工具
            // ===========================

            // 代码运行器
            "formulahendry.code-runner",

            // 代码截图工具
            "adpyke.codesnap",
            "pnp.polacode",

            // TODO 高亮和管理
            "gruntfuggly.todo-tree",

            // 依赖分析工具
            "fill-labs.dependi",

            // 时间跟踪工具
            "wakatime.vscode-wakatime",

            // Harper 语法检查
            "elijah-potter.harper",

            // ===========================
            // 编辑器增强和主题
            // ===========================

            // Vim 键位绑定
            "vscodevim.vim",

            // 编辑器动画效果
            "brandonkirbyson.vscode-animations",

            // 自定义 CSS 样式
            "be5invis.vscode-custom-css",
            "drcika.apc-extension",

            // ===========================
            // 图标和主题
            // ===========================

            // Material 图标主题
            "pkief.material-icon-theme",

            // Great Icons 图标包
            "emmanuelbeziat.vscode-great-icons",

            // Fluent Icons 图标包
            "miguelsolorio.fluent-icons",

            // ===========================
            // 颜色主题
            // ===========================

            // Dracula 主题
            "dracula-theme.theme-dracula",

            // Rose Pine 主题
            "mvllow.rose-pine",

            // Catppuccin Noctis 主题
            "alexdauenhauer.catppuccin-noctis"
          ],

          /**
          * 不推荐的扩展列表（可选）
          *
          * 功能说明：
          * - 此列表中的扩展不会被推荐给工作区用户
          * - 即使这些扩展很受欢迎，也会在推荐列表中被过滤掉
          * - 适用于已知与项目冲突或不适合团队使用的扩展
          */
          "unwantedRecommendations": [
            // 示例：如果团队不使用某个特定的扩展，可以添加到这里
            // "example.unwanted-extension"
          ]
      }
      '';

      target = ".config/Code/User/extensions.json";
      force = false;
    };
  };
}
