" lightline_settings.vim
" Maintainer: Phong Nguyen
" Version:    0.1.0

if exists('g:loaded_vim_lightline_settings') || v:version < 700
    finish
endif
let g:loaded_vim_lightline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

let g:powerline_symbols = {}

if get(g:, 'lightline_powerline', 0)
    let g:powerline_symbols.separator    = { 'left': "\ue0b0", 'right': "\ue0b2" }
    let g:powerline_symbols.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }
    let g:powerline_symbols.linenr       = "\ue0a1 "
    let g:powerline_symbols.branch       = "\ue0a0 "
    let g:powerline_symbols.readonly     = "\ue0a2"
    let g:powerline_symbols.clipboard    = " ©"
else
    let g:powerline_symbols.separator    = { 'left': '', 'right': '' }
    let g:powerline_symbols.subseparator = { 'left': '|', 'right': '|' }
    let g:powerline_symbols.linenr       = ''
    let g:powerline_symbols.branch       = ''
    let g:powerline_symbols.readonly     = 'RO'
    let g:powerline_symbols.clipboard    = ' @'
endif

if get(g:, 'lightline_set_noshowmode', 1)
    set noshowmode
endif

let g:lightline = extend(get(g:, 'lightline', {}), {
            \ 'colorscheme': 'solarized',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right': [ [ 'ctrlpdir', 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'filename' ] ],
            \   'right': [ [ 'lineinfo' ], [ 'percent' ] ],
            \ },
            \ 'component_function': {
            \   'mode':         'LightLineModeAndClipboard',
            \   'fugitive':     'LightLineFugitive',
            \   'filename':     'LightLineFilename',
            \   'lineinfo':     'LightLineLineinfo',
            \   'percent':      'LightLinePercent',
            \   'fileformat':   'LightLineFileformat',
            \   'fileencoding': 'LightLineFileencoding',
            \   'filetype':     'LightLineFiletype',
            \   'ctrlpdir':     'LightLineCtrlPDir',
            \ },
            \ 'separator': g:powerline_symbols.separator,
            \ 'subseparator': g:powerline_symbols.subseparator,
            \ }, 'keep')

let s:FilenameModeMapper = {
            \ 'ControlP':          'CtrlP',
            \ '__Tagbar__':        'Tagbar',
            \ '__Gundo__':         'Gundo',
            \ '__Gundo_Preview__': 'Gundo Preview',
            \ '[BufExplorer]':     'BufExplorer',
            \ 'NERD_tree':         'NERDTree',
            \ 'NERD_tree_1':       'NERDTree',
            \ '[Command Line]':    'CommandLine',
            \ }

let s:FiletypeModeMapper = {
            \ 'nerdtree':      'NERDTree',
            \ 'unite':         'Unite',
            \ 'vimfiler':      'VimFiler',
            \ 'vimshell':      'VimShell',
            \ 'startify':      'Startify',
            \ 'vim-plug':      'VimPlug',
            \ 'help':          'Help',
            \ 'qf':            'QuickFix',
            \ 'godoc':         'GoDoc',
            \ 'gedoc':         'GeDoc',
            \ 'gitcommit':     'Fugitive',
            \ 'fugitiveblame': 'FugitiveBlame',
            \ }

function! LightLineDisplayFilename() abort
    if winwidth(0) >= 50 && &filetype =~? 'help\|gedoc'
        return 1
    endif
    return LightLineDisplayFileinfo()
endfunction

function! LightLineDisplayFileinfo() abort
    if winwidth(0) < 50 || expand('%:t') =~? '^NrrwRgn' || has_key(s:FilenameModeMapper, expand('%:t')) || has_key(s:FiletypeModeMapper, &filetype)
        return 0
    endif
    return 1
endfunction

function! LightLineDisplayLineinfo() abort
    if winwidth(0) >= 50 && &filetype =~? 'help\|qf\|godoc\|gedoc'
        return 1
    endif
    return LightLineDisplayFileinfo()
endfunction

function! LightLineNoDisplayBranch() abort
    return !LightLineDisplayFileinfo()
endfunction

function! LightLineModified() abort
    return &filetype =~? 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly() abort
    return &filetype !~? 'help' && &readonly ? g:powerline_symbols.readonly : ''
endfunction

function! LightLineClipboard() abort
    return match(&clipboard, 'unnamed') > -1 ? g:powerline_symbols.clipboard : ''
endfunction

function! LightLineMode() abort
    let fname = expand('%:t')
    if fname =~? '^NrrwRgn'
        return printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
    else
        return get(s:FilenameModeMapper, fname, get(s:FiletypeModeMapper, &filetype, winwidth(0) >= 50 ? lightline#mode() : ''))
    endif
endfunction

function! LightLineModeAndClipboard() abort
    return LightLineMode() . LightLineClipboard()
endfunction

function! LightLineFugitive() abort
    try
        if LightLineNoDisplayBranch()
            return ''
        endif
        if winwidth(0) > 100 && exists('*fugitive#head')
            let mark = g:powerline_symbols.branch  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightLineFilename() abort
    let fname = expand('%:t')
    if fname ==# 'ControlP'
        return LightLineCtrlPMark()
    elseif fname ==# '__Tagbar__'
        return g:lightline.fname
    elseif fname =~? '^NrrwRgn'
        let bufname = (get(b:, 'orig_buf', 0) ? bufname(b:orig_buf) : substitute(bufname('%'), '^Nrrwrgn_\zs.*\ze_\d\+$', submatch(0), ''))
        return bufname
    elseif &filetype ==# 'unite'
        return unite#get_status_string()
    elseif &filetype ==# 'vimfiler'
        return vimfiler#get_status_string()
    elseif &filetype ==# 'vimshell'
        return vimshell#get_status_string()
    elseif LightLineDisplayFilename()
        return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                    \ ('' != fname ? expand('%') : '[No Name]') .
                    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    else
        return ''
    endif
endfunction

function! LightLineLineinfo() abort
    if LightLineDisplayLineinfo()
        return printf('%s%4d:%3d', g:powerline_symbols.linenr, line('.'), col('.'))
    endif
    return ''
endfunction

function! LightLinePercent() abort
    if LightLineDisplayLineinfo()
        return printf('%3d%%', line('.') * 100 / line('$'))
    endif
    return ''
endfunction

function! LightLineFileformat() abort
    return LightLineDisplayFileinfo() && &fileformat !=? 'unix' ? &fileformat : ''
endfunction

function! LightLineFileencoding() abort
    if LightLineDisplayFileinfo()
        let encoding = strlen(&fenc) ? &fenc : &enc
        if encoding !=? 'utf-8'
            return encoding
        endif
    endif
    return ''
endfunction

function! LightLineFiletype() abort
    return LightLineDisplayFileinfo() ? strlen(&filetype) ? &filetype : 'unknown' : ''
endfunction

function! LightLineCtrlPMark() abort
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])

        return lightline#concatenate([
                    \ g:lightline.ctrlp_prev,
                    \ '<' . g:lightline.ctrlp_item . '>',
                    \ g:lightline.ctrlp_next,
                    \ ], 0)
    else
        return ''
    endif
endfunction

function! LightLineCtrlPDir() abort
    if expand('%:t') =~ 'ControlP'
        return lightline#concatenate([
                    \ g:lightline.ctrlp_focus,
                    \ g:lightline.ctrlp_byfname . ' ' . g:lightline.ctrlp_dir,
                    \ ], 1)
    else
        return ''
    endif
endfunction

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) abort
    let g:lightline.ctrlp_focus   = a:focus
    let g:lightline.ctrlp_byfname = a:byfname
    let g:lightline.ctrlp_regex   = a:regex
    let g:lightline.ctrlp_prev    = a:prev
    let g:lightline.ctrlp_item    = a:item
    let g:lightline.ctrlp_next    = a:next
    let g:lightline.ctrlp_marked  = a:marked
    let g:lightline.ctrlp_dir     = getcwd()
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str) abort
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'LightLineTagbar'

function! LightLineTagbar(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline    = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let &cpo = s:save_cpo
unlet s:save_cpo
