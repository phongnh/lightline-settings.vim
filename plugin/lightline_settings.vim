" lightline_settings.vim
" Maintainer: Phong Nguyen
" Version:    0.1.0

if exists('g:loaded_vim_lightline_settings') || v:version < 700
    finish
endif

let g:loaded_vim_lightline_settings = 1

let s:save_cpo = &cpo
set cpo&vim


" Window width
let s:xsmall_window_width = 60
let s:small_window_width  = 80
let s:normal_window_width = 100

" Symbols
if get(g:, 'lightline_powerline', 0)
    let s:symbols = {
                \ 'separator':    { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ 'linenr':       "\ue0a1",
                \ 'branch':       "\ue0a0",
                \ 'readonly':     "\ue0a2",
                \ 'clipboard':    'ⓒ ',
                \ 'paste':        'Ⓟ ',
                \ 'ellipsis':     '…',
                \ }
else
    let s:symbols = {
                \ 'separator':    { 'left': '',  'right': ''  },
                \ 'subseparator': { 'left': '|', 'right': '|' },
                \ 'linenr':       '☰',
                \ 'branch':       '⎇',
                \ 'readonly':     '',
                \ 'clipboard':    'ⓒ  ',
                \ 'paste':        'Ⓟ  ',
                \ 'ellipsis':     '…',
                \ }
endif

if get(g:, 'lightline_set_noshowmode', 1)
    set noshowmode
endif

let g:lightline_theme = get(g:, 'lightline_theme', 'powerline')

let g:lightline = {
            \ 'colorscheme': g:lightline_theme,
            \ 'enable': {
            \   'statusline': 1,
            \   'tabline':    1,
            \ },
            \ 'tabline': {
            \   'left':  [['tablabel'], ['tabs']],
            \   'right': []
            \ },
            \ 'tab': {
            \   'active':   ['tabnum', 'readonly', 'filename', 'modified'],
            \   'inactive': ['tabnum', 'readonly', 'filename', 'modified']
            \ },
            \ 'active': {
            \   'left':  [['mode'], ['plugin_mode', 'branch', 'filename']],
            \   'right': [['spaces', 'fileinfo', 'plugin'], ['extra']]
            \ },
            \ 'inactive': {
            \   'left':  [['inactive']],
            \   'right': []
            \ },
            \ 'component_function': {
            \   'mode':             'LightlineModeStatus',
            \   'plugin_mode':      'LightlinePluginModeStatus',
            \   'branch':           'LightlineGitBranchStatus',
            \   'filename':         'LightlineFileNameStatus',
            \   'spaces':           'LightlineIndentationStatus',
            \   'fileinfo':         'LightlineFileInfoStatus',
            \   'plugin':           'LightlinePluginStatus',
            \   'extra':            'LightlineExtraStatus',
            \   'inactive':         'LightlineInactiveStatus',
            \   'tablabel':         'LightlineTabLabel',
            \ },
            \ 'tab_component_function': {
            \   'tabnum':   'LightlineTabNum',
            \   'filename': 'LightlineTabFileType',
            \   'readonly': 'LightlineTabReadonly',
            \ },
            \ 'separator':    s:symbols.separator,
            \ 'subseparator': s:symbols.subseparator,
            \ }

if findfile('plugin/bufferline.vim', &rtp) != '' && get(g:, 'lightline_bufferline', 0)
    " https://github.com/mengelbrecht/lightline-bufferline
    let g:lightline.tabline          = { 'left': [['buffers']], 'right': [['close']] }
    let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
    let g:lightline.component_type   = { 'buffers': 'tabsel' }

    let g:lightline#bufferline#unicode_symbols   = get(g:, 'lightline_powerline', 0)
    let g:lightline#bufferline#filename_modifier = ':t'
    let g:lightline#bufferline#show_number       = 1
    let g:lightline#bufferline#shorten_path      = 1
    let g:lightline#bufferline#unnamed           = '[No Name]'

    " let g:lightline#bufferline#number_map = {
    "             \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
    "             \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
    "             \ }

    " let g:lightline#bufferline#number_map = {
    "             \ 0: '₀', 1: '₁', 2: '₂', 3: '₃', 4: '₄',
    "             \ 5: '₅', 6: '₆', 7: '₇', 8: '₈', 9: '₉'
    "             \ }
endif

" Detect DevIcons
let s:has_devicons = (findfile('plugin/webdevicons.vim', &rtp) != '')

let s:filename_modes = {
            \ '__CtrlSF__':           'CtrlSF',
            \ '__CtrlSFPreview__':    'Preview',
            \ '__Tagbar__':           'Tagbar',
            \ '__Gundo__':            'Gundo',
            \ '__Gundo_Preview__':    'Gundo Preview',
            \ '[BufExplorer]':        'BufExplorer',
            \ '[Command Line]':       'Command Line',
            \ '[Plugins]':            'Plugins',
            \ '__committia_status__': 'Committia Status',
            \ '__committia_diff__':   'Committia Diff',
            \ }

let s:filetype_modes = {
            \ 'ctrlp':             'CtrlP',
            \ 'ctrlsf':            'CtrlSF',
            \ 'leaderf':           'LeaderF',
            \ 'netrw':             'NetrwTree',
            \ 'nerdtree':          'NERDTree',
            \ 'startify':          'Startify',
            \ 'tagbar':            'TagBar',
            \ 'vim-plug':          'Plugins',
            \ 'help':              'HELP',
            \ 'qf':                'QuickFix',
            \ 'godoc':             'GoDoc',
            \ 'gedoc':             'GeDoc',
            \ 'gitcommit':         'Commit Message',
            \ 'fugitiveblame':     'FugitiveBlame',
            \ 'gitmessengerpopup': 'Git Messenger',
            \ 'agit':              'Agit',
            \ 'agit_diff':         'Agit Diff',
            \ 'agit_stat':         'Agit Stat',
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

function! s:Strip(str) abort
    if exists('*trim')
        return trim(a:str)
    else
        return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
    endif
endfunction

function! s:CurrentWinWidth() abort
    return winwidth(0)
endfunction

function! s:ShortenFileName(filename) abort
    if exists('*pathshorten')
        return pathshorten(a:filename)
    else
        return substitute(a:filename, '\v\w\zs.{-}\ze(\\|/)', '', 'g')
    endif
endfunction

function! s:RemoveEmptyElement(list) abort
    return filter(copy(a:list), '!empty(v:val)')
endfunction

function! s:GetCurrentDir() abort
    let dir = fnamemodify(getcwd(), ':~:.')
    if empty(dir)
        let dir = getcwd()
    endif
    return dir
endfunction

function! s:GetBufferType(bufnum) abort
    let ft = getbufvar(a:bufnum, '&filetype')

    if empty(ft)
        let ft = getbufvar(a:bufnum, '&buftype')
    endif

    return ft
endfunction

function! s:GetFileName(fname) abort
    if strlen(a:fname)
        if s:CurrentWinWidth() < s:xsmall_window_width
            return a:fname
        endif

        let l:path = expand('%:~:.')

        if strlen(l:path) > 50
            let l:path = s:ShortenFileName(l:path)
        endif

        if strlen(l:path) > 50
            let l:path = a:fname
        endif

        return l:path
    endif

    return '[No Name]'
endfunction

function! s:ModifiedStatus() abort
    if &filetype !=? 'help' && &modified
        if &modifiable
            return ' +'
        else
            return '[-] +'
        endif
    endif
    return ''
endfunction

function! s:ReadonlyStatus() abort
    return &readonly ? s:symbols.readonly . ' ' : ''
endfunction

function! s:GetFileNameWithFlags() abort
    return s:ReadonlyStatus() . s:GetFileName(expand('%t')) . s:ModifiedStatus()
endfunction

" Copied from https://github.com/ahmedelgabri/dotfiles/blob/master/files/vim/.vim/autoload/statusline.vim
function! s:FileSize() abort
    let l:size = getfsize(expand('%'))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size . ' bytes'
    elseif l:size < 1024 * 1024
        return printf('%.1f', l:size / 1024.0) . 'k'
    elseif l:size < 1024 * 1024 * 1024
        return printf('%.1f', l:size / 1024.0 / 1024.0) . 'm'
    else
        return printf('%.1f', l:size / 1024.0 / 1024.0 / 1024.0) . 'g'
    endif
endfunction

function! s:GetGitBranch() abort
    if exists('*FugitiveHead')
        return FugitiveHead()
    elseif exists('*fugitive#head')
        return fugitive#head()
    elseif exists(':Gina') == 2
        return gina#component#repo#branch()
    endif
    return ''
endfunction

function! s:ShortenBranch(branch, length)
    let branch = a:branch

    if strlen(branch) > a:length
        let branch = s:ShortenFileName(branch)
    endif

    if strlen(branch) > a:length
        let branch = fnamemodify(branch, ':t')
    endif

    if strlen(branch) > a:length
        let branch = strcharpart(branch, 0, 29) . s:powerline_symbols.ellipsis
    endif

    return branch
endfunction

function! s:FormatBranch(branch) abort
    if s:CurrentWinWidth() >= s:normal_window_width
        return s:ShortenBranch(a:branch, 50)
    endif

    return s:ShortenBranch(a:branch, 30)
endfunction

function! s:ClipboardStatus() abort
    return match(&clipboard, 'unnamed') > -1 ? s:symbols.clipboard : ''
endfunction

function! s:PasteStatus() abort
    return &paste ? s:symbols.paste : ''
endfunction

function! s:SpellStatus() abort
    return &spell ? toupper(substitute(&spelllang, ',', '/', 'g')) : ''
endfunction

function! s:IndentationStatus(...) abort
    let shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    return printf('%s: %d', (&expandtab ? 'Spaces' : 'Tab Size'), shiftwidth)
endfunction

function! s:FileEncodingStatus(...) abort
    let encoding = strlen(&fenc) ? &fenc : &enc
    " Show encoding only if it is not utf-8
    if empty(encoding) || encoding ==# 'utf-8'
        return ''
    endif
    return printf('[%s]', encoding)
endfunction

function! s:FileEncodingAndFormatStatus(...) abort
    let encoding = strlen(&fenc) ? &fenc : &enc
    let format = &fileformat

    if strlen(encoding) && strlen(format)
        let stl = printf('%s[%s]', encoding, format)
    elseif strlen(encoding)
        let stl = encoding
    else
        let stl = printf('[%s]', format)
    endif

    " Show format only if it is not utf-8[unix]
    if stl ==# 'utf-8[unix]'
        return ''
    endif

    return stl
endfunction
function! s:IsCustomMode(...) abort
    return has_key(s:filetype_modes, &filetype) ||
                \ has_key(s:filename_modes, expand('%:t')) ||
                \ (expand('%:t') =~? '^NrrwRgn' && exists('b:nrrw_instn'))
endfunction

function! s:CustomMode() abort
    if has_key(s:filetype_modes, &filetype)
        if &filetype ==# 'qf' && getwininfo(win_getid())[0]['loclist']
            return 'LocationList'
        endif

        return s:filetype_modes[&filetype]
    endif

    let fname = expand('%:t')
    if has_key(s:filename_modes, fname)
        return s:filename_modes[fname]
    endif

    if fname =~? '^NrrwRgn' && exists('b:nrrw_instn')
        return printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
    endif

    return ''
endfunction

function! s:ShortMode(mode) abort
    if s:CurrentWinWidth() < s:xsmall_window_width
        return get(s:short_modes, a:mode, a:mode)
    endif
    return a:mode
endfunction

function! LightlineModeStatus() abort
    let l:mode = s:CustomMode()
    if strlen(l:mode)
        return l:mode
    endif
    return s:ShortMode(lightline#mode())
endfunction

function! LightlineGitBranchStatus() abort
    if s:CurrentWinWidth() < s:small_window_width || s:IsCustomMode()
        return
    endif

    let branch = s:GetGitBranch()

    if empty(branch)
        return ''
    endif

    return s:symbols.branch . ' ' . s:FormatBranch(branch)
endfunction

function! LightlineFileNameStatus() abort
    if s:IsCustomMode()
        return ''
    endif
    return s:GetFileNameWithFlags()
endfunction

function! LightlineFileInfoStatus() abort
    if s:IsCustomMode()
        return ''
    endif

    let ft = s:GetBufferType('%')

    if s:CurrentWinWidth() < s:xsmall_window_width
        return ft
    endif

    if s:has_devicons
        let parts = s:RemoveEmptyElement([
                    \ s:FileEncodingStatus(),
                    \ WebDevIconsGetFileFormatSymbol() . ' ',
                    \ ft,
                    \ WebDevIconsGetFileTypeSymbol(bufname('%')) . ' ',
                    \ ])
    else
        let parts = s:RemoveEmptyElement([
                    \ s:FileEncodingAndFormatStatus(),
                    \ ft,
                    \ ])
    endif

    let stl = join(parts, ' ')

    if s:CurrentWinWidth() < s:small_window_width
        return stl
    endif

    return lightline#concatenate([
                \ s:FileSize(),
                \ stl,
                \ ], 1)
endfunction

function! LightlineIndentationStatus() abort
    if s:CurrentWinWidth() < s:xsmall_window_width || s:IsCustomMode()
        return ''
    endif
    return s:IndentationStatus()
endfunction

function! LightlineExtraStatus() abort
    if s:CurrentWinWidth() < s:small_window_width || s:IsCustomMode()
        return ''
    endif

    return lightline#concatenate(
                \ s:RemoveEmptyElement([
                \   s:ClipboardStatus(),
                \   s:PasteStatus(),
                \   s:SpellStatus(),
                \ ]),
                \ 1)
endfunction

function! s:CtrlPMark() abort
    call lightline#link('iR'[g:lightline.ctrlp_regex])

    return lightline#concatenate([
                \ g:lightline.ctrlp_prev,
                \ '« ' . g:lightline.ctrlp_item . ' »',
                \ g:lightline.ctrlp_next,
                \ ], 0)
endfunction

function! s:CtrlSFMark(fname) abort
    call lightline#link()

    if a:fname == '__CtrlSF__'
        return lightline#concatenate([
                    \ substitute(ctrlsf#utils#SectionB(), 'Pattern: ', '', ''),
                    \ ctrlsf#utils#SectionC(),
                    \ ctrlsf#utils#SectionX(),
                    \ ], 0)
    endif

    if a:fname == '__CtrlSFPreview__'
        return lightline#concatenate([
                    \ ctrlsf#utils#PreviewSectionC(),
                    \ ], 0)
    endif

    return ''
endfunction

function! s:TagbarMark() abort
    call lightline#link()

    if empty(g:lightline.tagbar_flags)
        return lightline#concatenate([
                    \ g:lightline.tagbar_sort,
                    \ g:lightline.tagbar_fname,
                    \ ], 0)
    else
        return lightline#concatenate([
                    \ g:lightline.tagbar_sort,
                    \ g:lightline.tagbar_fname,
                    \ join(g:lightline.tagbar_flags, ''),
                    \ ], 0)
    endif
endfunction

function! s:NrrwRgnMark() abort
    let dict = exists('*nrrwrgn#NrrwRgnStatus()') ?  nrrwrgn#NrrwRgnStatus() : {}

    if !empty(dict)
        return fnamemodify(dict.fullname, ':~:.')
    elseif get(b:, 'orig_buf', 0)
        return bufname(b:orig_buf)
    endif

    return ''
endfunction

function! LightlinePluginModeStatus() abort
    let fname = expand('%:t')

    if &filetype ==# 'ctrlp'
        return s:CtrlPMark()
    elseif &filetype ==# 'ctrlsf' || fname ==# '__CtrlSFPreview__' || fname ==# '__CtrlSF__'
        return s:CtrlSFMark(fname)
    elseif &filetype ==# 'tagbar' || fname =~? '^__Tagbar__'
        return s:TagbarMark()
    elseif &filetype ==# 'qf'
        return s:Strip(get(w:, 'quickfix_title', ''))
    elseif &filetype ==# 'help'
        return expand('%:~:.')
    elseif fname =~? '^NrrwRgn'
        return s:NrrwRgnMark()
    endif

    return ''
endfunction

function! LightlinePluginStatus() abort
    if &filetype ==# 'ctrlp'
        return lightline#concatenate([
                    \ g:lightline.ctrlp_focus,
                    \ g:lightline.ctrlp_byfname,
                    \ g:lightline.ctrlp_dir,
                    \ ], 1)
    endif
    return ''
endfunction

function! LightlineInactiveStatus() abort
    let l:mode = s:Strip(s:CustomMode())

    if strlen(l:mode)
        return l:mode
    endif

    return s:GetFileNameWithFlags()
endfunction

function! LightlineTabLabel() abort
    return 'Tabs'
endfunction

function! LightlineTabNum(n) abort
    return printf('%d:', a:n)
endfunction

" Copied from https://github.com/itchyny/lightline-powerful
let s:buffer_count_by_basename = {}
augroup lightline_settings
    autocmd!
    autocmd BufEnter,WinEnter,WinLeave * call s:update_bufnrs()
augroup END

function! s:update_bufnrs() abort
    let s:buffer_count_by_basename = {}
    let bufnrs = filter(range(1, bufnr('$')), 'len(bufname(v:val)) && bufexists(v:val) && buflisted(v:val)')
    for name in map(bufnrs, 'expand("#" . v:val . ":t")')
        if name !=# ''
            let s:buffer_count_by_basename[name] = get(s:buffer_count_by_basename, name) + 1
        endif
    endfor
endfunction

function! LightlineTabFileType(n) abort
    let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
    let bufname = expand('#' . bufnr . ':t')
    let ft = gettabwinvar(a:n, tabpagewinnr(a:n), '&ft')
    if get(s:buffer_count_by_basename, bufname) > 1
        let fname = substitute(expand('#' . bufnr . ':p'), '.*/\([^/]\+/\)', '\1', '')
    else
        let fname = bufname
    endif
    return fname =~# '^\[preview' ? 'Preview' : get(s:filetype_modes, ft, get(s:filename_modes, fname, fname))
endfunction

" Copied from https://github.com/itchyny/lightline-powerful
function! LightlineTabReadonly(n) abort
    let winnr = tabpagewinnr(a:n)
    return gettabwinvar(a:n, winnr, '&readonly') ? s:symbols.readonly : ''
endfunction

" CtrlP Integration
let g:ctrlp_status_func = {
            \ 'main': 'CtrlPMainStatusLine',
            \ 'prog': 'CtrlPProgressStatusLine',
            \ }

function! CtrlPMainStatusLine(focus, byfname, regex, prev, item, next, marked) abort
    let g:lightline.ctrlp_focus   = a:focus
    let g:lightline.ctrlp_byfname = a:byfname
    let g:lightline.ctrlp_regex   = a:regex
    let g:lightline.ctrlp_prev    = a:prev
    let g:lightline.ctrlp_item    = a:item
    let g:lightline.ctrlp_next    = a:next
    let g:lightline.ctrlp_marked  = a:marked
    let g:lightline.ctrlp_dir     = s:GetCurrentDir()
    return lightline#statusline(0)
endfunction

function! CtrlPProgressStatusLine(len) abort
    return lightline#statusline(0)
endfunction

" Tagbar Integration
let g:tagbar_status_func = 'LightlineTagbar'

function! LightlineTagbar(current, sort, fname, flags, ...) abort
    let g:lightline.tagbar_sort  = a:sort
    let g:lightline.tagbar_fname = a:fname
    let g:lightline.tagbar_flags = a:flags
    return lightline#statusline(0)
endfunction

" ZoomWin Integration
let s:ZoomWin_funcref = []

if exists('g:ZoomWin_funcref')
    if type(g:ZoomWin_funcref) == 2
        let s:ZoomWin_funcref = [g:ZoomWin_funcref]
    elseif type(g:ZoomWin_funcref) == 3
        let s:ZoomWin_funcref = g:ZoomWin_funcref
    endif
endif
let s:ZoomWin_funcref = uniq(copy(s:ZoomWin_funcref))

function! ZoomWinStatusLine(zoomstate) abort
    for F in s:ZoomWin_funcref
        if type(F) == 2 && F != function('ZoomWinStatusLine')
            call F(a:zoomstate)
        endif
    endfor
endfunction

let g:ZoomWin_funcref= function('ZoomWinStatusLine')

let &cpo = s:save_cpo
unlet s:save_cpo
