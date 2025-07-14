{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.qutebrowser = {
      enable = true;
      
      # 基础搜索引擎配置 - 优化常用引擎
      searchEngines = {
        DEFAULT = "https://www.google.com/search?q={}";
        g = "https://www.google.com/search?q={}";
        d = "https://duckduckgo.com/?q={}";
        gh = "https://github.com/search?q={}";
        w = "https://zh.wikipedia.org/wiki/{}";
        y = "https://www.youtube.com/results?search_query={}";
        n = "https://search.nixos.org/packages?query={}";  # Nix 包搜索
      };
      
      # 键位绑定 - 基于 Zen Browser 快捷键配置
      keyBindings = {
        normal = {
          # === 标签管理 (基于 Zen Browser) ===
          "<Ctrl+t>" = "open -t";                    # 新标签
          "<Ctrl+w>" = "tab-close";                  # 关闭标签
          "<Ctrl+Shift+t>" = "undo";                 # 恢复关闭的标签
          "<Ctrl+Shift+w>" = "close";                # 关闭窗口
          "<Ctrl+q>" = "close";                      # 退出应用
          
          # 标签切换 (Zen Browser 风格)
          "<Ctrl+Tab>" = "tab-next";                 # 下一个标签
          "<Ctrl+Shift+Tab>" = "tab-prev";           # 上一个标签
          "<Alt+1>" = "tab-focus 1";                 # 切换到标签 1
          "<Alt+2>" = "tab-focus 2";                 # 切换到标签 2
          "<Alt+3>" = "tab-focus 3";                 # 切换到标签 3
          "<Alt+4>" = "tab-focus 4";                 # 切换到标签 4
          "<Alt+5>" = "tab-focus 5";                 # 切换到标签 5
          "<Alt+6>" = "tab-focus 6";                 # 切换到标签 6
          "<Alt+7>" = "tab-focus 7";                 # 切换到标签 7
          "<Alt+8>" = "tab-focus 8";                 # 切换到标签 8
          "<Alt+9>" = "tab-focus -1";                # 切换到最后一个标签
          
          # === 导航 (基于 Zen Browser) ===
          "<Alt+Left>" = "back";                     # 后退
          "<Alt+Right>" = "forward";                 # 前进
          "<Ctrl+[>" = "back";                       # 后退 (替代)
          "<Ctrl+]>" = "forward";                    # 前进 (替代)
          "<Ctrl+r>" = "reload";                     # 刷新页面
          "<Ctrl+Shift+r>" = "reload --force";       # 强制刷新
          "<Ctrl+h>" = "set-cmd-text -s :history ";  # 历史记录
          
          # === 搜索和查找 (基于 Zen Browser) ===
          "<Ctrl+k>" = "set-cmd-text -s :open ";     # 搜索聚焦
          "<Ctrl+j>" = "set-cmd-text -s :open ";     # 搜索聚焦 (替代)
          "<Ctrl+f>" = "search";                     # 页面查找
          "<Ctrl+g>" = "search-next";                # 查找下一个
          "<Ctrl+Shift+g>" = "search-prev";          # 查找上一个
          
          # === 页面操作 (基于 Zen Browser) ===
          "<Ctrl+l>" = "set-cmd-text -s :open ";     # 地址栏
          "<Alt+d>" = "set-cmd-text -s :open ";      # 地址栏 (替代)
          "<Ctrl+s>" = "download";                   # 保存页面
          "<Ctrl+p>" = "print";                      # 打印页面
          "<Ctrl+u>" = "view-source";                # 查看源码
          
          # === 书签 (基于 Zen Browser) ===
          "<Ctrl+d>" = "bookmark-add";               # 添加书签
          "<Ctrl+Shift+d>" = "bookmark-add";         # 添加书签 (替代)
          "<Ctrl+Shift+o>" = "set-cmd-text -s :bookmark-load ";  # 书签库
          "<Ctrl+b>" = "set-cmd-text -s :bookmark-load ";        # 书签侧栏
          
          # === 媒体和显示 (基于 Zen Browser) ===
          "<Ctrl+m>" = "tab-mute";                   # 静音切换
          "<Ctrl+minus>" = "zoom-out";               # 缩小
          "<Ctrl+plus>" = "zoom-in";                 # 放大
          "<Ctrl+equal>" = "zoom-in";                # 放大 (不需要 Shift)
          "<Ctrl+0>" = "zoom";                       # 重置缩放
          
          # === 开发者工具 (基于 Zen Browser) ===
          "<Ctrl+Shift+i>" = "devtools";             # 开发者工具
          "<Ctrl+Shift+j>" = "devtools";             # 浏览器控制台
          "<Ctrl+Shift+k>" = "devtools";             # Web 控制台
          "<F12>" = "devtools";                      # 开发者工具 (传统)
          
          # === 其他功能 (基于 Zen Browser) ===
          "<Ctrl+o>" = "set-cmd-text :open ";        # 打开文件
          "<F11>" = "fullscreen";                    # 全屏切换
          "<Escape>" = "stop";                       # 停止加载
          "<Ctrl+Shift+Delete>" = "clear-cookies";   # 清除浏览数据
          
          # === 保留 vim 风格导航 (可选) ===
          "H" = "back";                              # vim 风格后退
          "L" = "forward";                           # vim 风格前进
          "gg" = "scroll-to-perc 0";                 # 滚动到顶部
          "G" = "scroll-to-perc";                    # 滚动到底部
          "j" = "scroll down";                       # 向下滚动
          "k" = "scroll up";                         # 向上滚动
          
          # === 快速导航 ===
          "gi" = "hint inputs";                      # 跳转到输入框
          "gf" = "hint links spawn mpv {hint-url}";  # 用 mpv 播放链接
        };
        
        command = {
          # 命令模式导航 - 更流畅
          "<Ctrl+p>" = "completion-item-focus prev";
          "<Ctrl+n>" = "completion-item-focus next";
          "<Tab>" = "completion-item-focus next";
          "<Shift+Tab>" = "completion-item-focus prev";
        };
      };
      
      # 设置配置 - 人体工程学优化
      settings = {
        # 外观设置 - 护眼优化
        colors.webpage.darkmode.enabled = true;
        colors.webpage.darkmode.policy.images = "smart";  # 智能图片模式
        fonts.default_family = "JetBrains Mono";
        fonts.default_size = "12pt";  # 稍大的字体，更护眼
        fonts.web.family.standard = "Inter";  # 网页使用更现代的字体
        fonts.web.family.serif = "Source Serif Pro";
        fonts.web.family.sans_serif = "Inter";
        fonts.web.size.default = 16;  # 网页默认字体大小
        
        # 隐私和安全 - 核心设置
        content.cookies.accept = "no-3rdparty";
        content.geolocation = false;
        content.notifications.enabled = false;
        content.autoplay = false;
        content.pdfjs = true;  # 内置 PDF 查看器
        
        # 下载设置 - 简化流程
        downloads.location.directory = "~/Downloads";
        downloads.location.prompt = false;
        downloads.remove_finished = 10000;  # 10秒后移除完成的下载
        
        # 标签页设置 - 提升效率
        tabs.position = "top";
        tabs.show = "multiple";
        tabs.background = true;
        tabs.new_position.related = "next";
        tabs.new_position.unrelated = "last";
        tabs.close_mouse_button = "middle";  # 中键关闭标签
        tabs.mousewheel_switching = false;   # 禁用鼠标滚轮切换（误操作）
        
        # 状态栏 - 减少干扰
        statusbar.show = "in-mode";
        
        # 滚动设置 - 更流畅
        scrolling.smooth = true;
        scrolling.bar = "when-searching";
        
        # 网页设置
        content.javascript.enabled = true;
        content.images = true;
        content.plugins = false;
        
        # 会话管理 - 提升启动体验
        auto_save.session = true;
        session.lazy_restore = true;
        
        # URL 设置 - 简洁起始页
        url.default_page = "about:blank";  # 空白页更快
        url.start_pages = [ "about:blank" ];
        
        # 缩放设置 - 实用范围
        zoom.default = "100%";
        zoom.levels = [ "50%" "67%" "75%" "90%" "100%" "110%" "125%" "150%" "175%" "200%" ];
        
        # 编辑器
        editor.command = [ "nvim" "{file}" ];
        
        # 补全设置 - 提升效率
        completion.height = "40%";  # 适中的高度
        completion.show = "auto";
        completion.shrink = true;
        completion.quick = true;    # 快速补全
        
        # 输入设置 - 减少模式切换
        input.insert_mode.auto_enter = true;
        input.insert_mode.auto_leave = true;
        input.insert_mode.plugins = true;
        
        # 提示设置 - 减少干扰
        messages.timeout = 3000;    # 3秒后自动隐藏消息
        
        # 性能优化
        content.cache.size = 52428800;  # 50MB 缓存
      };
      
      # 额外的 Python 配置 - Zen Browser 风格优化
      extraConfig = ''
        # 现代化用户代理 - 避免兼容性问题
        config.set('content.headers.user_agent', 
                  'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 
                  '*')
        
        # 广告拦截 - 基础配置
        c.content.blocking.method = 'both'
        c.content.blocking.hosts.lists = [
            'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
        ]
        
        # 智能 hints - 左手键位，类似 Zen Browser 的快速导航
        c.hints.chars = 'asdfghjkl'
        c.hints.uppercase = True
        
        # 搜索优化 - 类似 Zen Browser 的智能搜索
        c.search.ignore_case = 'smart'
        c.search.incremental = True
        
        # Zen Browser 风格的页面滚动
        config.bind('<Ctrl+d>', 'scroll-page 0 0.5')   # 半页下滚
        config.bind('<Ctrl+u>', 'scroll-page 0 -0.5')  # 半页上滚
        
        # 类似 Zen Browser 的快速操作
        config.bind('o', 'set-cmd-text -s :open ')      # 快速打开
        config.bind('O', 'set-cmd-text -s :open -t ')   # 新标签打开
        config.bind('go', 'set-cmd-text :open {url}')   # 编辑当前 URL
        config.bind('gO', 'set-cmd-text :open -t {url}') # 新标签编辑 URL
        
        # Zen Browser 风格的书签快捷键
        config.bind('b', 'set-cmd-text -s :bookmark-load ')  # 书签加载
        config.bind('B', 'bookmark-add')                     # 快速添加书签
        
        # 快速搜索 - 类似 Zen Browser 的搜索引擎切换
        config.bind('sg', 'set-cmd-text -s :open g ')        # Google 搜索
        config.bind('sd', 'set-cmd-text -s :open d ')        # DuckDuckGo 搜索
        config.bind('sy', 'set-cmd-text -s :open y ')        # YouTube 搜索
        config.bind('sn', 'set-cmd-text -s :open n ')        # Nix 包搜索
        
        # 开发者友好的快捷键
        config.bind('yy', 'yank url')                        # 复制当前 URL
        config.bind('yt', 'yank title')                      # 复制页面标题
        config.bind('ym', 'yank pretty-url')                # 复制格式化 URL
        
        # 标签页快速操作
        config.bind('gn', 'open -t')                         # 新标签页
        config.bind('gw', 'open -w')                         # 新窗口
        config.bind('gp', 'open -p')                         # 隐私窗口
        
        # 页面操作
        config.bind('m', 'bookmark-add')                     # 添加书签 (vim 风格)
        config.bind("'", 'set-cmd-text -s :history ')       # 历史记录
      '';
    };
    
    # 安装核心工具包
    home.packages = with pkgs; [
      mpv        # 视频播放器
    ];
  };
}
