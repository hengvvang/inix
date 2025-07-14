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

# 键位绑定 - 人体工程学
# 标签导航
config.bind('J', 'tab-next')
config.bind('K', 'tab-prev')
config.bind('gt', 'tab-next')
config.bind('gT', 'tab-prev')

# 标签管理
config.bind('d', 'tab-close')
config.bind('u', 'undo')
config.bind('D', 'tab-close --opposite')

# 页面操作
config.bind('r', 'reload')
config.bind('R', 'reload --force')
config.bind('H', 'back')
config.bind('L', 'forward')

# 导航和搜索
config.bind('o', 'set-cmd-text -s :open ')
config.bind('O', 'set-cmd-text -s :open -t ')
config.bind('go', 'set-cmd-text :open {url}')
config.bind('gO', 'set-cmd-text :open -t {url}')

# 书签
config.bind('m', 'bookmark-add')
config.bind('b', 'set-cmd-text -s :bookmark-load ')

# 缩放
config.bind('+', 'zoom-in')
config.bind('=', 'zoom-in')
config.bind('-', 'zoom-out')
config.bind('0', 'zoom')

# 滚动增强
config.bind('<Ctrl+d>', 'scroll-page 0 0.5')
config.bind('<Ctrl+u>', 'scroll-page 0 -0.5')
config.bind('gg', 'scroll-to-perc 0')
config.bind('G', 'scroll-to-perc')

# 常用快捷键
config.bind('<Ctrl+l>', 'set-cmd-text -s :open ')
config.bind('<Ctrl+r>', 'reload')
config.bind('<Ctrl+w>', 'tab-close')
config.bind('<Ctrl+t>', 'open -t')
config.bind('<Ctrl+Shift+t>', 'undo')

# 开发者工具
config.bind('<F12>', 'devtools')
config.bind('<Ctrl+Shift+I>', 'devtools')

# 快速导航
config.bind('gi', 'hint inputs')  # 跳转到输入框
config.bind('gf', 'hint links spawn mpv {hint-url}')  # 用 mpv 播放链接

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
