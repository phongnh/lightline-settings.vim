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
let g:lightline_show_short_mode = get(g:, 'lightline_show_short_mode', 0)
let g:lightline_show_git_branch = get(g:, 'lightline_show_git_branch', 1)
let g:lightline_show_devicons   = get(g:, 'lightline_show_devicons', 1)
let g:lightline_show_vim_logo   = get(g:, 'lightline_show_vim_logo', 1)

" Short Modes
let g:lightline_short_mode_map = {
            \ 'n':      'N',
            \ 'i':      'I',
            \ 'R':      'R',
            \ 'v':      'V',
            \ 'V':      'V-L',
            \ "\<C-v>": 'V-B',
            \ 'c':      'C',
            \ 's':      'S',
            \ 'S':      'S-L',
            \ "\<C-s>": 'S-B',
            \ 't':      'T',
            \ }

" Window width
let g:lightline_winwidth_config = extend({
            \ 'compact': 60,
            \ 'small':   80,
            \ 'normal':  120,
            \ }, get(g:, 'lightline_winwidth_config', {}))

" Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
let g:lightline_symbols = {
            \ 'linenr':    '☰',
            \ 'branch':    '⎇ ',
            \ 'readonly':  '',
            \ 'clipboard': '🅒 ',
            \ 'paste':     '🅟 ',
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

if g:lightline_show_short_mode
    let g:lightline.mode_map = copy(g:lightline_short_mode_map)
endif

if g:lightline_powerline_fonts
    call extend(g:lightline_symbols, {
                \ 'linenr':   "\ue0a1",
                \ 'branch':   "\ue0a0",
                \ 'readonly': "\ue0a2",
                \ })

    call lightline_settings#powerline#SetSeparators(get(g:, 'lightline_powerline_style', 'default'))
endif

let g:lightline_show_devicons = g:lightline_show_devicons && lightline_settings#devicons#Detect()
if g:lightline_show_devicons && g:lightline_show_vim_logo
    " Show Vim Logo in Tabline
    let g:lightline.component.tablabel    = "\ue7c5" . ' '
    let g:lightline.component.bufferlabel = "\ue7c5" . ' '
endif

if get(g:, 'lightline_bufferline', 0)
    call lightline_settings#bufferline#Init()
endif

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

function! s:FileNameStatus() abort
    return lightline_settings#parts#Readonly() . lightline_settings#FormatFileName(lightline_settings#FileName()) . lightline_settings#parts#Modified()
endfunction

function! s:InactiveFileNameStatus() abort
    return lightline_settings#parts#Readonly() . lightline_settings#FileName() . lightline_settings#parts#Modified()
endfunction

function! LightlineModeStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return l:mode['name']
    endif

    return lightline#concatenate([
                \ lightline_settings#parts#Mode(),
                \ lightline_settings#parts#Clipboard(),
                \ lightline_settings#parts#Paste(),
                \ lightline_settings#parts#Spell(),
                \ ], 0)
endfunction

function! LightlineGitBranchStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    if winwidth(0) >= g:lightline_winwidth_config.small
        let branch = lightline_settings#git#Branch()
    endif

    return ''
endfunction

function! LightlineFileNameStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    return s:FileNameStatus()
endfunction

function! LightlineFileInfoStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    return lightline_settings#parts#FileInfo()
endfunction

function! LightlineLineInfoStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    return lightline_settings#parts#SimpleLineInfo()
endfunction

function! LightlineBufferStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'buffer', '')
    endif

    return lightline_settings#parts#Indentation(lightline_settings#IsCompact())
endfunction

function! LightlinePluginStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        if has_key(l:mode, 'link')
            call lightline#link(l:mode['link'])
        endif
        return get(l:mode, 'plugin', '')
    endif

    return ''
endfunction

function! LightlinePluginExtraStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'plugin_extra', '')
    endif

    return ''
endfunction

function! LightlineInactiveStatus() abort
    let l:mode = lightline_settings#parts#Integration()
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

" Disable NERDTree statusline
let g:NERDTreeStatusline = -1

let &cpo = s:save_cpo
unlet s:save_cpo
