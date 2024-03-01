function! lightline_settings#parts#Mode() abort
    if lightline_settings#IsCompact()
        return get(g:lightline_short_mode_map, mode(), '')
    else
        return lightline#mode()
    endif
endfunction

function! lightline_settings#parts#Clipboard() abort
    return lightline_settings#IsClipboardEnabled() ? g:lightline_symbols.clipboard : ''
endfunction

function! lightline_settings#parts#Paste() abort
    return &paste ? g:lightline_symbols.paste : ''
endfunction

function! lightline_settings#parts#Spell() abort
    return &spell ? toupper(substitute(&spelllang, ',', '/', 'g')) : ''
endfunction

function! lightline_settings#parts#Indentation(...) abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = get(a:, 1, 0)
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! lightline_settings#parts#Readonly(...) abort
    return &readonly ? g:lightline_symbols.readonly . ' ' : ''
endfunction

function! lightline_settings#parts#Modified(...) abort
    if &modified
        return !&modifiable ? '[+-]' : '[+]'
    else
        return !&modifiable ? '[-]' : ''
    endif
endfunction

function! lightline_settings#parts#SimpleLineInfo(...) abort
    return printf('%3d:%-3d', line('.'), col('.'))
endfunction

function! lightline_settings#parts#LineInfo(...) abort
    if line('w0') == 1 && line('w$') == line('$')
        let l:percent = 'All'
    elseif line('w0') == 1
        let l:percent = 'Top'
    elseif line('w$') == line('$')
        let l:percent = 'Bot'
    else
        let l:percent = printf('%d%%', line('.') * 100 / line('$'))
    endif

    return printf('%4d:%-3d %3s', line('.'), col('.'), l:percent)
endfunction

function! lightline_settings#parts#FileEncodingAndFormat() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:encoding = (l:encoding ==# 'utf-8') ? '' : l:encoding . ' '
    let l:bomb     = &bomb ? g:lightline_symbols.bomb . ' ' : ''
    let l:noeol    = &eol ? '' : g:lightline_symbols.noeol . ' '
    let l:format   = get(g:lightline_symbols, &fileformat, '[empty]')
    let l:format   = (l:format ==# '[unix]') ? '' : l:format . ' '
    return l:encoding . l:bomb . l:noeol . l:format
endfunction

function! lightline_settings#parts#FileType(...) abort
    return lightline_settings#BufferType() . lightline_settings#devicons#FileType(expand('%'))
endfunction

function! lightline_settings#parts#FileInfo(...) abort
    return lightline_settings#parts#FileType()
endfunction

" Alternate status dictionaries
let g:lightline_filename_modes = {
            \ 'ControlP':             'CtrlP',
            \ '__CtrlSF__':           'CtrlSF',
            \ '__CtrlSFPreview__':    'Preview',
            \ '__Tagbar__':           'Tagbar',
            \ '__Gundo__':            'Gundo',
            \ '__Gundo_Preview__':    'Gundo Preview',
            \ '__Mundo__':            'Mundo',
            \ '__Mundo_Preview__':    'Mundo Preview',
            \ '[BufExplorer]':        'BufExplorer',
            \ '[Command Line]':       'Command Line',
            \ '[Plugins]':            'Plugins',
            \ '__committia_status__': 'Committia Status',
            \ '__committia_diff__':   'Committia Diff',
            \ '__doc__':              'Document',
            \ '__LSP_SETTINGS__':     'LSP Settings',
            \ }

let g:lightline_filetype_modes = {
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
            \ 'startify':          'Startify',
            \ 'alpha':             'Alpha',
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
            \ 'fugitiveblame':     'FugitiveBlame',
            \ 'gitmessengerpopup': 'Git Messenger',
            \ 'GV':                'GV',
            \ 'agit':              'Agit',
            \ 'agit_diff':         'Agit Diff',
            \ 'agit_stat':         'Agit Stat',
            \ }

let g:lightline_plugin_modes = {
            \ 'ctrlp':           'lightline_settings#ctrlp#Mode',
            \ 'netrw':           'lightline_settings#netrw#Mode',
            \ 'dirvish':         'lightline_settings#dirvish#Mode',
            \ 'molder':          'lightline_settings#molder#Mode',
            \ 'vaffle':          'lightline_settings#vaffle#Mode',
            \ 'fern':            'lightline_settings#fern#Mode',
            \ 'carbon.explorer': 'lightline_settings#carbon#Mode',
            \ 'neo-tree':        'lightline_settings#neotree#Mode',
            \ 'oil':             'lightline_settings#oil#Mode',
            \ 'tagbar':          'lightline_settings#tagbar#Mode',
            \ 'vista_kind':      'lightline_settings#vista#Mode',
            \ 'vista':           'lightline_settings#vista#Mode',
            \ 'gitcommit':       'lightline_settings#gitcommit#Mode',
            \ 'terminal':        'lightline_settings#terminal#Mode',
            \ 'help':            'lightline_settings#help#Mode',
            \ 'qf':              'lightline_settings#quickfix#Mode',
            \ }

function! lightline_settings#parts#Integration() abort
    let fname = expand('%:t')

    if has_key(g:lightline_filename_modes, fname)
        let result = { 'name': g:lightline_filename_modes[fname] }

        let l:plugin_modes = {
                    \ 'ControlP':          'lightline_settings#ctrlp#Mode',
                    \ '__Tagbar__':        'lightline_settings#tagbar#Mode',
                    \ '__CtrlSF__':        'lightline_settings#ctrlsf#Mode',
                    \ '__CtrlSFPreview__': 'lightline_settings#ctrlsf#PreviewMode',
                    \ }

        if has_key(l:plugin_modes, fname)
            return extend(result, function(l:plugin_modes[fname])())
        endif
    endif

    if fname =~# '^NrrwRgn_\zs.*\ze_\d\+$'
        return lightline_settings#nrrwrgn#Mode()
    endif

    let ft = lightline_settings#BufferType()
    if has_key(g:lightline_filetype_modes, ft)
        let result = { 'name': g:lightline_filetype_modes[ft] }

        if has_key(g:lightline_plugin_modes, ft)
            return extend(result, function(g:lightline_plugin_modes[ft])())
        endif

        return result
    endif

    return {}
endfunction
