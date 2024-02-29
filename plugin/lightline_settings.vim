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
let g:lightline_powerline_fonts = get(g:, 'lightline_powerline_fonts', 0)
let g:lightline_theme           = get(g:, 'lightline_theme', 'solarized')
let g:lightline_shorten_path    = get(g:, 'lightline_shorten_path', 0)
let g:lightline_show_git_branch = get(g:, 'lightline_show_git_branch', 1)
let g:lightline_show_devicons   = get(g:, 'lightline_show_devicons', 1)
let g:lightline_show_vim_logo   = get(g:, 'lightline_show_vim_logo', 1)

" Window width
let g:lightline_winwidth_config = extend({
            \ 'xsmall': 60,
            \ 'small':  80,
            \ 'normal': 120,
            \ }, get(g:, 'lightline_winwidth_config', {}))

" Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
let g:lightline_symbols = {
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
            \   'right': [],
            \ },
            \ 'tab': {
            \   'active':   ['tabname', 'modified'],
            \   'inactive': ['tabname', 'modified'],
            \ },
            \ 'active': {
            \   'left':  [
            \       ['mode'],
            \       ['plugin'] + (get(g:, 'lightline_show_git_branch', 0) ? ['branch'] : []) + ['filename'],
            \   ],
            \   'right': [
            \       ['fileinfo'] + (get(g:, 'lightline_show_linenr', 0) ? ['lineinfo'] : []) + ['plugin_extra'],
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
            \   'fileinfo':     'LightlineFileInfoStatus',
            \   'lineinfo':     'LightlineLineInfoStatus',
            \   'plugin_extra': 'LightlinePluginExtraStatus',
            \   'buffer':       'LightlineBufferStatus',
            \   'inactive':     'LightlineInactiveStatus',
            \ },
            \ 'tab_component_function': {
            \   'tabname': 'lightline_settings#tab#Name',
            \ },
            \ }

if g:lightline_powerline_fonts
    call extend(g:lightline_symbols, {
                \ 'linenr':   "\ue0a1",
                \ 'branch':   "\ue0a0",
                \ 'readonly': "\ue0a2",
                \ })

    call lightline_settings#powerline#SetSeparators(get(g:, 'lightline_powerline_style', 'default'))
endif

let s:lightline_show_devicons = g:lightline_show_devicons && lightline_settings#devicons#Detect()

if g:lightline_show_vim_logo && s:lightline_show_devicons
    " Show Vim Logo in Tabline
    let g:lightline.component.tablabel    = "\ue7c5" . ' '
    let g:lightline.component.bufferlabel = "\ue7c5" . ' '
endif

if get(g:, 'lightline_bufferline', 0)
    call lightline_settings#bufferline#Init()
endif

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

let s:lightline_shorter_modes = {
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

function! s:FileNameStatus() abort
    return lightline_settings#parts#Readonly() . lightline_settings#FormatFileName(s:GetFileName()) . lightline_settings#parts#Modified()
endfunction

function! s:InactiveFileNameStatus() abort
    return lightline_settings#parts#Readonly() . s:GetFileName() . lightline_settings#parts#Modified()
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

    if s:lightline_show_devicons
        call add(parts, lightline_settings#devicons#FileType(expand('%')) . ' ')
    endif

    return join(filter(copy(parts), '!empty(v:val)'), ' ')
endfunction

function! LightlineModeStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return l:mode['name']
    endif

    let mode_label = lightline#mode()
    if winwidth(0) <= g:lightline_winwidth_config.xsmall
        return get(s:lightline_shorter_modes, mode_label, mode_label)
    endif

    return mode_label
endfunction

function! LightlineGitBranchStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return ''
    endif

    if winwidth(0) >= g:lightline_winwidth_config.small
        let branch = lightline_settings#git#Branch()
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

    let compact = lightline_settings#IsCompact()

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

function! LightlineBufferStatus() abort
    let l:mode = s:CustomMode()
    if len(l:mode)
        return get(l:mode, 'buffer', '')
    endif

    if winwidth(0) >= g:lightline_winwidth_config.small
        return lightline#concatenate([
                    \ lightline_settings#parts#Spell(),
                    \ lightline_settings#parts#Paste(),
                    \ lightline_settings#parts#Clipboard(),
                    \ lightline_settings#parts#Indentation(lightline_settings#IsCompact()),
                    \ ], 1)
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
                        \ [
                        \   l:mode['name'],
                        \   get(l:mode, 'plugin_inactive', '')
                        \ ], 0)
        endif
        return l:mode['name']
    endif

    return s:InactiveFileNameStatus()
endfunction

command! LightlineReload call lightline_settings#Reload()
command! -nargs=1 -complete=custom,lightline_settings#theme#ListColorschemes LightlineTheme call lightline_settings#theme#Set(<f-args>)

augroup lightline_settings
    autocmd!
    autocmd VimEnter * call lightline_settings#Init()
    autocmd VimEnter * call lightline_settings#theme#Reload()
    autocmd ColorScheme * call lightline_settings#theme#Reload()
augroup END

" Plugin Integration
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

function! s:CustomMode() abort
    let fname = expand('%:t')

    if has_key(g:lightline_filename_modes, fname)
        let result = {
                    \ 'name': g:lightline_filename_modes[fname],
                    \ }

        if fname ==# 'ControlP'
            return extend(result, lightline_settings#ctrlp#Mode())
        endif

        if fname ==# '__Tagbar__'
            return extend(result, lightline_settings#tagbar#Mode())
        endif

        if fname ==# '__CtrlSF__'
            return extend(result, lightline_settings#ctrlsf#Mode())
        endif

        if fname ==# '__CtrlSFPreview__'
            return extend(result, lightline_settings#ctrlsf#PreviewMode())
        endif

        return result
    endif

    if fname =~# '^NrrwRgn_\zs.*\ze_\d\+$'
        return lightline_settings#nrrwrgn#Mode()
    endif

    let ft = s:GetBufferType()
    if has_key(g:lightline_filetype_modes, ft)
        let result = {
                    \ 'name': g:lightline_filetype_modes[ft],
                    \ }

        if has_key(g:lightline_plugin_modes, ft)
            return extend(result, function(g:lightline_plugin_modes[ft])())
        endif

        return result
    endif

    return {}
endfunction

" Disable NERDTree statusline
let g:NERDTreeStatusline = -1

" CtrlP Integration
let g:ctrlp_status_func = {
            \ 'main': 'lightline_settings#ctrlp#MainStatus',
            \ 'prog': 'lightline_settings#ctrlp#ProgressStatus',
            \ }

" Tagbar Integration
let g:tagbar_status_func = 'lightline_settings#tagbar#Status'

" ZoomWin Integration
let g:lightline_zoomwin_funcref = []

if exists('g:ZoomWin_funcref')
    if type(g:ZoomWin_funcref) == v:t_func
        let g:lightline_zoomwin_funcref = [g:ZoomWin_funcref]
    elseif type(g:ZoomWin_funcref) == v:t_func
        let g:lightline_zoomwin_funcref = g:ZoomWin_funcref
    endif
    let g:lightline_zoomwin_funcref = uniq(copy(g:lightline_zoomwin_funcref))
endif

let g:ZoomWin_funcref = function('lightline_settings#zoomwin#Status')

let &cpo = s:save_cpo
unlet s:save_cpo
