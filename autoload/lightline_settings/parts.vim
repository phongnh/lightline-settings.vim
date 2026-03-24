vim9script

# Alternate status dictionaries
g:lightline_filename_modes = {
    ControlP:             'CtrlP',
    '__CtrlSF__':           'CtrlSF',
    '__CtrlSFPreview__':    'Preview',
    '__flygrep__':          'FlyGrep',
    '__Tagbar__':           'Tagbar',
    '__Gundo__':            'Gundo',
    '__Gundo_Preview__':    'Gundo Preview',
    '__Mundo__':            'Mundo',
    '__Mundo_Preview__':    'Mundo Preview',
    '[BufExplorer]':        'BufExplorer',
    '[Command Line]':       'Command Line',
    '[Plugins]':            'Plugins',
    '__committia_status__': 'Git Status',
    '__committia_diff__':   'Git Diff',
    '__doc__':              'Document',
    '__LSP_SETTINGS__':     'LSP Settings',
}

g:lightline_filetype_modes = {
    bufexplorer:       'BufExplorer',
    simplebuffer:      'SimpleBuffer',
    netrw:             'Netrw',
    molder:            'Molder',
    dirvish:           'Dirvish',
    vaffle:            'Vaffle',
    nerdtree:          'NERDTree',
    fern:              'Fern',
    Mundo:             'Mundo',
    MundoDiff:         'Mundo Preview',
    undotree:          'Undo',
    diff:              'Diff',
    gundo:             'Gundo',
    startify:          'Startify',
    dashboard:         'Dashboard',
    tagbar:            'Tagbar',
    vista:             'Vista',
    vista_kind:        'Vista',
    'vim-plug':          'Plugins',
    terminal:          'TERMINAL',
    help:              'HELP',
    man:               'MAN',
    qf:                'Quickfix',
    godoc:             'GoDoc',
    gedoc:             'GeDoc',
    gitcommit:         'Commit Message',
    gitrebase:         'Git Rebase',
    fugitive:          'Git Status',
    fugitiveblame:     'FugitiveBlame',
    gitmessengerpopup: 'Git Messenger',
    GV:                'GV',
    agit:              'Agit',
    agit_diff:         'Git Diff',
    agit_stat:         'Git Stat',
    GrepperSide:       'GrepperSide',
    SpaceVimFlyGrep:   'FlyGrep',
    startuptime:       'StartupTime',
}

const lightline_filename_integrations = {
    ControlP:          'lightline_settings#ctrlp#Mode',
    '__CtrlSF__':        'lightline_settings#ctrlsf#Mode',
    '__CtrlSFPreview__': 'lightline_settings#ctrlsf#PreviewMode',
    '__flygrep__':       'lightline_settings#flygrep#Mode',
    '__Tagbar__':        'lightline_settings#tagbar#Mode',
}

const lightline_filetype_integrations = {
    cmdline:         'lightline_settings#cmdline#Mode',
    ctrlp:           'lightline_settings#ctrlp#Mode',
    nerdtree:        'lightline_settings#nerdtree#Mode',
    netrw:           'lightline_settings#netrw#Mode',
    dirvish:         'lightline_settings#dirvish#Mode',
    molder:          'lightline_settings#molder#Mode',
    vaffle:          'lightline_settings#vaffle#Mode',
    fern:            'lightline_settings#fern#Mode',
    undotree:        'lightline_settings#undotree#Mode',
    diff:            'lightline_settings#diff#Mode',
    tagbar:          'lightline_settings#tagbar#Mode',
    vista_kind:      'lightline_settings#vista#Mode',
    vista:           'lightline_settings#vista#Mode',
    NrrwRgn:         'lightline_settings#nrrwrgn#Mode',
    git:             'lightline_settings#git#Mode',
    gitcommit:       'lightline_settings#gitcommit#Mode',
    gitrebase:       'lightline_settings#gitrebase#Mode',
    fugitive:        'lightline_settings#fugitive#Mode',
    GV:              'lightline_settings#gv#Mode',
    terminal:        'lightline_settings#terminal#Mode',
    help:            'lightline_settings#help#Mode',
    man:             'lightline_settings#man#Mode',
    qf:              'lightline_settings#quickfix#Mode',
    ctrlsf:          'lightline_settings#ctrlsf#Mode',
    GrepperSide:     'lightline_settings#grepper#Mode',
    SpaceVimFlyGrep: 'lightline_settings#flygrep#Mode',
}

def BufferType(): string
    return !empty(&filetype) ? &filetype : &buftype
enddef

def FileNameImpl(): string
    const fname = expand('%')
    return !empty(fname) ? fnamemodify(fname, ':~:.') : '[No Name]'
enddef

def IsClipboardEnabled(): bool
    return stridx(&clipboard, 'unnamed') > -1
enddef

def IsCompact(...args: list<any>): bool
    const winnr = get(args, 0, 0)
    return lightline_settings#GetWinWidth(winnr) <= g:lightline_winwidth_config.compact ||
        count([
            IsClipboardEnabled(),
            &paste,
            &spell,
            &bomb,
            !&eol,
        ], 1) > 1
enddef

export def Mode(): string
    if IsCompact()
        return get(g:lightline_short_mode_map, mode(), '')
    else
        return lightline#mode()
    endif
enddef

export def Clipboard(): string
    return IsClipboardEnabled() ? g:lightline_symbols.clipboard : ''
enddef

export def Paste(): string
    return &paste ? g:lightline_symbols.paste : ''
enddef

export def Spell(): string
    return &spell ? toupper(tr(&spelllang, ',', '/')) : ''
enddef

def Shiftwidth(): number
    return exists('*shiftwidth') ? shiftwidth() : &shiftwidth
enddef

export def Indentation(...args: list<any>): string
    const compact = get(args, 0, IsCompact())
    if &expandtab
        return (compact ? 'SPC' : 'Spaces') .. ': ' .. Shiftwidth()
    else
        return (compact ? 'TAB' : 'Tab Size') .. ': ' .. &tabstop
    endif
enddef

export def Readonly(...args: list<any>): string
    return &readonly ? g:lightline_symbols.readonly .. ' ' : ''
enddef

export def Modified(...args: list<any>): string
    if &modified
        return !&modifiable ? '[+-]' : '[+]'
    else
        return !&modifiable ? '[-]' : ''
    endif
enddef

def ZoomStatus(...args: list<any>): string
    return get(g:, 'lightline_zoomstate', 0) ? '[Z]' : ''
enddef

export def LineInfo(...args: list<any>): string
    if g:lightline_show_linenr > 1
        return lightline_settings#lineinfo#Full()
    elseif g:lightline_show_linenr > 0
        return lightline_settings#lineinfo#Simple()
    endif
    return ''
enddef

export def FileEncodingAndFormat(): string
    # Skip encoding check if it's utf-8 and format is unix (common case)
    if &fileencoding ==# 'utf-8' && &fileformat ==# 'unix' && !&bomb && &eol
        return ''
    endif

    var parts: list<string> = []

    const encoding = !empty(&fileencoding) ? &fileencoding : &encoding
    if !empty(encoding) && encoding !=# 'utf-8'
        add(parts, encoding)
    endif

    if &bomb | add(parts, g:lightline_symbols.bomb) | endif
    if !&eol | add(parts, g:lightline_symbols.noeol) | endif

    if !empty(&fileformat) && &fileformat !=# 'unix'
        add(parts, get(g:lightline_symbols, &fileformat, &fileformat))
    endif

    return join(parts, ' ')
enddef

export def FileType(...args: list<any>): string
    return BufferType() .. lightline_settings#devicons#FileType(expand('%'))
enddef

export def FileName(...args: list<any>): string
    return Readonly() .. lightline_settings#FormatFileName(FileNameImpl()) .. ZoomStatus() .. Modified()
enddef

export def InactiveFileName(...args: list<any>): string
    return Readonly() .. FileNameImpl() .. Modified()
enddef

export def Integration(): dict<any>
    const ft = BufferType()

    if has_key(lightline_filetype_integrations, ft)
        return function(lightline_filetype_integrations[ft])()
    endif

    const fname = expand('%:t')

    if has_key(lightline_filename_integrations, fname)
        return function(lightline_filename_integrations[fname])()
    elseif fname =~# '^NrrwRgn_\zs.*\ze_\d\+$'
        # Fallback to filename check if NrrwRgn buffer's filetype is not set
        return function('lightline_settings#nrrwrgn#Mode')()
    endif

    if has_key(g:lightline_filetype_modes, ft)
        return {section_a: g:lightline_filetype_modes[ft]}
    endif

    if has_key(g:lightline_filename_modes, fname)
        return {section_a: g:lightline_filename_modes[fname]}
    endif

    return {}
enddef

export def GitBranch(...args: list<any>): string
    if g:lightline_show_git_branch > 0
        return lightline_settings#gitbranch#Name()
    endif
    return ''
enddef
