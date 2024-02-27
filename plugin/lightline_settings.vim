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
let g:lightline_powerline_fonts       = get(g:, 'lightline_powerline_fonts', 0)
let g:lightline_theme                 = get(g:, 'lightline_theme', 'solarized')
let g:lightline_shorten_path          = get(g:, 'lightline_shorten_path', 0)
let g:lightline_show_tab_close_button = get(g:, 'lightline_show_tab_close_button', 0)
let g:lightline_show_git_branch       = get(g:, 'lightline_show_git_branch', 1)
let g:lightline_show_devicons         = get(g:, 'lightline_show_devicons', 1)
let g:lightline_show_vim_logo         = get(g:, 'lightline_show_vim_logo', 1)

" Disable NERDTree statusline
let g:NERDTreeStatusline = -1

" Window width
let s:xsmall_window_width = 60
let s:small_window_width  = 80
let s:normal_window_width = 120

" Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
let s:symbols = {
                \ 'linenr':    '☰',
                \ 'branch':    '⎇ ',
                \ 'readonly':  '',
                \ 'clipboard': '🅒  ',
                \ 'paste':     '🅟  ',
                \ 'ellipsis':  '…',
                \ }

let g:lightline = {
            \ 'colorscheme': g:lightline_theme,
            \ 'enable': {
            \   'statusline': 1,
            \   'tabline':    1,
            \ },
            \ 'separator': {
            \   'left': '',
            \   'right': '',
            \ },
            \ 'subseparator': {
            \  'left': '|',
            \  'right': '|',
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
            \   'right': [
            \       ['indentation', 'fileinfo'] + (get(g:, 'lightline_show_linenr', 0) ? ['lineinfo'] : []) + ['plugin_extra'],
            \       ['buffer'],
            \   ]
            \ },
            \ 'inactive': {
            \   'left':  [['inactive']],
            \   'right': []
            \ },
            \ 'component': {
            \   'tablabel':    'Tabs',
            \   'bufferlabel': 'Buffers',
            \ },
            \ 'component_function': {
            \   'mode':         'LightlineModeStatus',
            \   'plugin':       'LightlinePluginStatus',
            \   'branch':       'LightlineGitBranchStatus',
            \   'filename':     'LightlineFileNameStatus',
            \   'indentation':  'LightlineIndentationStatus',
            \   'fileinfo':     'LightlineFileInfoStatus',
            \   'lineinfo':     'LightlineLineInfoStatus',
            \   'plugin_extra': 'LightlinePluginExtraStatus',
            \   'buffer':       'LightlineBufferStatus',
            \   'inactive':     'LightlineInactiveStatus',
            \ },
            \ 'tab_component_function': {
            \   'tabnum':   'LightlineTabNum',
            \   'filename': 'LightlineTabFileType',
            \   'readonly': 'LightlineTabReadonly',
            \ },
            \ }

if g:lightline_powerline_fonts
    call extend(s:symbols, {
                \ 'linenr':   "\ue0a1",
                \ 'branch':   "\ue0a0",
                \ 'readonly': "\ue0a2",
                \ })

    call lightline_settings#SetPowerlineSeparators(get(g:, 'lightline_powerline_style', 'default'))
endif

let s:lightline_show_devicons = 0

if g:lightline_show_devicons
    " Detect vim-devicons or nerdfont.vim
    " let s:has_devicons = exists('*WebDevIconsGetFileTypeSymbol') && exists('*WebDevIconsGetFileFormatSymbol')
    if findfile('autoload/nerdfont.vim', &rtp) != ''
        let s:lightline_show_devicons = 1

        function! s:GetFileTypeSymbol(filename) abort
            return nerdfont#find(a:filename)
        endfunction

        function! s:GetFileFormatSymbol(...) abort
            return nerdfont#fileformat#find()
        endfunction
    elseif findfile('plugin/webdevicons.vim', &rtp) != ''
        let s:lightline_show_devicons = 1

        function! s:GetFileTypeSymbol(filename) abort
            return WebDevIconsGetFileTypeSymbol(a:filename)
        endfunction

        function! s:GetFileFormatSymbol(...) abort
            return WebDevIconsGetFileFormatSymbol()
        endfunction
    elseif exists("g:LightlineWebDevIconsFind")
        let s:lightline_show_devicons = 1

        function! s:GetFileTypeSymbol(filename) abort
            return g:LightlineWebDevIconsFind(a:filename)
        endfunction

        let s:web_devicons_fileformats = {
                    \ 'dos': '',
                    \ 'mac': '',
                    \ 'unix': '',
                    \ }

        function! s:GetFileFormatSymbol(...) abort
            return get(s:web_devicons_fileformats, &fileformat, '')
        endfunction
    endif
endif

if g:lightline_show_vim_logo && s:lightline_show_devicons
    " Show Vim Logo in Tabline
    let g:lightline.component.tablabel    = "\ue7c5" . ' '
    let g:lightline.component.bufferlabel = "\ue7c5" . ' '
endif

if get(g:, 'lightline_bufferline', 0) && findfile('plugin/bufferline.vim', &rtp) != ''
    " https://github.com/mengelbrecht/lightline-bufferline
    let g:lightline.tabline          = { 'left': [['bufferlabel', 'buffers']], 'right': [['close']] }
    let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
    let g:lightline.component_type   = { 'buffers': 'tabsel' }

    let g:lightline#bufferline#unicode_symbols   = g:lightline_powerline_fonts
    let g:lightline#bufferline#filename_modifier = ':t'
    let g:lightline#bufferline#show_number       = 1
    let g:lightline#bufferline#shorten_path      = 1
    let g:lightline#bufferline#unnamed           = '[No Name]'
    let g:lightline#bufferline#enable_devicons   = s:has_devicons
    let g:lightline#bufferline#enable_nerdfont   = s:has_nerdfont
    let g:lightline#bufferline#icon_position     = 'right'

    " let g:lightline#bufferline#number_map = {
    "             \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
    "             \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
    "             \ }

    " let g:lightline#bufferline#number_map = {
    "             \ 0: '₀', 1: '₁', 2: '₂', 3: '₃', 4: '₄',
    "             \ 5: '₅', 6: '₆', 7: '₇', 8: '₈', 9: '₉'
    "             \ }
endif

command! LightlineReload call <SID>LightlineReload()
command! -nargs=1 -complete=custom,<SID>ListLightlineColorschemes LightlineTheme call <SID>SetLightlineTheme(<f-args>)

function! s:LightlineReload() abort
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! s:FindLightlineThemes() abort
    if exists('s:lightline_colorschemes')
        return s:lightline_colorschemes
    endif
    let s:lightline_colorschemes = map(split(globpath(&rtp, 'autoload/lightline/colorscheme/*.vim')), "fnamemodify(v:val, ':t:r')")
    let s:lightline_colorschemes_completion = join(s:lightline_colorschemes, "\n")
endfunction

function! s:ListLightlineColorschemes(...) abort
    return s:lightline_colorschemes_completion
endfunction

function! s:SetLightlineTheme(colorscheme) abort
    if index(s:lightline_colorschemes, a:colorscheme) < 0
        return
    endif

    " Reload palette
    let l:colorscheme_path = findfile(printf('autoload/lightline/colorscheme/%s.vim', a:colorscheme), &rtp)
    if !empty(l:colorscheme_path) && filereadable(l:colorscheme_path)
        execute 'source ' . l:colorscheme_path
    endif

    let g:lightline.colorscheme = a:colorscheme
    call s:LightlineReload()
endfunction

let s:lightline_colorscheme_mappings = {
            \ 'gruvbox': ['gruvbox8', 'gruvbox-material'],
            \ }

function! s:DetectLightlineTheme() abort
    let l:original_colorscheme = get(g:, 'colors_name', '')

    if has('vim_starting') && exists('g:lightline_theme')
        let l:original_colorscheme = g:lightline_theme
    endif

    if l:original_colorscheme =~ 'solarized\|soluarized\|flattened'
        let l:original_colorscheme = 'solarized'
    endif

    let l:colorscheme = l:original_colorscheme
    if index(s:lightline_colorschemes, l:colorscheme) > -1
        return l:colorscheme
    endif

    let l:colorscheme = tolower(l:original_colorscheme)
    if index(s:lightline_colorschemes, l:colorscheme) > -1
        return l:colorscheme
    endif

    for l:alternative_colorscheme in get(s:lightline_colorscheme_mappings, l:colorscheme, [])
        if index(s:lightline_colorschemes, l:alternative_colorscheme) > -1
            return l:alternative_colorscheme
        endif
    endfor

    let l:colorscheme = substitute(l:original_colorscheme, '-', '_', 'g')
    if index(s:lightline_colorschemes, l:colorscheme) > -1
        return l:colorscheme
    endif

    return substitute(l:original_colorscheme, '-', '', 'g')
endfunction

function! s:ReloadLightlineTheme() abort
    call s:FindLightlineThemes()

    let l:colorscheme = s:DetectLightlineTheme()

    call s:SetLightlineTheme(l:colorscheme)
endfunction

augroup VimLightlineColorscheme
    autocmd!
    autocmd VimEnter * call <SID>ReloadLightlineTheme() | setglobal noshowmode
    autocmd ColorScheme * call <SID>ReloadLightlineTheme()
augroup END

" Alternate status dictionaries
let s:filename_modes = {
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

let s:filetype_modes = {
            \ 'netrw':             'Netrw',
            \ 'molder':            'Molder',
            \ 'nerdtree':          'NERDTree',
            \ 'CHADTree':          'CHADTree',
            \ 'NvimTree':          'NvimTree',
            \ 'neo-tree':          'NeoTree',
            \ 'oil':               'Oil',
            \ 'LuaTree':           'LuaTree',
            \ 'carbon.explorer':   'Carbon',
            \ 'fern':              'Fern',
            \ 'vaffle':            'Vaffle',
            \ 'dirvish':           'Dirvish',
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

function! s:Wrap(text) abort
    return printf('%s %s %s', '«', a:text, '»')
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
    let l:path = a:fname

    if s:CurrentWinWidth() <= s:xsmall_window_width
        return fnamemodify(l:path, ':t')
    endif

    if strlen(l:path) > 50 && g:lightline_shorten_path
        let l:path = s:ShortenPath(l:path)
    endif

    if strlen(l:path) > 50
        let l:path = fnamemodify(l:path, ':t')
    endif

    return l:path
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

function! s:InactiveFileNameStatus() abort
    return s:ReadonlyStatus() . s:GetFileName() . s:ModifiedStatus()
endfunction

function! s:GetGitBranch() abort
    " Get branch from caching if it is available
    if has_key(b:, 'lightline_git_branch') && reltimefloat(reltime(s:lightline_last_finding_branch_time)) < s:lightline_time_threshold
        return b:lightline_git_branch
    endif

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

    " Caching
    let b:lightline_git_branch = branch
    let s:lightline_last_finding_branch_time = reltime()

    return branch
endfunction

function! s:ShortenBranch(branch, length) abort
    let branch = a:branch

    if strlen(branch) > a:length && g:lightline_shorten_path
        let branch = s:ShortenPath(branch)
    endif

    if strlen(branch) > a:length
        let branch = fnamemodify(branch, ':t')
    endif

    if strlen(branch) > a:length
        " Show only JIRA ticket prefix
        let branch = substitute(branch, '^\([A-Z]\{3,}-\d\{1,}\)-.\+', '\1', '')
    endif

    return branch
endfunction

function! s:FormatBranch(branch) abort
    if s:CurrentWinWidth() >= s:normal_window_width
        return s:ShortenBranch(a:branch, 50)
    endif

    let branch = s:ShortenBranch(a:branch, 30)

    if strlen(branch) > 30
        let branch = strcharpart(branch, 0, 29) . s:symbols.ellipsis
    endif

    return branch
endfunction

function! s:IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! s:ClipboardStatus() abort
    return s:IsClipboardEnabled() ? s:symbols.clipboard : ''
endfunction

function! s:PasteStatus() abort
    return &paste ? s:symbols.paste : ''
endfunction

function! s:SpellStatus() abort
    return &spell ? toupper(substitute(&spelllang, ',', '/', 'g')) : ''
endfunction

function! s:IndentationStatus(...) abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = get(a:, 1, 0)
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! s:FileEncodingAndFormatStatus() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:bomb     = &bomb ? '[BOM]' : ''
    let l:format   = strlen(&fileformat) ? printf('[%s]', &fileformat) : ''

    " Skip common string utf-8[unix]
    if (l:encoding . l:format) ==# 'utf-8[unix]'
        return l:bomb
    endif

    return l:encoding . l:bomb . l:format
endfunction

function! s:FileInfoStatus(...) abort
    let parts = [
                \ s:FileEncodingAndFormatStatus(),
                \ s:GetBufferType(),
                \ ]

    let compact = get(a:, 1, 0)

    if s:lightline_show_devicons && !compact
        call extend(parts, [
                    \ s:GetFileTypeSymbol(expand('%')) . ' ',
                    \ s:GetFileFormatSymbol() . ' ',
                    \ ])
    endif

    return join(s:RemoveEmptyElement(parts), ' ')
endfunction

function! s:IsCompact() abort
    return &spell || &paste || s:IsClipboardEnabled() || s:CurrentWinWidth() <= s:xsmall_window_width
endfunction

function! LightlineModeStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return l:mode['name']
    endif

    let mode_label = lightline#mode()
    if s:CurrentWinWidth() <= s:xsmall_window_width
        return get(s:short_modes, mode_label, mode_label)
    endif

    return mode_label
endfunction

function! LightlineGitBranchStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    if g:lightline_show_git_branch && s:CurrentWinWidth() >= s:small_window_width
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

    return s:FileInfoStatus(compact)
endfunction

function! LightlineLineInfoStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

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
        return get(l:mode, 'buffer', '')
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

    return s:InactiveFileNameStatus()
endfunction

function! LightlineTabNum(n) abort
    " if s:has_devicons
    "     return printf('%d %s', a:n,  s:separators.tabline_subseparator.left)
    " endif
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

" Plugin Integration

let s:lightline_time_threshold = 0.50
let s:lightline_last_finding_branch_time = reltime()

function! s:CustomMode() abort
    let fname = expand('%:t')

    if has_key(s:filename_modes, fname)
        let result = {
                    \ 'name': s:filename_modes[fname],
                    \ 'type': 'name',
                    \ }

        if fname ==# 'ControlP'
            return extend(result, s:GetCtrlPMode())
        endif

        if fname ==# '__Tagbar__'
            return extend(result, s:GetTagbarMode())
        endif

        if fname ==# '__CtrlSF__'
            return extend(result, s:GetCtrlSFMode())
        endif

        if fname ==# '__CtrlSFPreview__'
            return extend(result, s:GetCtrlSFPreviewMode())
        endif

        return result
    endif

    if fname =~? '^NrrwRgn'
        let nrrw_rgn_mode = s:GetNrrwRgnMode()
        if len(nrrw_rgn_mode)
            return nrrw_rgn_mode
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

        if ft ==# 'netrw'
            return extend(result, s:GetNetrwMode())
        endif

        if ft ==# 'molder'
            return extend(result, s:GetMolderMode())
        endif

        if ft ==# 'neo-tree'
            return extend(result, s:GetNeoTreeMode())
        endif

        if ft ==# 'oil'
            return extend(result, s:GetOilMode())
        endif

        if ft ==# 'carbon.explorer'
            return extend(result, s:GetCarbonMode())
        endif

        if ft ==# 'fern'
            return extend(result, s:GetFernMode())
        endif

        if ft ==# 'vaffle'
            return extend(result, s:GetVaffleMode())
        endif

        if ft ==# 'dirvish'
            return extend(result, s:GetDirvishMode())
        endif

        if ft ==# 'tagbar'
            return extend(result, s:GetTagbarMode())
        endif

        if ft ==# 'vista_kind' || ft ==# 'vista'
            return extend(result, lightline_settings#VistaMode())
        endif

        if ft ==# 'terminal'
            return extend(result, {
                        \ 'plugin': expand('%'),
                        \ })
        endif

        if ft ==# 'help'
            let fname = expand('%:p')
            return extend(result, {
                        \ 'plugin': fname,
                        \ 'plugin_inactive': fname,
                        \ })
        endif

        if ft ==# 'qf'
            if getwininfo(win_getid())[0]['loclist']
                let result['name'] = 'Location'
            endif
            let qf_title = s:Strip(get(w:, 'quickfix_title', ''))
            return extend(result, {
                        \ 'plugin': qf_title,
                        \ 'plugin_inactive': qf_title,
                        \ })
        endif

        return result
    endif

    return {}
endfunction


" CtrlP Integration
let g:ctrlp_status_func = {
            \ 'main': 'CtrlPMainStatusLine',
            \ 'prog': 'CtrlPProgressStatusLine',
            \ }

function! s:GetCtrlPMode() abort
    let result = {
                \ 'name': s:filename_modes['ControlP'],
                \ 'plugin_extra': g:lightline.ctrlp_dir,
                \ 'type': 'ctrlp',
                \ }

    if g:lightline.ctrlp_main
        let plugin_status = lightline#concatenate([
                    \ g:lightline.ctrlp_prev,
                    \ s:Wrap(g:lightline.ctrlp_item),
                    \ g:lightline.ctrlp_next,
                    \ ], 0)

        let buffer_status = lightline#concatenate([
                    \ g:lightline.ctrlp_focus,
                    \ g:lightline.ctrlp_byfname,
                    \ ], 1)

        call extend(result, {
                    \ 'link': 'nR'[g:lightline.ctrlp_regex],
                    \ 'plugin': plugin_status,
                    \ 'buffer': buffer_status,
                    \ })
    else
        call extend(result, {
                    \ 'plugin': g:lightline.ctrlp_len,
                    \ })
    endif

    return result
endfunction

function! CtrlPMainStatusLine(focus, byfname, regex, prev, item, next, marked) abort
    let g:lightline.ctrlp_main    = 1
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
    let g:lightline.ctrlp_main = 0
    let g:lightline.ctrlp_len  = a:len
    let g:lightline.ctrlp_dir  = s:GetCurrentDir()

    return lightline#statusline(0)
endfunction

" Netrw Integration
function! s:GetNetrwMode(...) abort
    let result = {
                \ 'plugin_extra': printf('%s [%s]', get(g:, 'netrw_sort_by', ''), get(g:, 'netrw_sort_direction', 'n') =~ 'n' ? '+' : '-'),
                \ }

    if exists('b:netrw_curdir')
        let result['plugin'] = fnamemodify(b:netrw_curdir, ':p:~:.:h')
    endif

    return result
endfunction

" vim-molder Integration
function! s:GetMolderMode(...) abort
    let result = {}

    if exists('b:molder_dir')
        let result['plugin'] = fnamemodify(b:molder_dir, ':p:~:.:h')
    endif

    return result
endfunction

" NeoTree Integration
function! s:GetNeoTreeMode(...) abort
    let result = {}

    if exists('b:neo_tree_source')
        let result['plugin'] = b:neo_tree_source
    endif

    return result
endfunction

" oil.nvim Integration
function! s:GetOilMode(...) abort
    let result = {}

    let l:oil_dir = expand('%')
    if l:oil_dir =~# '^oil://'
        let l:oil_dir = substitute(l:oil_dir, '^oil://', '', '')
        let result['plugin'] = fnamemodify(l:oil_dir, ':p:~:.:h')
    endif

    " if exists('b:oil_ready') && b:oil_ready
    "     let result['plugin'] = fnamemodify(luaeval('require("oil").get_current_dir()'), ':p:~:.:h')
    " endif

    return result
endfunction

" Carbon Integration
function! s:GetCarbonMode(...) abort
    let result = {}

    if exists('b:carbon')
        let result['plugin'] = fnamemodify(b:carbon['path'], ':p:~:.:h')
    endif

    return result
endfunction

" Fern Integration
function! s:GetFernMode(...) abort
    let result = {}

    let fern_name = get(a:, 1, expand('%'))
    let pattern = '^fern://\(.\+\)/file://\(.\+\)\$'
    let data = matchlist(fern_name, pattern)

    if len(data)
        let fern_mode = get(data, 1, '')
        if match(fern_mode, 'drawer') > -1
            let result['name'] = 'Drawer'
        endif

        let fern_folder = get(data, 2, '')
        let fern_folder = substitute(fern_folder, ';\?\(#.\+\)\?\$\?$', '', '')
        let fern_folder = fnamemodify(fern_folder, ':p:~:.:h')

        let result['plugin'] = fern_folder
    endif

    return result
endfunction

" Vaffle Integration
function! s:GetVaffleMode(...) abort
    let result = {}

    let vaffle_name = get(a:, 1, expand('%'))
    let pattern = '^vaffle://\(\d\+\)/\(.\+\)$'
    let data = matchlist(vaffle_name, pattern)

    let vaffle_folder = get(data, 2, '')
    if strlen(vaffle_folder)
        let result['plugin'] = fnamemodify(vaffle_folder, ':p:~:h')
    endif

    return result
endfunction

" Dirvish Integration
function! s:GetDirvishMode(...) abort
    return { 'plugin': expand('%:p:h') }
endfunction

" CtrlSF Integration
function! s:GetCtrlSFMode() abort
    let pattern = substitute(ctrlsf#utils#SectionB(), 'Pattern: ', '', '')

    let plugin_status = lightline#concatenate([
                \ pattern,
                \ ctrlsf#utils#SectionC(),
                \ ], 0)

    return {
                \ 'plugin': plugin_status,
                \ 'plugin_inactive': pattern,
                \ 'plugin_extra': ctrlsf#utils#SectionX(),
                \ }
endfunction

function! s:GetCtrlSFPreviewMode() abort
    let stl = ctrlsf#utils#PreviewSectionC()
    return {
                \ 'plugin': stl,
                \ 'plugin_inactive': stl,
                \ }
endfunction

" NrrwRgn Integration
function! s:GetNrrwRgnMode(...) abort
    let result = {}

    if exists(':WidenRegion') == 2
        let result['type'] = 'nrrwrgn'

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
                \ 'name': s:filetype_modes['tagbar'],
                \ 'plugin': plugin_status,
                \ 'type': 'tagbar',
                \ }
endfunction

function! TagbarStatusFunc(current, sort, fname, flags, ...) abort
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
    if exists('*lightline#update')
        call lightline#update()
    endif
endfunction

let g:ZoomWin_funcref= function('ZoomWinStatusLine')

let &cpo = s:save_cpo
unlet s:save_cpo
