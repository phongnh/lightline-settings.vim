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
            \ 'vista':             'Vista',
            \ 'vista_kind':        'Vista',
            \ 'vim-plug':          'Plugins',
            \ 'terminal':          'TERMINAL',
            \ 'help':              'HELP',
            \ 'qf':                'Quickfix',
            \ 'godoc':             'GoDoc',
            \ 'gedoc':             'GeDoc',
            \ 'gitcommit':         'Commit Message',
            \ 'gitrebase':         'Git Rebase',
            \ 'fugitive':          'Fugitive',
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
            \ 'ControlP':          'lightline_settings#ctrlp#Mode',
            \ '__CtrlSF__':        'lightline_settings#ctrlsf#Mode',
            \ '__CtrlSFPreview__': 'lightline_settings#ctrlsf#PreviewMode',
            \ '__flygrep__':       'lightline_settings#flygrep#Mode',
            \ '__Tagbar__':        'lightline_settings#tagbar#Mode',
            \ }

let s:lightline_filetype_integrations = {
            \ 'cmdline':         'lightline_settings#cmdline#Mode',
            \ 'ctrlp':           'lightline_settings#ctrlp#Mode',
            \ 'netrw':           'lightline_settings#netrw#Mode',
            \ 'dirvish':         'lightline_settings#dirvish#Mode',
            \ 'molder':          'lightline_settings#molder#Mode',
            \ 'vaffle':          'lightline_settings#vaffle#Mode',
            \ 'fern':            'lightline_settings#fern#Mode',
            \ 'carbon.explorer': 'lightline_settings#carbon#Mode',
            \ 'neo-tree':        'lightline_settings#neotree#Mode',
            \ 'oil':             'lightline_settings#oil#Mode',
            \ 'undotree':        'lightline_settings#undotree#Mode',
            \ 'diff':            'lightline_settings#diff#Mode',
            \ 'tagbar':          'lightline_settings#tagbar#Mode',
            \ 'vista_kind':      'lightline_settings#vista#Mode',
            \ 'vista':           'lightline_settings#vista#Mode',
            \ 'NrrwRgn':         'lightline_settings#nrrwrgn#Mode',
            \ 'git':             'lightline_settings#git#Mode',
            \ 'gitcommit':       'lightline_settings#gitcommit#Mode',
            \ 'gitrebase':       'lightline_settings#gitrebase#Mode',
            \ 'fugitive':        'lightline_settings#fugitive#Mode',
            \ 'GV':              'lightline_settings#gv#Mode',
            \ 'terminal':        'lightline_settings#terminal#Mode',
            \ 'help':            'lightline_settings#help#Mode',
            \ 'qf':              'lightline_settings#quickfix#Mode',
            \ 'ctrlsf':          'lightline_settings#ctrlsf#Mode',
            \ 'GrepperSide':     'lightline_settings#grepper#Mode',
            \ 'SpaceVimFlyGrep': 'lightline_settings#flygrep#Mode',
            \ }

" Cache window width to avoid repeated winwidth() calls
let s:cached_winwidth = 0
let s:cached_winwidth_nr = 0

function! s:GetWinWidth(...) abort
    let l:winnr = get(a:, 1, 0)
    " Cache is only valid for current window in current update
    if l:winnr == s:cached_winwidth_nr && s:cached_winwidth > 0
        return s:cached_winwidth
    endif
    let s:cached_winwidth = winwidth(l:winnr)
    let s:cached_winwidth_nr = l:winnr
    return s:cached_winwidth
endfunction

" Expose for use in other modules
function! lightline_settings#parts#GetWinWidth(...) abort
    return call('s:GetWinWidth', a:000)
endfunction

" Clear width cache (called by lightline on update)
function! lightline_settings#parts#ClearWidthCache() abort
    let s:cached_winwidth = 0
    let s:cached_winwidth_nr = 0
endfunction

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
    return s:GetWinWidth(l:winnr) <= g:lightline_winwidth_config.compact ||
                \ count([
                \   s:IsClipboardEnabled(),
                \   &paste,
                \   &spell,
                \   &bomb,
                \   !&eol,
                \ ], 1) > 1
endfunction

function! lightline_settings#parts#Mode() abort
    if s:IsCompact()
        return get(g:lightline_short_mode_map, mode(), '')
    else
        return lightline#mode()
    endif
endfunction

function! lightline_settings#parts#Clipboard() abort
    return s:IsClipboardEnabled() ? g:lightline_symbols.clipboard : ''
endfunction

function! lightline_settings#parts#Paste() abort
    return &paste ? g:lightline_symbols.paste : ''
endfunction

function! lightline_settings#parts#Spell() abort
    return &spell ? toupper(tr(&spelllang, ',', '/')) : ''
endfunction

function! lightline_settings#parts#Indentation(...) abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let l:compact = get(a:, 1, s:IsCompact())
    if l:compact
        return (&expandtab ? 'SPC' : 'TAB') .. ': ' .. l:shiftwidth
    else
        return (&expandtab ? 'Spaces' : 'Tab Size') .. ': ' .. l:shiftwidth
    endif
endfunction

function! lightline_settings#parts#Readonly(...) abort
    return &readonly ? g:lightline_symbols.readonly .. ' ' : ''
endfunction

function! lightline_settings#parts#Modified(...) abort
    if &modified
        return !&modifiable ? '[+-]' : '[+]'
    else
        return !&modifiable ? '[-]' : ''
    endif
endfunction

function! s:ZoomStatus(...) abort
    return get(b:, 'lightline_zoomstate', 0) ? '[Z]' : ''
endfunction

function! lightline_settings#parts#LineInfo(...) abort
    return ''
endfunction

if g:lightline_show_linenr > 1
    function! lightline_settings#parts#LineInfo(...) abort
        return call('lightline_settings#lineinfo#Full', a:000) .. ' '
    endfunction
elseif g:lightline_show_linenr > 0
    function! lightline_settings#parts#LineInfo(...) abort
        return call('lightline_settings#lineinfo#Simple', a:000) .. ' '
    endfunction
endif

function! lightline_settings#parts#FileEncodingAndFormat() abort
    " Skip encoding check if it's utf-8 and format is unix (common case)
    if &fileencoding ==# 'utf-8' && &fileformat ==# 'unix' && !&bomb && &eol
        return ''
    endif

    let l:parts = []

    let l:encoding = empty(&fileencoding) ? &encoding : &fileencoding
    if !empty(l:encoding) && l:encoding !=# 'utf-8'
        call add(l:parts, l:encoding)
    endif

    if &bomb | call add(l:parts, g:lightline_symbols.bomb) | endif
    if !&eol | call add(l:parts, g:lightline_symbols.noeol) | endif

    if !empty(&fileformat) && &fileformat !=# 'unix'
        call add(l:parts, get(g:crystalline_symbols, &fileformat, '[empty]'))
    endif

    return join(l:parts, ' ')
endfunction

function! lightline_settings#parts#FileType(...) abort
    return s:BufferType() .. lightline_settings#devicons#FileType(expand('%'))
endfunction

function! lightline_settings#parts#FileName(...) abort
    return lightline_settings#parts#Readonly() .. lightline_settings#FormatFileName(s:FileName()) .. lightline_settings#parts#Modified() .. s:ZoomStatus()
endfunction

function! lightline_settings#parts#InactiveFileName(...) abort
    return lightline_settings#parts#Readonly() .. s:FileName() .. lightline_settings#parts#Modified()
endfunction

function! lightline_settings#parts#Integration() abort
    let l:ft = s:BufferType()

    if has_key(s:lightline_filetype_integrations, l:ft)
        return function(s:lightline_filetype_integrations[l:ft])()
    endif

    let l:fname = expand('%:t')

    if has_key(s:lightline_filename_integrations, l:fname)
        return function(s:lightline_filename_integrations[l:fname])()
    elseif l:fname =~# '^NrrwRgn_\zs.*\ze_\d\+$'
        " Fallback to filename check if NrrwRgn buffer's filetype is not set
        return lightline_settings#nrrwrgn#Mode()
    endif

    if has_key(g:lightline_filetype_modes, l:ft)
        return { 'name': g:lightline_filetype_modes[l:ft] }
    endif

    if has_key(g:lightline_filename_modes, l:fname)
        return { 'name': g:lightline_filename_modes[l:fname] }
    endif

    return {}
endfunction

function! lightline_settings#parts#GitBranch(...) abort
    return ''
endfunction

if g:lightline_show_git_branch > 0
    function! lightline_settings#parts#GitBranch(...) abort
        return lightline_settings#git#Branch()
    endfunction
endif
