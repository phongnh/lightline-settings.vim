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
    let g:powerline_symbols.linenr       = "\ue0a1"
    let g:powerline_symbols.branch       = "\ue0a0"
    let g:powerline_symbols.readonly     = "\ue0a2"
    let g:powerline_symbols.clipboard    = "©"
    let g:powerline_symbols.ellipsis     = '…'
else
    let g:powerline_symbols.separator    = { 'left': '', 'right': '' }
    let g:powerline_symbols.subseparator = { 'left': '|', 'right': '|' }
    let g:powerline_symbols.linenr       = '☰'
    let g:powerline_symbols.branch       = '⎇'
    let g:powerline_symbols.readonly     = ''
    let g:powerline_symbols.clipboard    = '@'
    let g:powerline_symbols.ellipsis     = '…'
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
            \   'left':  [['mode', 'paste', 'spell'], ['branch', 'filename']],
            \   'right': [['filesize', 'spaces', 'filetype', 'fileencoding', 'fileformat']]
            \ },
            \ 'inactive': {
            \   'left':  [['inactivefilename']],
            \   'right': []
            \ },
            \ 'component_function': {
            \   'mode':             'LightlineMode',
            \   'spell':            'LightlineSpell',
            \   'branch':           'LightlineBranch',
            \   'filename':         'LightlineFileName',
            \   'filesize':         'LightlineFileSize',
            \   'spaces':           'LightlineTabsOrSpacesStatus',
            \   'fileencoding':     'LightlineFileEncoding',
            \   'fileformat':       'LightlineFileFormat',
            \   'fileinfo':         'LightlineFileInfo',
            \   'inactivefilename': 'LightlineInactiveFileName',
            \   'tablabel':         'LightlineTabLabel',
            \ },
            \ 'tab_component_function': {
            \   'tabnum':   'LightlineTabNum',
            \   'filename': 'LightlineTabFileType',
            \   'readonly': 'LightlineTabReadonly',
            \ },
            \ 'separator':    g:powerline_symbols.separator,
            \ 'subseparator': g:powerline_symbols.subseparator,
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

if findfile('plugin/webdevicons.vim', &rtp) != ''
    let g:lightline.active.right = [['filesize', 'spaces', 'fileinfo']]
endif

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
            \ 'vim-plug':          'Plug',
            \ 'unite':             'Unite',
            \ 'vimfiler':          'VimFiler',
            \ 'vimshell':          'VimShell',
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

if exists('*trim')
    function! s:strip(str) abort
        return trim(a:str)
    endfunction
else
    function! s:strip(str) abort
        return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
    endfunction
endif

function! s:CurrentWinWidth() abort
    return winwidth(0)
endfunction

function! s:IsSmallWindow() abort
    return winwidth(0) < 60
endfunction

function! s:ShortenFileName(filename) abort
    if exists('*pathshorten')
        return pathshorten(a:filename)
    else
        return substitute(a:filename, '\v\w\zs.{-}\ze(\\|/)', '', 'g')
    endif
endfunction

function! s:IsCustomMode(...) abort
    let ft = len(a:000) >= 1 ? a:0 : &filetype
    let fname = len(a:000) >= 2 ? a:1 : expand('%:t')
    return (fname =~? '^NrrwRgn' && exists('b:nrrw_instn')) || has_key(s:filetype_modes, ft) || has_key(s:filename_modes, fname)
endfunction

function! s:LightlineShortMode(mode) abort
    if s:IsSmallWindow()
        return get(s:short_modes, a:mode, a:mode)
    endif
    return a:mode
endfunction

function! s:LightlineCustomMode() abort
    if has_key(s:filetype_modes, &filetype)
        if &filetype ==# 'qf' && getwininfo(win_getid())[0]['loclist']
            return 'LocationList'
        endif

        return get(s:filetype_modes, &filetype)
    endif

    let fname = expand('%:t')
    if fname =~? '^NrrwRgn' && exists('b:nrrw_instn')
        return printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
    endif

    if has_key(s:filename_modes, fname)
        return get(s:filename_modes, fname)
    endif

    return ''
endfunction

function! s:LightlineClipboard() abort
    return match(&clipboard, 'unnamed') > -1 ? ' ' . g:powerline_symbols.clipboard : ''
endfunction

function! LightlineMode() abort
    let l:s = s:LightlineCustomMode()

    if empty(l:s)
        let l:s = s:LightlineShortMode(lightline#mode())
    endif

    return l:s . s:LightlineClipboard()
endfunction

function! LightlineSpell() abort
    if &spell
        return toupper(substitute(&spelllang, ',', '/', 'g'))
    endif
    return ''
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

function! s:BranchShorten(branch, length)
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
    if s:CurrentWinWidth() >= 100
        return s:BranchShorten(a:branch, 50)
    endif

    return s:BranchShorten(a:branch, 30)
endfunction

function! LightlineBranch() abort
    if s:CurrentWinWidth() >= 80 && !s:IsCustomMode()
        let branch = s:GetGitBranch()

        if empty(branch)
            return ''
        endif

        return g:powerline_symbols.branch . ' ' . s:FormatBranch(branch)
    endif

    return ''
endfunction

function! s:LightlineCtrlPMark() abort
    call lightline#link('iR'[g:lightline.ctrlp_regex])

    return lightline#concatenate([
                \ g:lightline.ctrlp_prev,
                \ '« ' . g:lightline.ctrlp_item . ' »',
                \ g:lightline.ctrlp_next,
                \ ], 0)
endfunction

function! s:LightlineCtrlSF(fname) abort
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

function! s:LightlineTagbarMark() abort
    call lightline#link()

    if empty(g:lightline.tagbar_flags)
        return lightline#concatenate([
                    \ g:lightline.tagbar_sort,
                    \ g:lightline.tagbar_fname,
                    \ ], 0)
    else
        return lightline#concatenate([
                    \ g:lightline.tagbar_sort,
                    \ join(g:lightline.tagbar_flags, ''),
                    \ g:lightline.tagbar_fname,
                    \ ], 0)
    endif
endfunction

function! s:LightlineAlternateFileName(fname) abort
    if &filetype ==# 'ctrlp' || a:fname ==# 'ControlP'
        return s:LightlineCtrlPMark()
    elseif &filetype ==# 'ctrlsf' || a:fname ==# '__CtrlSFPreview__' || a:fname ==# '__CtrlSF__'
        return s:LightlineCtrlSF(a:fname)
    elseif &filetype ==# 'tagbar' || a:fname =~? '^__Tagbar__'
        return s:LightlineTagbarMark()
    elseif &filetype ==# 'qf'
        return get(w:, 'quickfix_title', a:fname)
    elseif &filetype ==# 'help'
        return expand('%:~:.')
    elseif &filetype ==# 'unite'
        return unite#get_status_string()
    elseif &filetype ==# 'vimfiler'
        return vimfiler#get_status_string()
    elseif &filetype ==# 'vimshell'
        return vimshell#get_status_string()
    elseif a:fname =~? '^NrrwRgn'
        if get(b:, 'orig_buf', 0)
            return bufname(b:orig_buf)
        else
            return substitute(bufname('%'), '^Nrrwrgn_\zs.*\ze_\d\+$', submatch(0), ''))
        endif
    endif
    return ''
endfunction

function! s:LightlineModified() abort
    if &filetype !=? 'help' && &modified
        if &modifiable
            return ' +'
        else
            return '[-] +'
        endif
    endif
    return ''
endfunction

function! s:LightlineReadonly() abort
    if &readonly
        return g:powerline_symbols.readonly . ' '
    endif
    return ''
endfunction

function! s:GetFileName(fname) abort
    if strlen(a:fname)
        if s:IsSmallWindow()
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

function! s:GetFileNameWithFlags(fname) abort
    return s:LightlineReadonly() . s:GetFileName(a:fname) . s:LightlineModified()
endfunction

function! LightlineFileName() abort
    let fname = expand('%:t')

    if s:IsCustomMode()
        return s:LightlineAlternateFileName(fname)
    endif

    return s:GetFileNameWithFlags(fname)
endfunction

" Copied from https://github.com/ahmedelgabri/dotfiles/blob/master/files/vim/.vim/autoload/statusline.vim
function! LightlineFileSize() abort
    if s:CurrentWinWidth() < 80 || s:IsCustomMode()
        return ''
    endif

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

function! LightlineTabsOrSpacesStatus() abort
    if s:IsSmallWindow() || s:IsCustomMode()
        return ''
    endif

    let shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    return (&expandtab ? 'Spaces' : 'Tab Size') . ': ' . shiftwidth
endfunction

function! LightlineFileEncoding() abort
    let encoding = strlen(&fenc) ? &fenc : &enc
    if encoding !=? 'utf-8'
        return encoding
    endif
    return ''
endfunction

function! LightlineFileFormat() abort
    return &fileformat !=? 'unix' ? &fileformat : ''
endfunction

function! LightlineFileInfo() abort
    if s:IsCustomMode()
        return ''
    endif

    let result = []

    " file type
    call add(result, &filetype . WebDevIconsGetFileTypeSymbol() . ' ')

    " file encoding
    let encoding = LightlineFileEncoding()
    if strlen(encoding)
        call add(ary, encoding)
    endif

    " file format
    call add(result, WebDevIconsGetFileFormatSymbol() . ' ')

    return join(result)
endfunction

function! LightlineInactiveFileName() abort
    let fname = expand('%:t')

    if s:IsCustomMode()
        let l:s = s:LightlineCustomMode()
        let l:s .= ' ' . s:LightlineAlternateFileName(fname)
        return s:strip(l:s)
    endif

    return s:GetFileNameWithFlags(fname)
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
    return gettabwinvar(a:n, winnr, '&readonly') ? g:powerline_symbols.readonly : ''
endfunction


" CtrlP Integration
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
    let g:lightline.ctrlp_dir     = fnamemodify(getcwd(), ':~:.')
    if empty(g:lightline.ctrlp_dir)
        let g:lightline.ctrlp_dir = getcwd()
    endif
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str) abort
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

function! ZoomWinStatusLine(zoomstate) abort
    for f in s:ZoomWin_funcref
        if type(f) == 2
            call f(a:zoomstate)
        endif
    endfor
endfunction

let g:ZoomWin_funcref= function('ZoomWinStatusLine')

" Disable unite, vimfiler and vimshell status
let g:unite_force_overwrite_statusline    = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let &cpo = s:save_cpo
unlet s:save_cpo
