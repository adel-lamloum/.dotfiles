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

# MPV bindings
config.bind('<Ctrl-v>', 'spawn mpv {url}')
config.bind('<Ctrl-Shift-v>', 'hint links spawn mpv {hint-url}')

### Miscellaneous ###
# Smooth scrolling
config.set('scrolling.smooth', True)

