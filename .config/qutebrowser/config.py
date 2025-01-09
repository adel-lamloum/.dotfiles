# Load settings from config.py (disable autoconfig)
config.load_autoconfig(False)

### Aliases for commands ###
c.aliases = {
    'q': 'quit',
    'w': 'session-save',
    'wq': 'quit --save',
    'bd': 'tab-close',  # Close current tab
    'bn': 'tab-next',   # Next tab
    'bp': 'tab-prev',   # Previous tab
}

### Dark Mode and Colors ###
config.set("colors.webpage.darkmode.enabled", True)

# Completion widget colors
c.colors.completion.fg = ['#9cc4ff', 'white', 'white']
c.colors.completion.odd.bg = '#1c1f24'
c.colors.completion.even.bg = '#232429'
c.colors.completion.category.fg = '#e1acff'
c.colors.completion.category.bg = 'qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #000000, stop:1 #232429)'
c.colors.completion.category.border.top = '#3f4147'
c.colors.completion.category.border.bottom = '#3f4147'
c.colors.completion.item.selected.fg = '#282c34'
c.colors.completion.item.selected.bg = '#ecbe7b'
c.colors.completion.item.selected.match.fg = '#c678dd'
c.colors.completion.match.fg = '#c678dd'
c.colors.completion.scrollbar.fg = 'white'

# Downloads bar colors
c.colors.downloads.bar.bg = '#282c34'
c.colors.downloads.error.bg = '#ff6c6b'

# Hints colors
c.colors.hints.fg = '#282c34'
c.colors.hints.match.fg = '#98be65'

# Statusbar colors
c.colors.statusbar.normal.bg = '#282c34'
c.colors.statusbar.insert.fg = 'white'
c.colors.statusbar.insert.bg = '#497920'
c.colors.statusbar.passthrough.bg = '#34426f'
c.colors.statusbar.command.bg = '#1c1f24'  # Darker background for command mode
c.colors.statusbar.url.warn.fg = 'yellow'

# Tab colors
c.colors.tabs.bar.bg = '#1c1f34'
c.colors.tabs.odd.bg = '#282c34'
c.colors.tabs.even.bg = '#282c34'
c.colors.tabs.selected.odd.bg = '#3f4147'  # Darker background for selected tabs
c.colors.tabs.selected.even.bg = '#3f4147'
c.colors.tabs.pinned.odd.bg = 'seagreen'
c.colors.tabs.pinned.even.bg = 'darkseagreen'
c.colors.tabs.pinned.selected.odd.bg = '#282c34'
c.colors.tabs.pinned.selected.even.bg = '#282c34'

### Fonts ###
c.fonts.default_family = ['Source Code Pro', 'monospace']  # Fallback to monospace
c.fonts.default_size = '12pt'  # Slightly larger font size for better readability
c.fonts.completion.entry = '12pt "Source Code Pro"'
c.fonts.debug_console = '12pt "Source Code Pro"'
c.fonts.prompts = 'default_size sans-serif'
c.fonts.statusbar = '12pt "Source Code Pro"'

### Cookies and JavaScript ###
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

# Enable JavaScript for specific sites
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Disable JavaScript for specific sites (if needed)
# config.set('content.javascript.enabled', False, 'https://www.example.com')

### User Agent Settings ###
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:91.0) Gecko/20100101 Firefox/91.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:91.0) Gecko/20100101 Firefox/91.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:91.0) Gecko/20100101 Firefox/91.0', 'https://drive.google.com/*')

### Downloads ###
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = True  # Prompt for download location
c.downloads.location.remember = True  # Remember download location

### Tabs ###
c.tabs.show = "multiple"
c.tabs.position = "left"
c.tabs.padding = {
    "left": 10,
    "right": 10,
    "bottom": 10,
    "top": 10,
}

### Search Engines ###
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'am': 'https://www.amazon.com/s?k={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'goog': 'https://www.google.com/search?q={}',
    'hoog': 'https://hoogle.haskell.org/?hoogle={}',
    're': 'https://www.reddit.com/r/{}',
    'ub': 'https://www.urbandictionary.com/define.php?term={}',
    'wiki': 'https://en.wikipedia.org/wiki/{}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'gh': 'https://github.com/search?q={}',  # GitHub search
    'so': 'https://stackoverflow.com/search?q={}',  # Stack Overflow search
}

### URL Settings ###
c.url.default_page = 'https://www.google.com/'
c.url.start_pages = 'https://www.google.com/'

### Keybindings ###
# General navigation
config.bind('<Ctrl-n>', 'scroll down')
config.bind('<Ctrl-p>', 'scroll up')
config.bind('<Ctrl-a>', 'back')
config.bind('B', 'back')
config.bind('<Ctrl-e>', 'forward')
config.bind('F', 'forward')
config.bind('<Ctrl-x><Ctrl-f>', 'set-cmd-text -s :open -t')
config.bind('G', 'set-cmd-text -s :open -t')
config.bind('<Ctrl-u><Ctrl-x><Ctrl-f>', 'set-cmd-text -s :open')
config.bind('g', 'set-cmd-text -s :open')

# Tab management
config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')
config.bind('<Ctrl-t>', 'open -t')
config.bind('<Ctrl-w>', 'tab-close')
config.bind('<Ctrl-x>0', 'tab-close')
config.bind('q', 'tab-close')
config.bind('<Ctrl-x>1', 'tab-only')
config.bind('<Alt-a>', 'tab-prev')
config.bind('<Ctrl-c><Ctrl-p>', 'tab-prev')
config.bind('<Alt-e>', 'tab-next')
config.bind('<Ctrl-c><Ctrl-n>', 'tab-next')
config.bind('r', 'reload')
config.bind('c', 'yank')

# Searching
config.bind('<Ctrl-s>', 'set-cmd-text /', mode='normal')
config.bind('<Ctrl-r>', 'set-cmd-text ?', mode='normal')
config.bind('<Ctrl-s>', 'search-next', mode='command')
config.bind('<Ctrl-r>', 'search-prev', mode='command')

# Zooming
config.bind('+', 'zoom-in')
config.bind('-', 'zoom-out')

# Command mode
config.bind('<Alt-x>', 'cmd-set-text :')
config.bind('<Up>', 'command-history-prev', mode='command')
config.bind('<Ctrl-p>', 'command-history-prev', mode='command')
config.bind('<Down>', 'command-history-next', mode='command')
config.bind('<Ctrl-n>', 'command-history-next', mode='command')
config.bind('<Escape>', 'leave-mode', mode='command')
config.bind('<Ctrl-g>', 'leave-mode', mode='command')
config.bind('<Return>', 'command-accept', mode='command')
config.bind('<Ctrl-m>', 'command-accept', mode='command')
config.bind('<Shift-Tab>', 'completion-item-focus prev', mode='command')
config.bind('<Ctrl-Shift-i>', 'completion-item-focus prev', mode='command')
config.bind('<Tab>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-i>', 'completion-item-focus next', mode='command')

# Hinting
config.bind('<Ctrl-u>f', 'hint --rapid links tab-bg')
config.bind('f', 'hint')
config.bind('if', 'hint images')
config.bind('cf', 'hint links yank-primary')
config.bind('<Escape>', 'leave-mode', mode='hint')
config.bind('<Ctrl-g>', 'leave-mode', mode='hint')
config.bind('<Return>', 'follow-hint', mode='hint')
config.bind('<Ctrl-m>', 'follow-hint', mode='hint')

# Yes/No prompts
config.bind('y', 'prompt-accept yes', mode='yesno')
config.bind('n', 'prompt-accept no', mode='yesno')
config.bind('<Alt-w>', 'prompt-yank', mode='yesno')
config.bind('<Alt-u><Alt-w>', 'prompt-yank --sel', mode='yesno')
config.bind('<Escape>', 'leave-mode', mode='yesno')
config.bind('<Ctrl-g>', 'leave-mode', mode='yesno')
config.bind('<Return>', 'prompt-accept', mode='yesno')

# MPV bindings
config.bind('<Ctrl-v>', 'spawn mpv {url}')
config.bind('<Ctrl-Shift-v>', 'hint links spawn mpv {hint-url}')

### Miscellaneous ###
# Smooth scrolling
config.set('scrolling.smooth', True)

# Scroll speed
config.set('scrolling.speed', 100)  # Adjust scroll speed
