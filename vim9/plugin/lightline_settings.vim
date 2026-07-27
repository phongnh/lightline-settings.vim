vim9script

# lightline_settings.vim
# Maintainer: Phong Nguyen
# Version:    1.0.0

if exists('g:loaded_vim_lightline_settings')
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

augroup LightlineSettings
    autocmd!
    autocmd CmdwinEnter * set filetype=cmdline syntax=vim
    # Only update on BufAdd/BufDelete for better performance
    autocmd BufAdd,BufDelete,BufFilePost * lightline_settings#buffer_count#Update()
    autocmd ColorScheme * lightline_settings#theme#Apply()
    autocmd OptionSet background lightline_settings#theme#Apply()
    if v:vim_did_enter
        lightline_settings#Init()
    else
        autocmd VimEnter * ++once lightline_settings#Init()
    endif
augroup END
