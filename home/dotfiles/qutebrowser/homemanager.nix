{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.qutebrowser = {
      enable = true;
      
      # 基础搜索引擎配置
      searchEngines = {
        DEFAULT = "https://www.google.com/search?q={}";
        g = "https://www.google.com/search?q={}";
        b = "https://www.bing.com/search?q={}";
        d = "https://duckduckgo.com/?q={}";
        gh = "https://github.com/search?q={}";
        w = "https://zh.wikipedia.org/wiki/{}";
        y = "https://www.youtube.com/results?search_query={}";
      };
      
      # 键位绑定
      keyBindings = {
        normal = {
          # 导航快捷键
          "J" = "tab-next";
          "K" = "tab-prev";
          "d" = "tab-close";
          "u" = "undo";
          "r" = "reload";
          "R" = "reload --force";
          
          # 书签和历史
          "M" = "bookmark-add";
          "gb" = "set-cmd-text -s :bookmark-load";
          "gh" = "set-cmd-text -s :history";
          
          # 开发者工具
          "<F12>" = "devtools";
          
          # 缩放
          "=" = "zoom-in";
          "-" = "zoom-out";
          "0" = "zoom";
        };
        
        command = {
          # 命令模式快捷键
          "<Ctrl+p>" = "completion-item-focus prev";
          "<Ctrl+n>" = "completion-item-focus next";
        };
      };
      
      # 设置配置
      settings = {
        # 外观设置
        colors.webpage.darkmode.enabled = true;
        colors.webpage.darkmode.policy.images = "never";
        fonts.default_family = "JetBrains Mono";
        fonts.default_size = "11pt";
        
        # 隐私和安全
        content.cookies.accept = "no-3rdparty";
        content.geolocation = false;
        content.notifications.enabled = false;
        content.autoplay = false;
        
        # 下载设置
        downloads.location.directory = "~/Downloads";
        downloads.location.prompt = false;
        
        # 标签页设置
        tabs.position = "top";
        tabs.show = "multiple";
        tabs.background = true;
        tabs.new_position.related = "next";
        
        # 状态栏
        statusbar.show = "in-mode";
        
        # 滚动设置
        scrolling.smooth = true;
        scrolling.bar = "when-searching";
        
        # 网页设置
        content.javascript.enabled = true;
        content.images = true;
        content.plugins = false;
        
        # 会话管理
        auto_save.session = true;
        session.lazy_restore = true;
        
        # URL 设置
        url.default_page = "https://www.google.com";
        url.start_pages = [ "https://www.google.com" ];
        
        # 缩放设置
        zoom.default = "100%";
        zoom.levels = [ "25%" "33%" "50%" "67%" "75%" "90%" "100%" "110%" "125%" "150%" "175%" "200%" "250%" "300%" "400%" "500%" ];
        
        # 编辑器
        editor.command = [ "nvim" "{file}" ];
        
        # 提示和补全
        completion.height = "50%";
        completion.show = "auto";
        completion.shrink = true;
        
        # 输入设置
        input.insert_mode.auto_enter = true;
        input.insert_mode.auto_leave = true;
        input.insert_mode.plugins = true;
        
        # 文件类型处理
        content.pdfjs = true;
      };
      
      # 额外的 Python 配置
      extraConfig = ''
        # 自定义 Python 配置
        
        # 配置特定网站的用户代理
        config.set('content.headers.user_agent', 
                  'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 
                  '*')
        
        # 配置广告拦截（基础）
        c.content.blocking.method = 'both'
        c.content.blocking.hosts.lists = [
            'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
        ]
        
        # 自定义快捷命令
        config.bind(',m', 'spawn mpv {url}')  # 使用 mpv 播放视频
        config.bind(',y', 'spawn --userscript qute-youtube-dl')  # YouTube 下载（需要脚本）
        config.bind(',p', 'spawn --userscript qute-pass')  # 密码管理（需要脚本）
        
        # 开发者模式快捷键
        config.bind('<F1>', 'inspector')
        config.bind('<Ctrl+Shift+I>', 'inspector')
        
        # 标签页管理
        config.bind('<Ctrl+Shift+T>', 'undo')
        config.bind('<Ctrl+w>', 'tab-close')
        config.bind('<Ctrl+t>', 'open -t')
        
        # 快速搜索
        config.bind('sg', 'set-cmd-text -s :open -t https://www.google.com/search?q=')
        config.bind('sb', 'set-cmd-text -s :open -t https://www.bing.com/search?q=')
        config.bind('sd', 'set-cmd-text -s :open -t https://duckduckgo.com/?q=')
      '';
    };
    
    # 安装相关工具包
    home.packages = with pkgs; [
      # YouTube 下载工具（配合 qutebrowser 脚本使用）
      yt-dlp
      # 视频播放器
      mpv
    ];
  };
}
