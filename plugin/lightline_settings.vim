" lightline_settings.vim
" Maintainer: Phong Nguyen
" Version:    1.0.0

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
            \ 'compact': 80,
            \ 'default': 100,
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
            \       ['section_a'],
            \       ['section_b'],
            \       ['section_c'],
            \   ],
            \   'right': [
            \       ['section_z'],
            \       ['section_y'],
            \       ['section_x'],
            \   ]
            \ },
            \ 'inactive': {
            \   'left':  [['inactive_section_a']],
            \   'right': []
            \ },
            \ 'component': {
            \   'tablabel':    'Tabs',
            \   'bufferlabel': 'Buffers',
            \ },
            \ 'component_function': {
            \   'section_a':          'lightline_settings#sections#SectionA',
            \   'section_b':          'lightline_settings#sections#SectionB',
            \   'section_c':          'lightline_settings#sections#SectionC',
            \   'section_x':          'lightline_settings#sections#SectionX',
            \   'section_y':          'lightline_settings#sections#SectionY',
            \   'section_z':          'lightline_settings#sections#SectionZ',
            \   'inactive_section_a': 'lightline_settings#sections#InactiveSectionA',
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

" Throttle buffer count updates to avoid expensive operations on every event
let s:last_buffer_update = []
let s:buffer_update_interval = 100  " milliseconds

function! s:UpdateBufferCount() abort
    " Throttle updates - only run if enough time has passed
    let l:now = reltime()
    if !empty(s:last_buffer_update) && reltimefloat(reltime(s:last_buffer_update)) * 1000 < s:buffer_update_interval
        return
    endif
    let s:last_buffer_update = l:now

    let g:lightline_buffer_count_by_basename = {}
    let l:bufnrs = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufexists(v:val) && !empty(bufname(v:val))')
    for l:name in map(l:bufnrs, 'expand("#" .. v:val .. ":t")')
        if !empty(l:name)
            let g:lightline_buffer_count_by_basename[l:name] = get(g:lightline_buffer_count_by_basename, l:name, 0) + 1
        endif
    endfor
endfunction

function! s:init() abort
    setglobal noshowmode laststatus=2

    " Disable Vim Quickfix's statusline
    let g:qf_disable_statusline = 1

    " Disable NERDTree statusline
    let g:NERDTreeStatusline = -1

    " CtrlP Integration
    if exists(':CtrlP') == 2
        let g:ctrlp_status_func = {
                    \ 'main': 'lightline_settings#ctrlp#MainStatus',
                    \ 'prog': 'lightline_settings#ctrlp#ProgressStatus',
                    \ }
    endif

    " Tagbar Integration
    if exists(':Tagbar') == 2
        let g:tagbar_status_func = 'lightline_settings#tagbar#Status'
    endif

    if exists(':ZoomWin') == 2
        let g:lightline_zoomwin_funcref = []

        if exists('g:ZoomWin_funcref')
            if type(g:ZoomWin_funcref) == v:t_func
                let g:lightline_zoomwin_funcref = [g:ZoomWin_funcref]
            elseif type(g:ZoomWin_funcref) == v:t_list
                let g:lightline_zoomwin_funcref = g:ZoomWin_funcref
            endif
        endif

        let g:ZoomWin_funcref = function('lightline_settings#zoomwin#Status')
    endif

    call lightline_settings#theme#Detect()
endfunction

augroup LightlineSettings
    autocmd!
    autocmd CmdwinEnter * set filetype=cmdline syntax=vim
    " Only update on BufAdd/BufDelete for better performance
    autocmd BufAdd,BufDelete,BufFilePost * call s:UpdateBufferCount()
    autocmd ColorScheme * call lightline_settings#theme#Apply()
    autocmd OptionSet background call lightline_settings#theme#Apply()
    if v:vim_did_enter
        call s:init()
    else
        autocmd VimEnter * ++once call s:init()
    endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
