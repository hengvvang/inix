{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {
    
    home.packages = with pkgs; [
      qutebrowser
      mpv
    ];

    home.file.".config/qutebrowser/config.py".text = ''
      # Qutebrowser 配置文件 - 核心体验优化
      
      # 外观设置 - 护眼优化
      c.colors.webpage.darkmode.enabled = True
      c.colors.webpage.darkmode.policy.images = "smart"  # 智能图片模式
      c.fonts.default_family = "JetBrains Mono"
      c.fonts.default_size = "12pt"  # 稍大字体，更护眼
      c.fonts.web.family.standard = "Inter"
      c.fonts.web.size.default = 16
      
      # 隐私设置 - 核心保护
      c.content.cookies.accept = "no-3rdparty"
      c.content.geolocation = False
      c.content.notifications.enabled = False
      c.content.autoplay = False
      
      # 标签页设置 - 提升效率
      c.tabs.position = "top"
      c.tabs.show = "multiple"
      c.tabs.background = True
      c.tabs.new_position.related = "next"
      c.tabs.close_mouse_button = "middle"  # 中键关闭
      c.tabs.mousewheel_switching = False   # 禁用滚轮切换
      
      # 下载设置 - 简化流程
      c.downloads.location.directory = "~/Downloads"
      c.downloads.location.prompt = False
      c.downloads.remove_finished = 10000  # 10秒后移除
      
      # 搜索引擎 - 常用优化
      c.url.searchengines = {
          'DEFAULT': 'https://www.google.com/search?q={}',
          'g': 'https://www.google.com/search?q={}',
          'd': 'https://duckduckgo.com/?q={}',
          'gh': 'https://github.com/search?q={}',
          'w': 'https://zh.wikipedia.org/wiki/{}',
          'y': 'https://www.youtube.com/results?search_query={}',
          'n': 'https://search.nixos.org/packages?query={}',
      }
      
      # 默认页面 - 快速启动
      c.url.default_page = 'about:blank'
      c.url.start_pages = ['about:blank']
      
      # 键位绑定 - Zen Browser 风格
      # === 标签管理 ===
      config.bind('<Ctrl+t>', 'open -t')                    # 新标签
      config.bind('<Ctrl+w>', 'tab-close')                  # 关闭标签
      config.bind('<Ctrl+Shift+t>', 'undo')                 # 恢复关闭的标签
      config.bind('<Ctrl+Shift+w>', 'close')                # 关闭窗口
      config.bind('<Ctrl+q>', 'close')                      # 退出应用
      
      # 标签切换
      config.bind('<Ctrl+Tab>', 'tab-next')                 # 下一个标签
      config.bind('<Ctrl+Shift+Tab>', 'tab-prev')           # 上一个标签
      config.bind('<Alt+1>', 'tab-focus 1')                 # 切换到标签 1
      config.bind('<Alt+2>', 'tab-focus 2')                 # 切换到标签 2
      config.bind('<Alt+3>', 'tab-focus 3')                 # 切换到标签 3
      config.bind('<Alt+4>', 'tab-focus 4')                 # 切换到标签 4
      config.bind('<Alt+5>', 'tab-focus 5')                 # 切换到标签 5
      config.bind('<Alt+6>', 'tab-focus 6')                 # 切换到标签 6
      config.bind('<Alt+7>', 'tab-focus 7')                 # 切换到标签 7
      config.bind('<Alt+8>', 'tab-focus 8')                 # 切换到标签 8
      config.bind('<Alt+9>', 'tab-focus -1')                # 切换到最后一个标签
      
      # === 导航 ===
      config.bind('<Alt+Left>', 'back')                     # 后退
      config.bind('<Alt+Right>', 'forward')                 # 前进
      config.bind('<Ctrl+[>', 'back')                       # 后退 (替代)
      config.bind('<Ctrl+]>', 'forward')                    # 前进 (替代)
      config.bind('<Ctrl+r>', 'reload')                     # 刷新页面
      config.bind('<Ctrl+Shift+r>', 'reload --force')       # 强制刷新
      config.bind('<Ctrl+h>', 'set-cmd-text -s :history ')  # 历史记录
      
      # === 搜索和查找 ===
      config.bind('<Ctrl+k>', 'set-cmd-text -s :open ')     # 搜索聚焦
      config.bind('<Ctrl+j>', 'set-cmd-text -s :open ')     # 搜索聚焦 (替代)
      config.bind('<Ctrl+f>', 'search')                     # 页面查找
      config.bind('<Ctrl+g>', 'search-next')                # 查找下一个
      config.bind('<Ctrl+Shift+g>', 'search-prev')          # 查找上一个
      
      # === 页面操作 ===
      config.bind('<Ctrl+l>', 'set-cmd-text -s :open ')     # 地址栏
      config.bind('<Alt+d>', 'set-cmd-text -s :open ')      # 地址栏 (替代)
      config.bind('<Ctrl+s>', 'download')                   # 保存页面
      config.bind('<Ctrl+p>', 'print')                      # 打印页面
      config.bind('<Ctrl+u>', 'view-source')                # 查看源码
      
      # === 书签 ===
      config.bind('<Ctrl+d>', 'bookmark-add')               # 添加书签
      config.bind('<Ctrl+Shift+d>', 'bookmark-add')         # 添加书签 (替代)
      config.bind('<Ctrl+Shift+o>', 'set-cmd-text -s :bookmark-load ')  # 书签库
      config.bind('<Ctrl+b>', 'set-cmd-text -s :bookmark-load ')        # 书签侧栏
      
      # === 媒体和显示 ===
      config.bind('<Ctrl+m>', 'tab-mute')                   # 静音切换
      config.bind('<Ctrl+minus>', 'zoom-out')               # 缩小
      config.bind('<Ctrl+plus>', 'zoom-in')                 # 放大
      config.bind('<Ctrl+equal>', 'zoom-in')                # 放大 (不需要 Shift)
      config.bind('<Ctrl+0>', 'zoom')                       # 重置缩放
      
      # === 开发者工具 ===
      config.bind('<Ctrl+Shift+i>', 'devtools')             # 开发者工具
      config.bind('<Ctrl+Shift+j>', 'devtools')             # 浏览器控制台
      config.bind('<Ctrl+Shift+k>', 'devtools')             # Web 控制台
      config.bind('<F12>', 'devtools')                      # 开发者工具 (传统)
      
      # === 其他功能 ===
      config.bind('<Ctrl+o>', 'set-cmd-text :open ')        # 打开文件
      config.bind('<F11>', 'fullscreen')                    # 全屏切换
      config.bind('<Escape>', 'stop')                       # 停止加载
      
      # === vim 风格导航 (可选) ===
      config.bind('H', 'back')                              # vim 风格后退
      config.bind('L', 'forward')                           # vim 风格前进
      config.bind('gg', 'scroll-to-perc 0')                 # 滚动到顶部
      config.bind('G', 'scroll-to-perc')                    # 滚动到底部
      config.bind('j', 'scroll down')                       # 向下滚动
      config.bind('k', 'scroll up')                         # 向上滚动
      
      # === 快速操作 ===
      config.bind('o', 'set-cmd-text -s :open ')            # 快速打开
      config.bind('O', 'set-cmd-text -s :open -t ')         # 新标签打开
      config.bind('b', 'set-cmd-text -s :bookmark-load ')   # 书签加载
      config.bind('m', 'bookmark-add')                      # 添加书签
      config.bind('gi', 'hint inputs')                      # 跳转到输入框
      
      # 智能 hints
      c.hints.chars = 'asdfghjkl'
      c.hints.uppercase = True
      
      # 搜索优化
      c.search.ignore_case = 'smart'
      c.search.incremental = True
      
      # 补全优化
      c.completion.height = "40%"
      c.completion.quick = True
      
      # 性能优化
      c.content.cache.size = 52428800  # 50MB
      c.messages.timeout = 3000
      
      # 会话管理
      c.auto_save.session = True
      c.session.lazy_restore = True
      
      # 编辑器
      c.editor.command = ['nvim', '{}']
    '';
    
    # 快速标记配置 - 实用书签
    home.file.".config/qutebrowser/quickmarks".text = ''
      # 核心网站
      google https://www.google.com
      github https://github.com
      
      # 开发资源
      nixos https://nixos.org
      nix-search https://search.nixos.org/packages
      home-manager https://nix-community.github.io/home-manager/
      
      # 常用站点
      youtube https://www.youtube.com
      wikipedia https://zh.wikipedia.org
    '';
    
  };
}
