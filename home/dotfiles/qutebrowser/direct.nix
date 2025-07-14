{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {
    # 直接文件写入 - 基础配置
    home.file.".config/qutebrowser/config.py".text = ''
      # Qutebrowser 配置文件
      
      # 基础设置
      c.colors.webpage.darkmode.enabled = True
      c.fonts.default_family = "JetBrains Mono"
      c.fonts.default_size = "11pt"
      
      # 隐私设置
      c.content.cookies.accept = "no-3rdparty"
      c.content.geolocation = False
      c.content.notifications.enabled = False
      c.content.autoplay = False
      
      # 标签页设置
      c.tabs.position = "top"
      c.tabs.show = "multiple"
      c.tabs.background = True
      
      # 下载设置
      c.downloads.location.directory = "~/Downloads"
      c.downloads.location.prompt = False
      
      # 搜索引擎
      c.url.searchengines = {
          'DEFAULT': 'https://www.google.com/search?q={}',
          'g': 'https://www.google.com/search?q={}',
          'b': 'https://www.bing.com/search?q={}',
          'd': 'https://duckduckgo.com/?q={}',
          'gh': 'https://github.com/search?q={}',
          'w': 'https://zh.wikipedia.org/wiki/{}',
          'y': 'https://www.youtube.com/results?search_query={}',
      }
      
      # 默认页面
      c.url.default_page = 'https://www.google.com'
      c.url.start_pages = ['https://www.google.com']
      
      # 键位绑定
      config.bind('J', 'tab-next')
      config.bind('K', 'tab-prev')
      config.bind('d', 'tab-close')
      config.bind('u', 'undo')
      config.bind('r', 'reload')
      config.bind('R', 'reload --force')
      config.bind('M', 'bookmark-add')
      config.bind('gb', 'set-cmd-text -s :bookmark-load')
      config.bind('gh', 'set-cmd-text -s :history')
      config.bind('<F12>', 'devtools')
      config.bind('=', 'zoom-in')
      config.bind('-', 'zoom-out')
      config.bind('0', 'zoom')
      
      # 会话管理
      c.auto_save.session = True
      c.session.lazy_restore = True
      
      # 编辑器
      c.editor.command = ['nvim', '{}']
    '';
    
    # 快速标记配置
    home.file.".config/qutebrowser/quickmarks".text = ''
      # Qutebrowser 快速标记
      google https://www.google.com
      github https://github.com
      youtube https://www.youtube.com
      wikipedia https://zh.wikipedia.org
      nixos https://nixos.org
      home-manager https://nix-community.github.io/home-manager/
    '';
    
    # 安装相关工具包
    home.packages = with pkgs; [
      qutebrowser
      yt-dlp
      mpv
    ];
  };
}
