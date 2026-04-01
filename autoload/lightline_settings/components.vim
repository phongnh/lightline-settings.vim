" Alternate status dictionaries
let g:lightline_filename_modes = {
            \ 'ControlP':             'CtrlP',
            \ '__CtrlSF__':           'CtrlSF',
            \ '__CtrlSFPreview__':    'Preview',
            \ '__flygrep__':          'FlyGrep',
            \ '__Tagbar__':           'Tagbar',
            \ '__Gundo__':            'Gundo',
            \ '__Gundo_Preview__':    'Gundo Preview',
            \ '__Mundo__':            'Mundo',
            \ '__Mundo_Preview__':    'Mundo Preview',
            \ '[BufExplorer]':        'BufExplorer',
            \ '[Command Line]':       'Command Line',
            \ '[Plugins]':            'Plugins',
            \ '__committia_status__': 'Git Status',
            \ '__committia_diff__':   'Git Diff',
            \ '__doc__':              'Document',
            \ '__LSP_SETTINGS__':     'LSP Settings',
            \ }

let g:lightline_filetype_modes = {
            \ 'bufexplorer':       'BufExplorer',
            \ 'simplebuffer':      'SimpleBuffer',
            \ 'netrw':             'Netrw',
            \ 'molder':            'Molder',
            \ 'dirvish':           'Dirvish',
            \ 'vaffle':            'Vaffle',
            \ 'nerdtree':          'NERDTree',
            \ 'fern':              'Fern',
            \ 'neo-tree':          'NeoTree',
            \ 'carbon.explorer':   'Carbon',
            \ 'oil':               'Oil',
            \ 'NvimTree':          'NvimTree',
            \ 'CHADTree':          'CHADTree',
            \ 'LuaTree':           'LuaTree',
            \ 'Mundo':             'Mundo',
            \ 'MundoDiff':         'Mundo Preview',
            \ 'undotree':          'Undo',
            \ 'diff':              'Diff',
            \ 'gundo':             'Gundo',
            \ 'startify':          'Startify',
            \ 'alpha':             'Alpha',
            \ 'dashboard':         'Dashboard',
            \ 'ministarter':       'Starter',
            \ 'tagbar':            'Tagbar',
            \ 'vim-plug':          'Plugins',
            \ 'terminal':          'TERMINAL',
            \ 'help':              'HELP',
            \ 'man':               'MAN',
            \ 'qf':                'Quickfix',
            \ 'godoc':             'GoDoc',
            \ 'gedoc':             'GeDoc',
            \ 'gitcommit':         'Commit Message',
            \ 'gitrebase':         'Git Rebase',
            \ 'fugitive':          'Git Status',
            \ 'fugitiveblame':     'FugitiveBlame',
            \ 'gitmessengerpopup': 'Git Messenger',
            \ 'GV':                'GV',
            \ 'agit':              'Agit',
            \ 'agit_diff':         'Git Diff',
            \ 'agit_stat':         'Git Stat',
            \ 'GrepperSide':       'GrepperSide',
            \ 'SpaceVimFlyGrep':   'FlyGrep',
            \ 'startuptime':       'StartupTime',
            \ }

let s:lightline_filename_integrations = {
            \ 'ControlP':          'lightline_settings#ctrlp#Statusline',
            \ '__CtrlSF__':        'lightline_settings#ctrlsf#Statusline',
            \ '__CtrlSFPreview__': 'lightline_settings#ctrlsf#PreviewStatusline',
            \ '__flygrep__':       'lightline_settings#flygrep#Statusline',
            \ '__Tagbar__':        'lightline_settings#tagbar#Statusline',
            \ }

let s:lightline_filetype_integrations = {
            \ 'cmdline':         'lightline_settings#cmdline#Statusline',
            \ 'ctrlp':           'lightline_settings#ctrlp#Statusline',
            \ 'nerdtree':        'lightline_settings#nerdtree#Statusline',
            \ 'netrw':           'lightline_settings#netrw#Statusline',
            \ 'dirvish':         'lightline_settings#dirvish#Statusline',
            \ 'molder':          'lightline_settings#molder#Statusline',
            \ 'vaffle':          'lightline_settings#vaffle#Statusline',
            \ 'fern':            'lightline_settings#fern#Statusline',
            \ 'carbon.explorer': 'lightline_settings#carbon#Statusline',
            \ 'neo-tree':        'lightline_settings#neotree#Statusline',
            \ 'oil':             'lightline_settings#oil#Statusline',
            \ 'undotree':        'lightline_settings#undotree#Statusline',
            \ 'diff':            'lightline_settings#diff#Statusline',
            \ 'tagbar':          'lightline_settings#tagbar#Statusline',
            \ 'NrrwRgn':         'lightline_settings#nrrwrgn#Statusline',
            \ 'git':             'lightline_settings#git#Statusline',
            \ 'gitcommit':       'lightline_settings#gitcommit#Statusline',
            \ 'gitrebase':       'lightline_settings#gitrebase#Statusline',
            \ 'fugitive':        'lightline_settings#fugitive#Statusline',
            \ 'GV':              'lightline_settings#gv#Statusline',
            \ 'terminal':        'lightline_settings#terminal#Statusline',
            \ 'help':            'lightline_settings#help#Statusline',
            \ 'man':             'lightline_settings#man#Statusline',
            \ 'qf':              'lightline_settings#quickfix#Statusline',
            \ 'ctrlsf':          'lightline_settings#ctrlsf#Statusline',
            \ 'GrepperSide':     'lightline_settings#grepper#Statusline',
            \ 'SpaceVimFlyGrep': 'lightline_settings#flygrep#Statusline',
            \ }

function! s:BufferType() abort
    return !empty(&filetype) ? &filetype : &buftype
endfunction

function! s:FileName() abort
    let l:fname = expand('%')
    return !empty(l:fname) ? fnamemodify(l:fname, ':~:.') : '[No Name]'
endfunction

function! s:IsClipboardEnabled() abort
    return stridx(&clipboard, 'unnamed') > -1
endfunction

function! s:IsCompact(...) abort
    let l:winnr = get(a:, 1, 0)
    return lightline_settings#GetWinWidth(l:winnr) <= g:lightline_winwidth_config.compact ||
                \ count([
                \   s:IsClipboardEnabled(),
                \   &paste,
                \   &spell,
                \   &bomb,
                \   !&eol,
                \ ], 1) > 1
endfunction

function! lightline_settings#components#Mode() abort
    if s:IsCompact()
        return get(g:lightline_short_mode_map, mode(), '')
    else
        return lightline#mode()
    endif
endfunction

function! lightline_settings#components#Clipboard() abort
    return s:IsClipboardEnabled() ? g:lightline_symbols.clipboard : ''
endfunction

function! lightline_settings#components#Paste() abort
    return &paste ? g:lightline_symbols.paste : ''
endfunction

function! lightline_settings#components#Spell() abort
    return &spell ? toupper(tr(&spelllang, ',', '/')) : ''
endfunction

function! s:Shiftwidth() abort
    return exists('*shiftwidth') ? shiftwidth() : &shiftwidth
endfunction

function! lightline_settings#components#Indentation(...) abort
    let l:compact = get(a:, 1, s:IsCompact())
    if &expandtab
        return (l:compact ? 'SPC' : 'Spaces') .. ': ' .. s:Shiftwidth()
    else
        return (l:compact ? 'TAB' : 'Tab Size') .. ': ' .. &tabstop
    endif
endfunction

function! lightline_settings#components#Readonly(...) abort
    return &readonly ? g:lightline_symbols.readonly .. ' ' : ''
endfunction

function! lightline_settings#components#Modified(...) abort
    if &modified
        return !&modifiable ? '[+-]' : '[+]'
    else
        return !&modifiable ? '[-]' : ''
    endif
endfunction

function! s:ZoomStatus(...) abort
    return get(g:, 'lightline_zoomstate', 0) ? '[Z]' : ''
endfunction

function! lightline_settings#components#Progress(...) abort
    if line('w0') == 1 && line('w$') == line('$')
        return 'All'
    elseif line('w0') == 1
        return 'Top'
    elseif line('w$') == line('$')
        return 'Bot'
    else
        return (line('.') * 100 / line('$')) .. '%'
    endif
endfunction

function! lightline_settings#components#Position(...) abort
    return printf('%4d:%-3d', line('.'), charcol('.'))
endfunction

function! lightline_settings#components#Ruler(...) abort
    return printf('%4d:%-3d %3s', line('.'), charcol('.'), lightline_settings#components#Progress())
endfunction

function! lightline_settings#components#FileEncodingAndFormat() abort
    " Skip encoding check if it's utf-8 and format is unix (common case)
    if &fileencoding ==# 'utf-8' && &fileformat ==# 'unix' && !&bomb && &eol
        return ''
    endif

    let l:parts = []

    let l:encoding = !empty(&fileencoding) ? &fileencoding : &encoding
    if !empty(l:encoding) && l:encoding !=# 'utf-8'
        call add(l:parts, l:encoding)
    endif

    if &bomb | call add(l:parts, g:lightline_symbols.bomb) | endif
    if !&eol | call add(l:parts, g:lightline_symbols.noeol) | endif

    if !empty(&fileformat) && &fileformat !=# 'unix'
        call add(l:parts, get(g:lightline_symbols, &fileformat, &fileformat))
    endif

    return join(l:parts, ' ')
endfunction

function! lightline_settings#components#FileType(...) abort
    return s:BufferType() .. lightline_settings#devicons#FileType(expand('%'))
endfunction

function! lightline_settings#components#FileName(...) abort
    return lightline_settings#components#Readonly() .. lightline_settings#FormatFileName(s:FileName()) .. s:ZoomStatus() .. lightline_settings#components#Modified()
endfunction

function! lightline_settings#components#InactiveFileName(...) abort
    return lightline_settings#components#Readonly() .. s:FileName() .. lightline_settings#components#Modified()
endfunction

function! lightline_settings#components#Integration() abort
    let l:ft = s:BufferType()

    if has_key(s:lightline_filetype_integrations, l:ft)
        return function(s:lightline_filetype_integrations[l:ft])()
    endif

    let l:fname = expand('%:t')

    if has_key(s:lightline_filename_integrations, l:fname)
        return function(s:lightline_filename_integrations[l:fname])()
    elseif l:fname =~# '^NrrwRgn_\zs.*\ze_\d\+$'
        " Fallback to filename check if NrrwRgn buffer's filetype is not set
        return lightline_settings#nrrwrgn#Statusline()
    endif

    if has_key(g:lightline_filetype_modes, l:ft)
        return { 'section_a': g:lightline_filetype_modes[l:ft] }
    endif

    if has_key(g:lightline_filename_modes, l:fname)
        return { 'section_a': g:lightline_filename_modes[l:fname] }
    endif

    return {}
endfunction

function! lightline_settings#components#GitBranch(...) abort
    return ''
endfunction

if g:lightline_show_git_branch > 0
    function! lightline_settings#components#GitBranch(...) abort
        return lightline_settings#gitbranch#Name()
    endfunction
endif
