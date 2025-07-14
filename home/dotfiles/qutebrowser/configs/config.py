# Qutebrowser 配置文件 - 人体工程学优化 (External 方式)

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

# 键位绑定 - Zen Browser 官方快捷键兼容

# === 标签管理 (Window & Tab Management) ===
config.bind('<Ctrl+t>', 'open -t')                 # New Tab
config.bind('<Ctrl+w>', 'tab-close')               # Close Tab
config.bind('<Ctrl+Shift+w>', 'close')             # Close Window
config.bind('<Ctrl+q>', 'quit')                    # Quit Application
config.bind('<Ctrl+Shift+t>', 'undo')              # Restore Last Closed Tab
config.bind('<Ctrl+Shift+n>', 'undo')              # Undo Close Window (映射到恢复标签)

# 标签选择 (Alt + 1-8 选择标签 1-8, Alt + 9 选择最后一个标签)
config.bind('<Alt+1>', 'tab-focus 1')
config.bind('<Alt+2>', 'tab-focus 2')
config.bind('<Alt+3>', 'tab-focus 3')
config.bind('<Alt+4>', 'tab-focus 4')
config.bind('<Alt+5>', 'tab-focus 5')
config.bind('<Alt+6>', 'tab-focus 6')
config.bind('<Alt+7>', 'tab-focus 7')
config.bind('<Alt+8>', 'tab-focus 8')
config.bind('<Alt+9>', 'tab-focus -1')  # 最后一个标签

# 标签切换
config.bind('<Ctrl+Tab>', 'tab-next')             # Next Tab
config.bind('<Ctrl+Shift+Tab>', 'tab-prev')       # Previous Tab

# === 导航 (Navigation) ===
config.bind('<Alt+Left>', 'back')                 # Go Back
config.bind('<Alt+Right>', 'forward')             # Go Forward
config.bind('<Ctrl+[>', 'back')                   # Navigate Back (Alternative)
config.bind('<Ctrl+]>', 'forward')                # Navigate Forward (Alternative)
config.bind('<Alt+Home>', 'home')                 # Go Home
config.bind('<Ctrl+r>', 'reload')                 # Reload Page
config.bind('<Ctrl+Shift+r>', 'reload --force')   # Reload Page (Skip Cache)
config.bind('<Ctrl+h>', 'history')                # Go to History
config.bind('<Ctrl+Shift+p>', 'open -p')          # Open Private Window

# === 搜索和查找 (Search & Find) ===
config.bind('<Ctrl+k>', 'set-cmd-text -s :open ')  # Focus Search
config.bind('<Ctrl+j>', 'set-cmd-text -s :open ')  # Focus Search (Alternative)
config.bind('<Ctrl+f>', 'search')                  # Find on Page
config.bind('<Ctrl+g>', 'search-next')             # Find Next
config.bind('<Ctrl+Shift+g>', 'search-prev')       # Find Previous

# === 页面操作 (Page Operations) ===
config.bind('<Ctrl+l>', 'set-cmd-text -s :open ')  # Open Location (URL Bar)
config.bind('<Alt+d>', 'set-cmd-text -s :open ')   # Open Location (Alternative)
config.bind('<Ctrl+s>', 'download')                # Save Page
config.bind('<Ctrl+p>', 'print')                   # Print Page
config.bind('<Ctrl+u>', 'view-source')             # View Page Source

# === 历史和书签 (History & Bookmarks) ===
config.bind('<Ctrl+Shift+h>', 'history')           # Show All History
config.bind('<Ctrl+d>', 'bookmark-add')            # Bookmark This Page
config.bind('<Ctrl+Shift+d>', 'bookmark-add')      # Bookmark This Page (Alternative)
config.bind('<Ctrl+Shift+o>', 'set-cmd-text -s :bookmark-load ')  # Show Bookmarks

# === 媒体和显示 (Media & Display) ===
config.bind('<Ctrl+m>', 'tab-mute')                # Toggle Mute
config.bind('<Ctrl+->', 'zoom-out')                # Zoom Out
config.bind('<Ctrl++>', 'zoom-in')                 # Zoom In
config.bind('<Ctrl+=>', 'zoom-in')                 # Zoom In (Alternative)
config.bind('<Ctrl+0>', 'zoom')                    # Reset Zoom
config.bind('<Ctrl+Shift+s>', 'screenshot')        # Take Screenshot

# === 开发者工具 (Developer Tools) ===
config.bind('<Ctrl+Shift+i>', 'devtools')          # Toggle DevTools
config.bind('<Ctrl+Shift+j>', 'devtools')          # Toggle Browser Console
config.bind('<Ctrl+Shift+m>', 'devtools')          # Toggle Responsive Design Mode
config.bind('<Ctrl+Shift+k>', 'devtools')          # Toggle Web Console
config.bind('<F12>', 'devtools')                   # Toggle DevTools (F12)

# === 其他功能 (Other Features) ===
config.bind('<Ctrl+Shift+y>', 'download')          # Open Downloads
config.bind('<Ctrl+o>', 'set-cmd-text -s :open ')  # Open File
config.bind('<F11>', 'fullscreen')                 # Enter/Exit Full Screen
config.bind('<Escape>', 'stop')                    # Stop Loading
config.bind('<Ctrl+b>', 'set-cmd-text -s :bookmark-load ')  # Show Bookmarks
config.bind('<Ctrl+Shift+Delete>', 'clear-cookies') # Clear Browsing Data

# === Vim 风格增强（保留部分，与 Zen 不冲突）===
config.bind('J', 'tab-next')                       # vim: 下个标签
config.bind('K', 'tab-prev')                       # vim: 上个标签
config.bind('H', 'back')                           # vim: 后退
config.bind('L', 'forward')                        # vim: 前进
config.bind('gg', 'scroll-to-perc 0')              # vim: 滚动到顶部
config.bind('G', 'scroll-to-perc')                 # vim: 滚动到底部
config.bind('d', 'tab-close')                      # vim: 关闭标签
config.bind('u', 'undo')                           # vim: 撤销
config.bind('r', 'reload')                         # vim: 刷新
config.bind('o', 'set-cmd-text -s :open ')         # vim: 打开
config.bind('O', 'set-cmd-text -s :open -t ')      # vim: 新标签打开
config.bind('yy', 'yank url')                      # vim: 复制 URL
config.bind('yt', 'yank title')                    # vim: 复制标题

# === 智能导航 ===
config.bind('gi', 'hint inputs')                   # 跳转到输入框
config.bind('gf', 'hint links spawn mpv {hint-url}')  # 用 mpv 播放链接
config.bind('<Ctrl+Shift+c>', 'yank url')          # 复制当前 URL

# 智能 hints - 提升点击效率
c.hints.chars = 'asdfghjkl'  # 左手键位，更快
c.hints.uppercase = True     # 大写更明显

# 搜索优化
c.search.ignore_case = 'smart'  # 智能大小写
c.search.incremental = True     # 增量搜索

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

# 广告拦截 - 基础配置
c.content.blocking.method = 'both'
c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
]
