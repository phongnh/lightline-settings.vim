vim9script

# lightline_settings.vim
# Maintainer: Phong Nguyen
# Version:    1.0.0

if exists('g:loaded_vim_lightline_settings') || v:version < 700
    finish
endif

g:loaded_vim_lightline_settings = 1

# Settings
g:lightline_powerline_fonts = get(g:, 'lightline_powerline_fonts', 0)
g:lightline_shorten_path    = get(g:, 'lightline_shorten_path', 0)
g:lightline_show_short_mode = get(g:, 'lightline_show_short_mode', 0)
g:lightline_show_linenr     = get(g:, 'lightline_show_linenr', 0)
g:lightline_show_git_branch = get(g:, 'lightline_show_git_branch', 0)
g:lightline_show_devicons   = get(g:, 'lightline_show_devicons', 0) && lightline_settings#devicons#Detect()

# Window width
g:lightline_winwidth_config = extend({
    'compact': 80,
    'default': 100,
    'normal':  120,
}, get(g:, 'lightline_winwidth_config', {}))

# Lightline components
g:lightline = {
    colorscheme: 'default',
    enable: {
        statusline: 1,
        tabline:    1,
    },
    separator: {
        left: '',
        right: '',
    },
    subseparator: {
        left: '|',
        right: '|',
    },
    tabline: {
        left:  [['tablabel'], ['tabs']],
        right: [],
    },
    tab: {
        active:   ['tabname', 'modified'],
        inactive: ['tabname', 'modified'],
    },
    active: {
        left:  [
            ['section_a'],
            ['section_b'],
            ['section_c'],
        ],
        right: [
            ['section_z'],
            ['section_y'],
            ['section_x'],
        ]
    },
    inactive: {
        left:  [['inactive_section_a']],
        right: []
    },
    component: {
        tablabel:    'Tabs',
        bufferlabel: 'Buffers',
    },
    component_function: {
        section_a:          'lightline_settings#sections#SectionA',
        section_b:          'lightline_settings#sections#SectionB',
        section_c:          'lightline_settings#sections#SectionC',
        section_x:          'lightline_settings#sections#SectionX',
        section_y:          'lightline_settings#sections#SectionY',
        section_z:          'lightline_settings#sections#SectionZ',
        inactive_section_a: 'lightline_settings#sections#InactiveSectionA',
    },
    tab_component_function: {
        tabname:  'lightline_settings#tab#Name',
        modified: 'lightline_settings#tab#Modified',
    },
}

# Short Modes
g:lightline_short_mode_map = {
    'n':      'N',
    'i':      'I',
    'R':      'R',
    'v':      'V',
    'V':      'V-L',
    "\<C-v>": 'V-B',
    'c':      'C',
    's':      'S',
    'S':      'S-L',
    "\<C-s>": 'S-B',
    't':      'T',
}

if g:lightline_show_short_mode
    g:lightline.mode_map = copy(g:lightline_short_mode_map)
endif

# Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
g:lightline_symbols = {
    dos:       '[dos]',
    mac:       '[mac]',
    unix:      '[unix]',
    linenr:    '☰',
    branch:    '⎇ ',
    readonly:  '',
    bomb:      '🅑 ',
    noeol:     '∉ ',
    clipboard: '🅒 ',
    paste:     '🅟 ',
    ellipsis:  '…',
}

if g:lightline_powerline_fonts || g:lightline_show_devicons
    extend(g:lightline_symbols, {
        linenr:   "\ue0a1",
        branch:   "\ue0a0",
        readonly: "\ue0a2",
    })

    lightline_settings#powerline#SetSeparators(get(g:, 'lightline_powerline_style', 'default'))
endif

if g:lightline_show_devicons
    extend(g:lightline_symbols, {
        bomb:  "\ue287 ",
        noeol: "\ue293 ",
        dos:   "\ue70f",
        mac:   "\ue711",
        unix:  "\ue712",
    })
    # Show Vim Logo in Tabline
    g:lightline.component.tablabel    = "\ue7c5 "
    g:lightline.component.bufferlabel = "\ue7c5 "
endif

if get(g:, 'lightline_bufferline', 0)
    lightline_settings#bufferline#Init()
endif

command! LightlineReload lightline_settings#ReloadLightline()
command! -nargs=1 -complete=custom,lightline_settings#theme#List LightlineTheme lightline_settings#theme#Set(<f-args>)

# Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
g:lightline_buffer_count_by_basename = {}

# Throttle buffer count updates to avoid expensive operations on every event
var last_buffer_update: list<any> = []
var buffer_update_interval = 100  # milliseconds

def UpdateBufferCount()
    # Throttle updates - only run if enough time has passed
    var now = reltime()
    if !empty(last_buffer_update) && reltimefloat(reltime(last_buffer_update)) * 1000 < buffer_update_interval
        return
    endif
    last_buffer_update = now

    g:lightline_buffer_count_by_basename = {}
    var bufnrs = range(1, bufnr('$'))
        ->filter((_, v) => buflisted(v) && bufexists(v) && !empty(bufname(v)))
        ->map((_, v) => expand('#' .. v .. ':t'))
    for name in bufnrs
        if !empty(name)
            g:lightline_buffer_count_by_basename[name] = get(g:lightline_buffer_count_by_basename, name, 0) + 1
        endif
    endfor
enddef

import autoload 'lightline_settings/theme.vim'

augroup LightlineSettings
    autocmd!
    if v:vim_did_enter
        theme.Detect()
    else
        autocmd VimEnter * ++once theme.Detect()
    endif
    autocmd ColorScheme * theme.Apply()
    autocmd OptionSet background theme.Apply()
    # Only update on BufAdd/BufDelete for better performance
    autocmd BufAdd,BufDelete,BufFilePost * call('UpdateBufferCount', [])
    autocmd CmdwinEnter * set filetype=cmdline syntax=vim
augroup END
