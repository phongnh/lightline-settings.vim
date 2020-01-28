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
    let g:powerline_symbols.ellipsis     = '…'
else
    let g:powerline_symbols.separator    = { 'left': '', 'right': '' }
    let g:powerline_symbols.subseparator = { 'left': '|', 'right': '|' }
    let g:powerline_symbols.linenr       = ''
    let g:powerline_symbols.branch       = ''
    let g:powerline_symbols.readonly     = 'RO'
    let g:powerline_symbols.clipboard    = ' @'
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
            \   'left':  [['mode', 'paste', 'spell'], ['fugitive', 'filename']],
            \   'right': [['ctrlpdir'], ['fileformat', 'fileencoding', 'spaces', 'filetype']]
            \ },
            \ 'inactive': {
            \   'left':  [['inactivefilename']],
            \   'right': [['fileformat', 'fileencoding', 'filetype']]
            \ },
            \ 'component_function': {
            \   'tablabel':         'LightlineTabLabel',
            \   'mode':             'LightlineModeAndClipboard',
            \   'fugitive':         'LightlineFugitive',
            \   'filename':         'LightlineFileName',
            \   'inactivefilename': 'LightlineInactiveFileName',
            \   'lineinfo':         'LightlineLineInfo',
            \   'percent':          'LightlinePercent',
            \   'fileformat':       'LightlineFileFormat',
            \   'fileencoding':     'LightlineFileEncoding',
            \   'filetype':         'LightlineFileType',
            \   'spaces':           'LightlineTabsOrSpacesStatus',
            \   'ctrlpdir':         'LightlineCtrlPDir',
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

let s:filename_modes = {
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
            \ 'leaderf':           'LeaderF',
            \ 'netrw':             'NetrwTree',
            \ 'nerdtree':          'NERDTree',
            \ 'startify':          'Startify',
            \ 'vim-plug':          'Plug',
            \ 'unite':             'Unite',
            \ 'vimfiler':          'VimFiler',
            \ 'vimshell':          'VimShell',
            \ 'help':              'HELP',
            \ 'qf':                '%q',
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

function! s:CurrentWinWidth() abort
    return winwidth(0)
endfunction

function! s:IsDisplayableFileName() abort
    if s:CurrentWinWidth() >= 50 && &filetype =~? 'help\|gedoc'
        return 1
    endif
    return s:IsDisplayableFileInfo()
endfunction

function! s:IsDisplayableFileInfo() abort
    if s:CurrentWinWidth() < 50 || expand('%:t') =~? '^NrrwRgn' || has_key(s:filetype_modes, &filetype) || has_key(s:filename_modes, expand('%:t'))
        return 0
    endif
    return 1
endfunction

function! s:IsDisplayableLineInfo() abort
    if s:CurrentWinWidth() >= 50 && &filetype =~? 'help\|qf\|godoc\|gedoc'
        return 1
    endif
    return s:IsDisplayableFileInfo()
endfunction

function! s:LightlineModified() abort
    return &filetype =~? 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! s:LightlineReadonly() abort
    return &filetype !~? 'help' && &readonly ? g:powerline_symbols.readonly : ''
endfunction

function! s:LightlineClipboard() abort
    return match(&clipboard, 'unnamed') > -1 ? g:powerline_symbols.clipboard : ''
endfunction

function! s:LightlineShortMode(mode) abort
    if s:CurrentWinWidth() > 75
        return a:mode
    endif
    return get(s:short_modes, a:mode, a:mode)
endfunction

function! s:LightlineMode() abort
    let fname = expand('%:t')
    if fname =~? '^NrrwRgn' && exists('b:nrrw_instn')
        return printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
    endif
    return get(s:filetype_modes, &filetype, get(s:filename_modes, fname, s:LightlineShortMode(lightline#mode())))
endfunction

function! LightlineModeAndClipboard() abort
    return s:LightlineMode() . s:LightlineClipboard()
endfunction

function! LightlineTabNum(n) abort
    return printf('[%d]', a:n)
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
function! LightlineTabFileType(n) abort
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
    return fname =~# '^\[preview' ? 'Preview' : get(s:filetype_modes, ft, get(s:filename_modes, fname, fname))
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
        let branch = pathshorten(branch)
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

function! LightlineFugitive() abort
    if s:IsDisplayableFileInfo() && s:CurrentWinWidth() >= 80
        let branch = s:GetGitBranch()

        if empty(branch)
            return ''
        endif

        return g:powerline_symbols.branch . s:FormatBranch(branch)
    endif
    return ''
endfunction

function! s:LightlineAlternateFileName(fname) abort
    if a:fname ==# 'ControlP'
        return LightlineCtrlPMark()
    elseif a:fname ==# '__Tagbar__'
        return g:lightline.fname
    elseif a:fname =~ '__Gundo\|NERD_tree'
        return ''
    elseif a:fname =~? '^NrrwRgn'
        let bufname = (get(b:, 'orig_buf', 0) ? bufname(b:orig_buf) : substitute(bufname('%'), '^Nrrwrgn_\zs.*\ze_\d\+$', submatch(0), ''))
        return bufname
    elseif &filetype ==# 'qf'
        return get(w:, 'quickfix_title', a:fname)
    elseif &filetype ==# 'unite'
        return unite#get_status_string()
    elseif &filetype ==# 'vimfiler'
        return vimfiler#get_status_string()
    elseif &filetype ==# 'vimshell'
        return vimshell#get_status_string()
    endif
    return ''
endfunction

function! LightlineFileNameWithFlags(fname) abort
    if s:IsDisplayableFileName()
        let str = (s:LightlineReadonly() != '' ? s:LightlineReadonly() . ' ' : '')
        if strlen(a:fname)
            let path = expand('%:~:.')
            if strlen(path) > 60
                let path = substitute(path, '\v\w\zs.{-}\ze(\\|/)', '', 'g')
            endif
            if strlen(path) > 60
                let path = a:fname
            endif
            let str .= path
        else
            let str .= '[No Name]'
        endif
        let str .= (s:LightlineModified() != '' ? ' ' . s:LightlineModified() : '')
        return str
    endif
    return ''
endfunction

function! LightlineFileName() abort
    let fname = expand('%:t')

    let str = s:LightlineAlternateFileName(fname)

    if strlen(str)
        return str
    endif

    return LightlineFileNameWithFlags(fname)
endfunction

function! LightlineInactiveFileName() abort
    let fname = expand('%:t')

    let str = s:LightlineAlternateFileName(fname)

    if strlen(str)
        return str
    endif

    let str = get(s:filetype_modes, &filetype, get(s:filename_modes, fname, ''))
    if strlen(str)
        if &filetype ==? 'help'
            let str .= ' ' .  expand('%:~:.')
        endif

        return str
    endif

    return LightlineFileNameWithFlags(fname)
endfunction

function! LightlineLineInfo() abort
    if s:IsDisplayableLineInfo()
        return printf('%s%4d:%3d', g:powerline_symbols.linenr, line('.'), col('.'))
    endif
    return ''
endfunction

function! LightlinePercent() abort
    if s:IsDisplayableLineInfo()
        return printf('%3d%%', line('.') * 100 / line('$'))
    endif
    return ''
endfunction

function! LightlineFileFormat() abort
    if !s:IsDisplayableFileInfo()
        return ''
    endif
    if exists('*WebDevIconsGetFileFormatSymbol')
        return &fileformat . ' ' . WebDevIconsGetFileFormatSymbol() . ' '
    else
        return &fileformat !=? 'unix' ? &fileformat : ''
    endif
endfunction

function! LightlineFileEncoding() abort
    if s:IsDisplayableFileInfo()
        let encoding = strlen(&fenc) ? &fenc : &enc
        if encoding !=? 'utf-8'
            return encoding
        endif
    endif
    return ''
endfunction

function! LightlineFileType() abort
    if !s:IsDisplayableFileInfo()
        return ''
    endif
    if exists('*WebDevIconsGetFileTypeSymbol')
        return &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' '
    else
        return &filetype
    endif
endfunction

function! LightlineTabsOrSpacesStatus() abort
    if s:IsDisplayableFileInfo()
        let shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
        return (&expandtab ? 'Spaces' : 'Tab Size') . ': ' . shiftwidth
    endif
    return ''
endfunction

function! LightlineCtrlPMark() abort
    if &filetype ==? 'ctrlp' || expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])

        return lightline#concatenate([
                    \ g:lightline.ctrlp_prev,
                    \ '<' . g:lightline.ctrlp_item . '>',
                    \ g:lightline.ctrlp_next,
                    \ ], 0)
    endif
    return ''
endfunction

function! LightlineCtrlPDir() abort
    if &filetype ==? 'ctrlp' || expand('%:t') =~ 'ControlP'
        return lightline#concatenate([
                    \ g:lightline.ctrlp_focus,
                    \ g:lightline.ctrlp_byfname . ' ' . g:lightline.ctrlp_dir,
                    \ ], 1)
    endif
    return ''
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
    let g:lightline.ctrlp_dir     = fnamemodify(getcwd(), ':~')
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
