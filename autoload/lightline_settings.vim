function! lightline_settings#Trim(str) abort
    return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

if exists('*trim')
    function! lightline_settings#Trim(str) abort
        return trim(a:str)
    endfunction
endif

function! lightline_settings#ShortenPath(filename) abort
    return substitute(a:filename, '\v\w\zs.{-}\ze(\\|/)', '', 'g')
endfunction

if exists('*pathshorten')
    function! lightline_settings#ShortenPath(filename) abort
        return pathshorten(a:filename)
    endfunction
endif

function! lightline_settings#FormatFileName(fname, ...) abort
    let l:path = a:fname
    let l:maxlen = get(a:, 1, 50)

    if winwidth(0) <= g:lightline_winwidth_config.compact
        return fnamemodify(l:path, ':t')
    endif

    if strlen(l:path) > l:maxlen && g:lightline_shorten_path
        let l:path = lightline_settings#ShortenPath(l:path)
    endif

    if strlen(l:path) > l:maxlen
        let l:path = fnamemodify(l:path, ':t')
    endif

    return l:path
endfunction

function! lightline_settings#ReloadLightline() abort
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

function! lightline_settings#Setup() abort
    " Disable NERDTree statusline
    let g:NERDTreeStatusline = -1

    " Settings
    let g:lightline_powerline_fonts = get(g:, 'lightline_powerline_fonts', 0)
    let g:lightline_shorten_path    = get(g:, 'lightline_shorten_path', 0)
    let g:lightline_show_short_mode = get(g:, 'lightline_show_short_mode', 0)
    let g:lightline_show_linenr     = get(g:, 'lightline_show_linenr', 0)
    let g:lightline_show_git_branch = get(g:, 'lightline_show_git_branch', 0)
    let g:lightline_show_devicons   = get(g:, 'lightline_show_devicons', 0) && lightline_settings#devicons#Detect()

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

    let g:lightline_theme_mappings = extend({
                \ '^\(solarized\|soluarized\|flattened\)': 'solarized',
                \ '^gruvbox$': 'gruvbox_material',
                \ '^gruvbox': 'gruvbox8',
                \ }, get(g:, 'lightline_theme_mappings', {}))

    " Window width
    let g:lightline_winwidth_config = extend({
                \ 'compact': 60,
                \ 'default': 90,
                \ 'normal':  120,
                \ }, get(g:, 'lightline_winwidth_config', {}))

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

    let g:lightline = {
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

    if g:lightline_show_short_mode
        let g:lightline.mode_map = copy(g:lightline_short_mode_map)
    endif

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
    endif

    if g:lightline_show_devicons
        " Show Vim Logo in Tabline
        let g:lightline.component.tablabel    = "\ue7c5 "
        let g:lightline.component.bufferlabel = "\ue7c5 "
    endif

    if get(g:, 'lightline_bufferline', 0)
        call lightline_settings#bufferline#Init()
    endif

    let g:lightline_buffer_count_by_basename = {}

    " Alternate status dictionaries
    let g:lightline_filename_modes = {
                \ 'ControlP':             'CtrlP',
                \ '__CtrlSF__':           'CtrlSF',
                \ '__CtrlSFPreview__':    'Preview',
                \ '__flygrep__':          'FlyGrep',
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
                \ 'SpaceVimFlyGrep':   'FlyGrep',
                \ }

    let g:lightline_filename_integrations = {
                \ 'ControlP':          'lightline_settings#ctrlp#Mode',
                \ '__CtrlSF__':        'lightline_settings#ctrlsf#Mode',
                \ '__CtrlSFPreview__': 'lightline_settings#ctrlsf#PreviewMode',
                \ '__flygrep__':       'lightline_settings#flygrep#Mode',
                \ '__Tagbar__':        'lightline_settings#tagbar#Mode',
                \ }

    let g:lightline_filetype_integrations = {
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
                \ 'SpaceVimFlyGrep': 'lightline_settings#flygrep#Mode',
                \ }
endfunction

" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
function! lightline_settings#Init() abort
    setglobal noshowmode

    call lightline_settings#parts#Init()
    call lightline_settings#theme#Init()

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

    " ZoomWin Integration
    if exists(':ZoomWin') == 2
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
    endif

    function! s:UpdateBufferCount() abort
        let g:lightline_buffer_count_by_basename = {}
        let bufnrs = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufexists(v:val) && len(bufname(v:val))')
        for name in map(bufnrs, 'expand("#" . v:val . ":t")')
            if name !=# ''
                let g:lightline_buffer_count_by_basename[name] = get(g:lightline_buffer_count_by_basename, name) + 1
            endif
        endfor
    endfunction

    augroup LightlineSettingsBufferCount
        autocmd!
        autocmd BufEnter,WinEnter,WinLeave * call s:UpdateBufferCount()
    augroup END
endfunction
