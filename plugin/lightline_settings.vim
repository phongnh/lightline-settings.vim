" lightline_settings.vim
" Maintainer: Phong Nguyen
" Version:    0.1.0

if exists('g:loaded_vim_lightline_settings') || v:version < 700
    finish
endif

let g:loaded_vim_lightline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

" Settings
let g:lightline_show_tab_close_button = get(g:, 'lightline_show_tab_close_button', 0)
let g:lightline_show_git_branch       = get(g:, 'lightline_show_git_branch', 1)
let g:lightline_show_file_size        = get(g:, 'lightline_show_file_size', 1)
let g:lightline_show_devicons         = get(g:, 'lightline_show_devicons', 1)

" Disable NERDTree statusline
let g:NERDTreeStatusline = -1

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
                \ 'clipboard':    'ⓒ  ',
                \ 'paste':        'Ⓟ  ',
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

if get(g:, 'lightline_noshowmode', 1)
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
            \   'left':  [['mode'], ['plugin', 'branch', 'filename']],
            \   'right': [['spaces', 'fileinfo', 'plugin_extra'], ['buffer']]
            \ },
            \ 'inactive': {
            \   'left':  [['inactive']],
            \   'right': []
            \ },
            \ 'component_function': {
            \   'mode':         'LightlineModeStatus',
            \   'plugin':       'LightlinePluginStatus',
            \   'branch':       'LightlineGitBranchStatus',
            \   'filename':     'LightlineFileNameStatus',
            \   'spaces':       'LightlineIndentationStatus',
            \   'fileinfo':     'LightlineFileInfoStatus',
            \   'plugin_extra': 'LightlinePluginExtraStatus',
            \   'buffer':       'LightlineBufferStatus',
            \   'inactive':     'LightlineInactiveStatus',
            \   'tablabel':     'LightlineTabLabel',
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
" let s:has_devicons = exists('*WebDevIconsGetFileTypeSymbol') && exists('*WebDevIconsGetFileFormatSymbol')

" Alternate status dictionaries
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
            \ 'netrw':             'NetrwTree',
            \ 'nerdtree':          'NERDTree',
            \ 'startify':          'Startify',
            \ 'tagbar':            'Tagbar',
            \ 'vim-plug':          'Plugins',
            \ 'help':              'HELP',
            \ 'qf':                'Quickfix',
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

function! s:ShortenPath(filename) abort
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

function! s:GetBufferType() abort
    return strlen(&filetype) ? &filetype : &buftype
endfunction

function! s:GetFileName() abort
    let fname = expand('%:~:.')

    if empty(fname)
        return '[No Name]'
    endif

    return fname
endfunction

function! s:FormatFileName(fname) abort
    if strlen(a:fname)
        if s:CurrentWinWidth() < s:xsmall_window_width
            return a:fname
        endif

        let l:path = expand('%:~:.')

        if strlen(l:path) > 50
            let l:path = s:ShortenPath(l:path)
        endif

        if strlen(l:path) > 50
            let l:path = a:fname
        endif

        return l:path
    endif

    return '[No Name]'
endfunction

function! s:ModifiedStatus() abort
    if &modified
        if !&modifiable
            return '[+-]'
        else
            return '[+]'
        endif
    elseif !&modifiable
        return '[-]'
    endif

    return ''
endfunction

function! s:ReadonlyStatus() abort
    return &readonly ? s:symbols.readonly . ' ' : ''
endfunction

function! s:FileNameStatus() abort
    return s:ReadonlyStatus() . s:FormatFileName(s:GetFileName()) . s:ModifiedStatus()
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

function! s:FileSizeStatus() abort
    if g:lightline_show_file_size
        return s:FileSize()
    endif
    return ''
endfunction

function! s:GetGitBranch() abort
    let branch = ''

    if exists('*FugitiveHead')
        let branch = FugitiveHead()

        if empty(branch) && exists('*FugitiveDetect') && !exists('b:git_dir')
            call FugitiveDetect(getcwd())
            let branch = FugitiveHead()
        endif
    elseif exists('*fugitive#head')
        let branch = fugitive#head()

        if empty(branch) && exists('*fugitive#detect') && !exists('b:git_dir')
            call fugitive#detect(getcwd())
            let branch = fugitive#head()
        endif
    elseif exists(':Gina') == 2
        let branch = gina#component#repo#branch()
    endif

    return branch
endfunction

function! s:ShortenBranch(branch, length) abort
    let branch = a:branch

    if strlen(branch) > a:length
        let branch = s:ShortenPath(branch)
    endif

    if strlen(branch) > a:length
        let branch = fnamemodify(branch, ':t')
    endif

    return branch
endfunction

function! s:FormatBranch(branch) abort
    if s:CurrentWinWidth() >= s:normal_window_width
        return s:ShortenBranch(a:branch, 50)
    endif

    let branch = s:ShortenBranch(a:branch, 30)

    if strlen(branch) > 30
        let branch = strcharpart(branch, 0, 29) . s:powerline_symbols.ellipsis
    endif

    return branch
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
    let compact = get(a:, 1, 0)
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', shiftwidth)
    endif
endfunction

function! s:FileEncodingStatus() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    " Show encoding only if it is not utf-8
    if empty(l:encoding) || l:encoding ==# 'utf-8'
        return ''
    endif
    return printf('[%s]', l:encoding)
endfunction

function! s:FileEncodingAndFormatStatus() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding

    if strlen(l:encoding) && strlen(&fileformat)
        let stl = printf('%s[%s]', l:encoding, &fileformat)
    elseif strlen(l:encoding)
        let stl = l:encoding
    else
        let stl = printf('[%s]', &fileformat)
    endif

    " Show format only if it is not utf-8[unix]
    if stl ==# 'utf-8[unix]'
        return ''
    endif

    return stl
endfunction

function! s:FileInfoStatus(...) abort
    let ft = s:GetBufferType()

    if g:lightline_show_devicons && s:has_devicons
        let compact = get(a:, 1, 0)

        let parts = s:RemoveEmptyElement([
                    \ s:FileEncodingStatus(),
                    \ !compact ? WebDevIconsGetFileFormatSymbol() . ' ' : '',
                    \ ft,
                    \ !compact ? WebDevIconsGetFileTypeSymbol(expand('%')) . ' ' : '',
                    \ ])
    else
        let parts = s:RemoveEmptyElement([
                    \ s:FileEncodingAndFormatStatus(),
                    \ ft,
                    \ ])
    endif

    return join(parts, ' ')
endfunction

let s:lightline_time_threshold = 0.20

function! s:SaveLastTime()
    let s:lightline_last_custom_mode_time = reltime()
endfunction

call s:SaveLastTime()

function! s:CustomMode() abort
    if has_key(b:, 'lightline_custom_mode') && reltimefloat(reltime(s:lightline_last_custom_mode_time)) < s:lightline_time_threshold
        return b:lightline_custom_mode
    endif
    let b:lightline_custom_mode = s:FetchCustomMode()
    call s:SaveLastTime()
    return b:lightline_custom_mode
endfunction

function! s:FetchCustomMode() abort
    let fname = expand('%:t')

    if has_key(s:filename_modes, fname)
        let result = {
                    \ 'name': s:filename_modes[fname],
                    \ 'type': 'name',
                    \ }

        if fname ==# '__CtrlSF__'
            let pattern = substitute(ctrlsf#utils#SectionB(), 'Pattern: ', '', '')

            let plugin_status = lightline#concatenate([
                        \ pattern,
                        \ ctrlsf#utils#SectionC(),
                        \ ], 0)

            return extend(result, {
                        \ 'plugin': plugin_status,
                        \ 'plugin_inactive': pattern,
                        \ 'plugin_extra': ctrlsf#utils#SectionX(),
                        \ })
        endif

        if fname ==# '__CtrlSFPreview__'
            let result['plugin'] = ctrlsf#utils#PreviewSectionC()
            let result['plugin_inactive'] = result['plugin']
            return result
        endif

        return result
    endif

    if fname =~? '^NrrwRgn'
        let nrrw_rgn_status = s:NrrwRgnStatus()
        if len(nrrw_rgn_status)
            return extend(nrrw_rgn_status, {
                        \ 'type': 'nrrwrgn',
                        \ })
        endif
    endif

    let ft = s:GetBufferType()
    if has_key(s:filetype_modes, ft)
        let result = {
                    \ 'name': s:filetype_modes[ft],
                    \ 'type': 'filetype',
                    \ }

        if ft ==# 'ctrlp'
            return extend(result, s:GetCtrlPMode())
        endif

        if ft ==# 'tagbar'
            return extend(result, s:GetTagbarMode())
        endif

        if ft ==# 'terminal'
            let result['plugin'] = expand('%')
            return result
        endif

        if ft ==# 'help'
            let result['plugin'] = expand('%:p')
            let result['plugin_inactive'] = result['plugin']
            return result
        endif

        if ft ==# 'qf'
            if getwininfo(win_getid())[0]['loclist']
                let result['name'] = 'Location'
            endif
            let result['plugin'] = s:Strip(get(w:, 'quickfix_title', ''))
            let result['plugin_inactive'] = result['plugin']
            return result
        endif

        return result
    endif

    return {}
endfunction

function! s:NrrwRgnStatus(...) abort
    let result = {}

    if exists(':WidenRegion') == 2
        if exists('b:nrrw_instn')
            let result['name'] = printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
        else
            let l:mode = substitute(bufname('%'), '^Nrrwrgn_\zs.*\ze_\d\+$', submatch(0), '')
            let l:mode = substitute(l:mode, '__', '#', '')
            let result['name'] = l:mode
        endif

        let dict = exists('*nrrwrgn#NrrwRgnStatus()') ?  nrrwrgn#NrrwRgnStatus() : {}

        if len(dict)
            let result['plugin'] = fnamemodify(dict.fullname, ':~:.')
            let result['plugin_inactive'] = result['plugin']
        elseif get(b:, 'orig_buf', 0)
            let result['plugin'] = bufname(b:orig_buf)
            let result['plugin_inactive'] = result['plugin']
        endif
    endif

    return result
endfunction

function! s:IsCompact() abort
    return &spell || &paste || strlen(s:ClipboardStatus()) || s:CurrentWinWidth() <= s:xsmall_window_width
endfunction

function! LightlineModeStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return l:mode['name']
    endif

    let mode_label = lightline#mode()
    if s:CurrentWinWidth() < s:xsmall_window_width
        return get(s:short_modes, mode_label, mode_label)
    endif

    return mode_label
endfunction

function! LightlineGitBranchStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    if g:lightline_show_git_branch && s:CurrentWinWidth() > s:small_window_width
        let branch = s:FormatBranch(s:GetGitBranch())

        if strlen(branch)
            return s:symbols.branch . ' ' . branch
        endif
    endif

    return ''
endfunction

function! LightlineFileNameStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    return s:FileNameStatus()
endfunction

function! LightlineFileInfoStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    let compact = s:IsCompact()

    if s:CurrentWinWidth() >= s:small_window_width
        return lightline#concatenate([
                    \ s:FileSize(),
                    \ s:FileInfoStatus(compact),
                    \ ], 1)
    endif

    return s:FileInfoStatus(compact)
endfunction

function! LightlineIndentationStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    if s:CurrentWinWidth() >= s:small_window_width
        let compact = s:IsCompact()
        return s:IndentationStatus(compact)
    endif

    return ''
endfunction

function! LightlineBufferStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    if s:CurrentWinWidth() >= s:small_window_width
        return lightline#concatenate(
                    \ s:RemoveEmptyElement([
                    \   s:ClipboardStatus(),
                    \   s:PasteStatus(),
                    \   s:SpellStatus(),
                    \ ]), 1)
    endif

    return ''
endfunction

function! LightlinePluginStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        if has_key(l:mode, 'link')
            call lightline#link(l:mode['link'])
        endif
        return get(l:mode, 'plugin', '')
    endif

    return ''
endfunction

function! LightlinePluginExtraStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return get(l:mode, 'plugin_extra', '')
    endif

    return ''
endfunction

function! LightlineInactiveStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        if has_key(l:mode, 'plugin_inactive')
            return lightline#concatenate(
                        \ s:RemoveEmptyElement([
                        \   l:mode['name'],
                        \   get(l:mode, 'plugin_inactive', '')
                        \ ]), 0)
        endif
        return l:mode['name']
    endif

    return s:FileNameStatus()
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

function! s:GetCtrlPMode() abort
    let plugin_status = lightline#concatenate([
                \ g:lightline.ctrlp_prev,
                \ '« ' . g:lightline.ctrlp_item . ' »',
                \ g:lightline.ctrlp_next,
                \ ], 0)

    let plugin_extra = lightline#concatenate([
                \ g:lightline.ctrlp_focus,
                \ g:lightline.ctrlp_byfname,
                \ g:lightline.ctrlp_dir,
                \ ], 1)

    return {
                \ 'custom': 1,
                \ 'name': s:filetype_modes['ctrlp'],
                \ 'link': 'nR'[g:lightline.ctrlp_regex],
                \ 'plugin': plugin_status,
                \ 'plugin_extra': plugin_extra,
                \ 'type': 'ctrlp',
                \ }
endfunction

function! CtrlPMainStatusLine(focus, byfname, regex, prev, item, next, marked) abort
    let g:lightline.ctrlp_focus   = a:focus
    let g:lightline.ctrlp_byfname = a:byfname
    let g:lightline.ctrlp_regex   = a:regex
    let g:lightline.ctrlp_prev    = a:prev
    let g:lightline.ctrlp_item    = a:item
    let g:lightline.ctrlp_next    = a:next
    let g:lightline.ctrlp_marked  = a:marked
    let g:lightline.ctrlp_dir     = s:GetCurrentDir()

    let b:lightline_custom_mode = s:GetCtrlPMode()
    call s:SaveLastTime()

    return lightline#statusline(0)
endfunction

function! CtrlPProgressStatusLine(len) abort
    let b:lightline_custom_mode = {
                \ 'custom': 1,
                \ 'name': s:filetype_modes['ctrlp'],
                \ 'plugin': a:len,
                \ 'plugin_extra': s:GetCurrentDir(),
                \ 'type': 'ctrlp',
                \ }
    return lightline#statusline(0)
endfunction

" Tagbar Integration
let g:tagbar_status_func = 'TagbarStatusFunc'

function! s:GetTagbarMode() abort
    if empty(g:lightline.tagbar_flags)
        let plugin_status = lightline#concatenate([
                    \ g:lightline.tagbar_sort,
                    \ g:lightline.tagbar_fname,
                    \ ], 0)
    else
        let plugin_status = lightline#concatenate([
                    \ g:lightline.tagbar_sort,
                    \ g:lightline.tagbar_fname,
                    \ join(g:lightline.tagbar_flags, ''),
                    \ ], 0)
    endif

    return {
                \ 'custom': 1,
                \ 'name': s:filetype_modes['tagbar'],
                \ 'plugin': plugin_status,
                \ 'type': 'ctrlp',
                \ }
endfunction

function! TagbarStatusFunc(current, sort, fname, flags, ...) abort
    let g:lightline.tagbar_sort  = a:sort
    let g:lightline.tagbar_fname = a:fname
    let g:lightline.tagbar_flags = a:flags

    let b:lightline_custom_mode = s:GetTagbarMode()
    call s:SaveLastTime()

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
    if exists('*lightline#update')
        call lightline#update()
    endif
endfunction

let g:ZoomWin_funcref= function('ZoomWinStatusLine')

let &cpo = s:save_cpo
unlet s:save_cpo
