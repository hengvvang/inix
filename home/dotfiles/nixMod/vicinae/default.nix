{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vicinae.enable && config.myHome.dotfiles.vicinae.configStyle == "homeManager") {

    # Vicinae - 现代化应用启动器
    # 使用 JSON 配置文件进行设置
    # 官方文档: https://docs.vicinae.com/config

    home.packages = with pkgs; [
      vicinae       # 现代化应用启动器
      lxgw-wenkai   # 霞鹜文楷字体,用于中文显示
    ];

    # 使用 xdg.configFile 管理配置文件
    # 因为 vicinae 使用 JSON 配置,没有专门的 Home Manager 模块
    xdg.configFile = {
      # Vicinae 主配置文件
      "vicinae/settings.json" = {
        # 配置文件内容 (JSON)
        text = builtins.toJSON {
          # ==========================================================================
          # 窗口行为设置
          # ==========================================================================
          close_on_focus_loss = true;   # 失去焦点时自动关闭窗口
          pop_to_root_on_close = false; # 关闭时不返回根搜索,保持搜索状态
          consider_preedit = true;      # 支持中文/日文等输入法

          # ==========================================================================
          # 搜索设置
          # ==========================================================================
          search_files_in_root = true;  # 在主界面直接搜索文件
          favicon_service = "twenty";   # Favicon 服务提供商

          # ==========================================================================
          # 键盘绑定
          # ==========================================================================
          keybinding = "default";       # Vim 风格键位 (Ctrl+J/K 上下, Ctrl+H/L 左右)

          # ==========================================================================
          # 字体设置
          # ==========================================================================
          font = {
            normal = {
              family = "auto";          # 自动使用系统默认字体
              size = 11;                # 字体大小
            };
          };

          # ==========================================================================
          # 主题设置
          # ==========================================================================
          theme = {
            light = {
              name = "vicinae-light";   # 亮色主题
              icon_theme = "auto";      # 自动检测图标主题
            };
            dark = {
              name = "vicinae-dark";    # 暗色主题
              icon_theme = "auto";
            };
          };

          # ==========================================================================
          # 启动器窗口设置
          # ==========================================================================
          launcher_window = {
            opacity = 0.96;             # 窗口不透明度

            # 客户端装饰
            csd = {
              enabled = true;           # 使用自定义窗口边框
              rounding = 12;            # 圆角半径
              border_width = 2;         # 边框宽度
            };

            # 窗口大小
            size = {
              width = 800;              # 窗口宽度
              height = 500;             # 窗口高度
            };

            screen = "auto";            # 在鼠标所在显示器上显示

            # Wayland Layer Shell 配置
            layer_shell = {
              scope = "vicinae";
              keyboard_interactivity = "exclusive";  # 独占键盘输入
              layer = "top";            # 顶层窗口
              enabled = true;           # 启用 Layer Shell
            };
          };

          # ==========================================================================
          # 收藏和快捷入口
          # ==========================================================================
          favorites = [
            "@vicinae/clipboard:history"  # 剪贴板历史
          ];

          # 当没有搜索结果时的后备选项
          fallbacks = [
            "@vicinae/files:search"       # 文件搜索
          ];

          # ==========================================================================
          # 自定义配置
          # ==========================================================================
          keybinds = { };               # 自定义快捷键 (空表示使用默认)
          providers = { };              # 扩展配置
        };
      };
    };
  };
}
