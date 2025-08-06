{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {
    
    home.file.".config/qutebrowser/config.py" = {
      text = ''
        # Qutebrowser 配置文件
        # 配置方式: direct - 直接文件配置

        import subprocess
        import os

        # 基本设置
        c.auto_save.session = True
        c.auto_save.interval = 15000
        c.session.lazy_restore = True

        # 字体设置
        c.fonts.default_family = "JetBrains Mono"
        c.fonts.default_size = "12pt"
        c.fonts.web.family.standard = "JetBrains Mono"
        c.fonts.web.family.serif = "JetBrains Mono"
        c.fonts.web.family.sans_serif = "JetBrains Mono"
        c.fonts.web.family.monospace = "JetBrains Mono"

        # 搜索引擎
        c.url.searchengines = {
            'DEFAULT': 'https://duckduckgo.com/?q={}',
            'g': 'https://www.google.com/search?q={}',
            'gh': 'https://github.com/search?q={}',
            'so': 'https://stackoverflow.com/search?q={}',
            'w': 'https://en.wikipedia.org/wiki/{}',
            'y': 'https://www.youtube.com/results?search_query={}',
            'r': 'https://www.reddit.com/search/?q={}',
        }

        # 起始页和新标签页
        c.url.start_pages = ['https://duckduckgo.com']
        c.url.default_page = 'https://duckduckgo.com'

        # 下载设置
        c.downloads.location.directory = '~/Downloads'
        c.downloads.location.suggestion = 'both'
        c.downloads.remove_finished = 10000

        # 标签页设置
        c.tabs.show = 'multiple'
        c.tabs.position = 'top'
        c.tabs.title.format = '{audio}{index}: {current_title}'
        c.tabs.title.format_pinned = '{audio}{index}'
        c.tabs.background = True
        c.tabs.last_close = 'close'
        c.tabs.new_position.related = 'next'
        c.tabs.new_position.unrelated = 'last'

        # 状态栏设置
        c.statusbar.show = 'in-mode'
        c.statusbar.position = 'bottom'

        # 补全设置
        c.completion.show = 'auto'
        c.completion.height = '50%'
        c.completion.web_history.max_items = 1000
        c.completion.cmd_history_max_items = 100

        # 提示设置
        c.hints.chars = 'asdfghjkl'
        c.hints.uppercase = False

        # 滚动设置
        c.scrolling.smooth = True
        c.scrolling.bar = 'when-searching'

        # 缩放设置
        c.zoom.default = '100%'

        # 内容设置
        c.content.autoplay = False
        c.content.blocking.method = 'both'
        c.content.cookies.accept = 'no-3rdparty'
        c.content.geolocation = 'ask'
        c.content.notifications.enabled = 'ask'
        c.content.pdfjs = True
        c.content.plugins = False
        c.content.prefers_reduced_motion = True

        # 颜色主题 - GitHub Dark
        c.colors.completion.category.bg = '#21262d'
        c.colors.completion.category.border.bottom = '#30363d'
        c.colors.completion.category.border.top = '#30363d'
        c.colors.completion.category.fg = '#c9d1d9'
        c.colors.completion.even.bg = '#0d1117'
        c.colors.completion.fg = '#c9d1d9'
        c.colors.completion.item.selected.bg = '#58a6ff'
        c.colors.completion.item.selected.border.bottom = '#58a6ff'
        c.colors.completion.item.selected.border.top = '#58a6ff'
        c.colors.completion.item.selected.fg = '#0d1117'
        c.colors.completion.item.selected.match.fg = '#0d1117'
        c.colors.completion.match.fg = '#f0883e'
        c.colors.completion.odd.bg = '#21262d'
        c.colors.completion.scrollbar.bg = '#0d1117'
        c.colors.completion.scrollbar.fg = '#c9d1d9'

        # 下载栏颜色
        c.colors.downloads.bar.bg = '#0d1117'
        c.colors.downloads.error.bg = '#ff7b72'
        c.colors.downloads.error.fg = '#0d1117'
        c.colors.downloads.start.bg = '#58a6ff'
        c.colors.downloads.start.fg = '#0d1117'
        c.colors.downloads.stop.bg = '#7ee787'
        c.colors.downloads.stop.fg = '#0d1117'

        # 提示颜色
        c.colors.hints.bg = '#f0883e'
        c.colors.hints.fg = '#0d1117'
        c.colors.hints.match.fg = '#0d1117'

        # 键映射颜色
        c.colors.keyhint.bg = '#0d1117'
        c.colors.keyhint.fg = '#c9d1d9'
        c.colors.keyhint.suffix.fg = '#f0883e'

        # 消息颜色
        c.colors.messages.error.bg = '#ff7b72'
        c.colors.messages.error.border = '#ff7b72'
        c.colors.messages.error.fg = '#0d1117'
        c.colors.messages.info.bg = '#58a6ff'
        c.colors.messages.info.border = '#58a6ff'
        c.colors.messages.info.fg = '#0d1117'
        c.colors.messages.warning.bg = '#f0883e'
        c.colors.messages.warning.border = '#f0883e'
        c.colors.messages.warning.fg = '#0d1117'

        # 提示栏颜色
        c.colors.prompts.bg = '#21262d'
        c.colors.prompts.border = '#30363d'
        c.colors.prompts.fg = '#c9d1d9'
        c.colors.prompts.selected.bg = '#58a6ff'
        c.colors.prompts.selected.fg = '#0d1117'

        # 状态栏颜色
        c.colors.statusbar.caret.bg = '#da77f2'
        c.colors.statusbar.caret.fg = '#0d1117'
        c.colors.statusbar.caret.selection.bg = '#da77f2'
        c.colors.statusbar.caret.selection.fg = '#0d1117'
        c.colors.statusbar.command.bg = '#0d1117'
        c.colors.statusbar.command.fg = '#c9d1d9'
        c.colors.statusbar.command.private.bg = '#0d1117'
        c.colors.statusbar.command.private.fg = '#c9d1d9'
        c.colors.statusbar.insert.bg = '#7ee787'
        c.colors.statusbar.insert.fg = '#0d1117'
        c.colors.statusbar.normal.bg = '#0d1117'
        c.colors.statusbar.normal.fg = '#c9d1d9'
        c.colors.statusbar.passthrough.bg = '#58a6ff'
        c.colors.statusbar.passthrough.fg = '#0d1117'
        c.colors.statusbar.private.bg = '#0d1117'
        c.colors.statusbar.private.fg = '#c9d1d9'
        c.colors.statusbar.progress.bg = '#c9d1d9'
        c.colors.statusbar.url.error.fg = '#ff7b72'
        c.colors.statusbar.url.fg = '#c9d1d9'
        c.colors.statusbar.url.hover.fg = '#58a6ff'
        c.colors.statusbar.url.success.http.fg = '#7ee787'
        c.colors.statusbar.url.success.https.fg = '#7ee787'
        c.colors.statusbar.url.warn.fg = '#f0883e'

        # 标签页颜色
        c.colors.tabs.bar.bg = '#21262d'
        c.colors.tabs.even.bg = '#21262d'
        c.colors.tabs.even.fg = '#7d8590'
        c.colors.tabs.indicator.error = '#ff7b72'
        c.colors.tabs.indicator.start = '#58a6ff'
        c.colors.tabs.indicator.stop = '#7ee787'
        c.colors.tabs.odd.bg = '#21262d'
        c.colors.tabs.odd.fg = '#7d8590'
        c.colors.tabs.pinned.even.bg = '#21262d'
        c.colors.tabs.pinned.even.fg = '#7d8590'
        c.colors.tabs.pinned.odd.bg = '#21262d'
        c.colors.tabs.pinned.odd.fg = '#7d8590'
        c.colors.tabs.pinned.selected.even.bg = '#58a6ff'
        c.colors.tabs.pinned.selected.even.fg = '#0d1117'
        c.colors.tabs.pinned.selected.odd.bg = '#58a6ff'
        c.colors.tabs.pinned.selected.odd.fg = '#0d1117'
        c.colors.tabs.selected.even.bg = '#58a6ff'
        c.colors.tabs.selected.even.fg = '#0d1117'
        c.colors.tabs.selected.odd.bg = '#58a6ff'
        c.colors.tabs.selected.odd.fg = '#0d1117'

        # 网页内容设置
        c.colors.webpage.bg = '#0d1117'
        c.colors.webpage.darkmode.enabled = True
        c.colors.webpage.darkmode.policy.images = 'never'
        c.colors.webpage.darkmode.threshold.background = 205
        c.colors.webpage.darkmode.threshold.text = 150
        c.colors.webpage.prefers_color_scheme_dark = True

        # 键绑定
        config.bind('J', 'tab-prev')
        config.bind('K', 'tab-next')
        config.bind('h', 'back')
        config.bind('l', 'forward')
        config.bind('r', 'reload')
        config.bind('R', 'reload -f')
        config.bind('x', 'tab-close')
        config.bind('X', 'undo')
        config.bind('t', 'cmd-set-text -s :open -t')
        config.bind('T', 'cmd-set-text -s :open -t {url:pretty}')
        config.bind('o', 'cmd-set-text -s :open')
        config.bind('O', 'cmd-set-text -s :open {url:pretty}')
        config.bind('/', 'cmd-set-text /')
        config.bind('?', 'cmd-set-text ?')
        config.bind('n', 'search-next')
        config.bind('N', 'search-prev')
        config.bind('gi', 'hint inputs')
        config.bind('yy', 'yank')
        config.bind('pp', 'open -- {clipboard}')
        config.bind('PP', 'open -t -- {clipboard}')
        config.bind('<Ctrl+Shift+t>', 'undo')
        config.bind('<Ctrl+w>', 'tab-close')
        config.bind('<Ctrl+Shift+w>', 'close')
        config.bind('<Ctrl+t>', 'open -t')
        config.bind('<F5>', 'reload')
        config.bind('<Ctrl+F5>', 'reload -f')
        config.bind('<Ctrl+l>', 'cmd-set-text -s :open')

        # 加载本地设置（如果存在）
        config.load_autoconfig(False)

        print("🌐 Qutebrowser Direct Mode Loaded")
      '';
    };
  };
}
