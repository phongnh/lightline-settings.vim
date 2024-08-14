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
let g:lightline_shorten_path    = get(g:, 'lightline_shorten_path', 0)
let g:lightline_show_short_mode = get(g:, 'lightline_show_short_mode', 0)
let g:lightline_show_linenr     = get(g:, 'lightline_show_linenr', 0)
let g:lightline_show_git_branch = get(g:, 'lightline_show_git_branch', 0)
let g:lightline_show_devicons   = get(g:, 'lightline_show_devicons', 0) && lightline_settings#devicons#Detect()

" Window width
let g:lightline_winwidth_config = extend({
            \ 'compact': 60,
            \ 'default': 90,
            \ 'normal':  120,
            \ }, get(g:, 'lightline_winwidth_config', {}))

" Lightline components
let g:lightline = {
            \ 'colorscheme': 'default',
            \ 'enable': {
            \   'statusline': 1,
            \   'tabline':    1,
            \ },
            \ 'separator': {
            \   'left': '',
            \   'right': '',
            \ },
            \ 'subseparator': {
            \   'left': '|',
            \   'right': '|',
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
            \       (g:lightline_show_git_branch ? ['branch'] : []) + ['plugin'],
            \       ['filename'],
            \   ],
            \   'right': [
            \       ['buffer'],
            \       ['settings'],
            \       g:lightline_show_linenr ? ['info'] : [],
            \   ]
            \ },
            \ 'inactive': {
            \   'left':  [['inactive_mode']],
            \   'right': []
            \ },
            \ 'component': {
            \   'tablabel':    'Tabs',
            \   'bufferlabel': 'Buffers',
            \ },
            \ 'component_function': {
            \   'mode':          'lightline_settings#sections#Mode',
            \   'plugin':        'lightline_settings#sections#Plugin',
            \   'branch':        'lightline_settings#sections#GitBranch',
            \   'filename':      'lightline_settings#sections#FileName',
            \   'buffer':        'lightline_settings#sections#Buffer',
            \   'settings':      'lightline_settings#sections#Settings',
            \   'info':          'lightline_settings#sections#Info',
            \   'inactive_mode': 'lightline_settings#sections#InactiveMode',
            \ },
            \ 'tab_component_function': {
            \   'tabname':  'lightline_settings#tab#Name',
            \   'modified': 'lightline_settings#tab#Modified',
            \ },
            \ }

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

if g:lightline_show_short_mode
    let g:lightline.mode_map = copy(g:lightline_short_mode_map)
endif

" Symbols: https://en.wikipedia.org/wiki/Enclosed_Alphanumerics
let g:lightline_symbols = {
            \ 'dos':       '[dos]',
            \ 'mac':       '[mac]',
            \ 'unix':      '[unix]',
            \ 'linenr':    '☰',
            \ 'branch':    '⎇ ',
            \ 'readonly':  '',
            \ 'bomb':      '🅑 ',
            \ 'noeol':     '∉ ',
            \ 'clipboard': '🅒 ',
            \ 'paste':     '🅟 ',
            \ 'ellipsis':  '…',
            \ }

if g:lightline_powerline_fonts || g:lightline_show_devicons
    call extend(g:lightline_symbols, {
                \ 'linenr':   "\ue0a1",
                \ 'branch':   "\ue0a0",
                \ 'readonly': "\ue0a2",
                \ })

    call lightline_settings#powerline#SetSeparators(get(g:, 'lightline_powerline_style', 'default'))
endif

if g:lightline_show_devicons
    call extend(g:lightline_symbols, {
                \ 'bomb':  "\ue287 ",
                \ 'noeol': "\ue293 ",
                \ 'dos':   "\ue70f",
                \ 'mac':   "\ue711",
                \ 'unix':  "\ue712",
                \ })
    let g:lightline_symbols.unix = '[unix]'
    " Show Vim Logo in Tabline
    let g:lightline.component.tablabel    = "\ue7c5 "
    let g:lightline.component.bufferlabel = "\ue7c5 "
endif

if get(g:, 'lightline_bufferline', 0)
    call lightline_settings#bufferline#Init()
endif

command! LightlineReload call lightline_settings#ReloadLightline()
command! -nargs=1 -complete=custom,lightline_settings#theme#List LightlineTheme call lightline_settings#theme#Set(<f-args>)

" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
let g:lightline_buffer_count_by_basename = {}

function! s:UpdateBufferCount() abort
    let g:lightline_buffer_count_by_basename = {}
    let bufnrs = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufexists(v:val) && len(bufname(v:val))')
    for name in map(bufnrs, 'expand("#" . v:val . ":t")')
        if name !=# ''
            let g:lightline_buffer_count_by_basename[name] = get(g:lightline_buffer_count_by_basename, name) + 1
        endif
    endfor
endfunction

augroup LightlineSettings
    autocmd!
    autocmd VimEnter * call lightline_settings#Init() | call lightline_settings#theme#Detect()
    autocmd ColorScheme * call lightline_settings#theme#Apply()
    autocmd OptionSet background call lightline_settings#theme#Apply()
    autocmd BufEnter,WinEnter,WinLeave * call s:UpdateBufferCount()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
