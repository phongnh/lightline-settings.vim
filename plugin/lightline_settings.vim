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

let g:lightline_theme = get(g:, 'lightline_theme', 'powerline')

let g:lightline#bufferline#unicode_symbols   = get(g:, 'lightline_powerline', 0)
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number       = 1
let g:lightline#bufferline#shorten_path      = 1
let g:lightline#bufferline#unnamed           = '[No Name]'

let g:lightline = {
            \ 'colorscheme': g:lightline_theme,
            \ 'enable': {
            \   'statusline': 1,
            \   'tabline': 1,
            \ },
            \ 'tabline': {
            \   'left': [ ['tablabel'], ['tabs'] ],
            \   'right': [ ['bufferslabel'], ['buffers'] ]
            \ },
            \ 'tab': {
            \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
            \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
            \ },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right': [ [ 'ctrlpdir' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ [ 'relativepath' ] ],
            \   'right': [ [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'tablabel':     'LightlineTabLabel',
            \   'bufferslabel': 'LightlineBuffersLabel',
            \   'mode':         'LightlineModeAndClipboard',
            \   'fugitive':     'LightlineFugitive',
            \   'filename':     'LightlineFilename',
            \   'lineinfo':     'LightlineLineinfo',
            \   'percent':      'LightlinePercent',
            \   'fileformat':   'LightlineFileformat',
            \   'fileencoding': 'LightlineFileencoding',
            \   'filetype':     'LightlineFiletype',
            \   'ctrlpdir':     'LightlineCtrlPDir',
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers',
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel',
            \ },
            \ 'tab_component_function': {
            \   'tabnum': 'LightlineTabnum',
            \   'filename': 'LightlineTabFilename',
            \   'readonly': 'LightlineTabReadonly',
            \ },
            \ 'separator': g:powerline_symbols.separator,
            \ 'subseparator': g:powerline_symbols.subseparator,
            \ }

let s:filename_modes = {
            \ 'ControlP':             'CtrlP',
            \ '__Tagbar__':           'Tagbar',
            \ '__Gundo__':            'Gundo',
            \ '__Gundo_Preview__':    'Gundo Preview',
            \ '[BufExplorer]':        'BufExplorer',
            \ 'NERD_tree':            'NERDTree',
            \ 'NERD_tree_1':          'NERDTree',
            \ '[Command Line]':       'Command Line',
            \ '[Plugins]':            'Plugins',
            \ '__committia_status__': 'Committia Status',
            \ '__committia_diff__':   'Committia Diff',
            \ }

let s:filetype_modes = {
            \ 'netrw':         'NetrwTree',
            \ 'nerdtree':      'NERDTree',
            \ 'startify':      'Startify',
            \ 'vim-plug':      'Plug',
            \ 'unite':         'Unite',
            \ 'vimfiler':      'VimFiler',
            \ 'vimshell':      'VimShell',
            \ 'help':          'Help',
            \ 'qf':            'Quickfix',
            \ 'godoc':         'GoDoc',
            \ 'gedoc':         'GeDoc',
            \ 'gitcommit':     'Commit Message',
            \ 'fugitiveblame': 'FugitiveBlame',
            \ 'agit':          'Agit',
            \ 'agit_diff':     'Agit',
            \ 'agit_stat':     'Agit',
            \ }

let s:short_modes = {
            \ 'NORMAL':   'N',
            \ 'INSERT':   'I',
            \ 'VISUAL':   'V',
            \ 'V-LINE':   'L',
            \ 'V-BLOCK':  'B',
            \ 'COMMAND':  'C',
            \ 'SELECT':   'S',
            \ 'S-LINE':   'S-L',
            \ 'S-BLOCK':  'S-B',
            \ 'TERMINAL': 'T',
            \ }

function! LightlineDisplayFilename() abort
    if winwidth(0) >= 50 && &filetype =~? 'help\|gedoc'
        return 1
    endif
    return LightlineDisplayFileinfo()
endfunction

function! LightlineDisplayFileinfo() abort
    if winwidth(0) < 50 || expand('%:t') =~? '^NrrwRgn' || has_key(s:filename_modes, expand('%:t')) || has_key(s:filetype_modes, &filetype)
        return 0
    endif
    return 1
endfunction

function! LightlineDisplayLineinfo() abort
    if winwidth(0) >= 50 && &filetype =~? 'help\|qf\|godoc\|gedoc'
        return 1
    endif
    return LightlineDisplayFileinfo()
endfunction

function! LightlineNoDisplayBranch() abort
    return !LightlineDisplayFileinfo()
endfunction

function! LightlineModified() abort
    return &filetype =~? 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly() abort
    return &filetype !~? 'help' && &readonly ? g:powerline_symbols.readonly : ''
endfunction

function! LightlineClipboard() abort
    return match(&clipboard, 'unnamed') > -1 ? g:powerline_symbols.clipboard : ''
endfunction

function! LightlineShortMode(mode) abort
    if winwidth(0) > 75
        return a:mode
    else
        return get(s:short_modes, a:mode, a:mode)
    endif
endfunction

function! LightlineMode() abort
    let fname = expand('%:t')
    if fname =~? '^NrrwRgn'
        return printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
    else
        return get(s:filename_modes, fname, get(s:filetype_modes, &filetype, LightlineShortMode(lightline#mode())))
    endif
endfunction

function! LightlineModeAndClipboard() abort
    return LightlineMode() . LightlineClipboard()
endfunction

function! LightlineTabnum(n) abort
    return printf('[%d]', a:n)
endfunction

function! LightlineBuffersLabel() abort
    return 'Buffers'
endfunction

function! LightlineTabLabel() abort
    return 'Tabs'
endfunction

" Copied from https://github.com/itchyny/lightline-powerful
function! LightlineTabReadonly(n) abort
  let winnr = tabpagewinnr(a:n)
  return gettabwinvar(a:n, winnr, '&readonly') ? g:powerline_symbols.readonly : ''
endfunction

" Copied from https://github.com/itchyny/lightline-powerful
function! LightlineTabFilename(n) abort
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let bufname = expand('#' . bufnr . ':t')
  let buffullname = expand('#' . bufnr . ':p')
  let bufnrs = filter(range(1, bufnr('$')), 'v:val != bufnr && len(bufname(v:val)) && bufexists(v:val) && buflisted(v:val)')
  let i = index(map(copy(bufnrs), 'expand("#" . v:val . ":t")'), bufname)
  let ft = gettabwinvar(a:n, tabpagewinnr(a:n), '&ft')
  if strlen(bufname) && i >= 0 && map(bufnrs, 'expand("#" . v:val . ":p")')[i] != buffullname
    let fname = substitute(buffullname, '.*/\([^/]\+/\)', '\1', '')
  else
    let fname = bufname
  endif
  return fname =~# '^\[preview' ? 'Preview' : get(s:filename_modes, fname, get(s:filetype_modes, ft, fname))
endfunction

function! LightlineFugitive() abort
    if LightlineNoDisplayBranch()
        return ''
    endif
    if winwidth(0) > 100 && exists('*fugitive#head')
        let mark = g:powerline_symbols.branch  " edit here for cool mark
        try
            let branch = fugitive#head()
            let len = strlen(branch)
            if len > 0 && len < 31
                return mark . branch
            endif
        catch
        endtry
    endif
    return ''
endfunction

function! LightlineFilename() abort
    let fname = expand('%:t')
    if fname ==# 'ControlP'
        return LightlineCtrlPMark()
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
    elseif LightlineDisplayFilename()
        let str = (LightlineReadonly() != '' ? LightlineReadonly() . ' ' : '')
        if fname != ''
            let path = expand('%:~:.')
            if strlen(path) > 50
                let path = fname
            endif
            let str .= path
        else
            let str .= '[No Name]'
        endif
        let str .= (LightlineModified() != '' ? ' ' . LightlineModified() : '')
        return str
    endif
    return ''
endfunction

function! LightlineLineinfo() abort
    if LightlineDisplayLineinfo()
        return printf('%s%4d:%3d', g:powerline_symbols.linenr, line('.'), col('.'))
    endif
    return ''
endfunction

function! LightlinePercent() abort
    if LightlineDisplayLineinfo()
        return printf('%3d%%', line('.') * 100 / line('$'))
    endif
    return ''
endfunction

function! LightlineFileformat() abort
    return LightlineDisplayFileinfo() && &fileformat !=? 'unix' ? &fileformat : ''
endfunction

function! LightlineFileencoding() abort
    if LightlineDisplayFileinfo()
        let encoding = strlen(&fenc) ? &fenc : &enc
        if encoding !=? 'utf-8'
            return encoding
        endif
    endif
    return ''
endfunction

function! LightlineFiletype() abort
    return LightlineDisplayFileinfo() ? &filetype : ''
endfunction

function! LightlineCtrlPMark() abort
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

function! LightlineCtrlPDir() abort
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

let g:tagbar_status_func = 'LightlineTagbar'

function! LightlineTagbar(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline    = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let &cpo = s:save_cpo
unlet s:save_cpo
