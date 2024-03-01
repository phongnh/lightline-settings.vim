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

function! lightline_settings#IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! lightline_settings#IsCompact() abort
    return winwidth(0) <= g:lightline_winwidth_config.compact || count([lightline_settings#IsClipboardEnabled(), &paste, &spell], 1) > 1
endfunction

function! lightline_settings#BufferType() abort
    return strlen(&filetype) ? &filetype : &buftype
endfunction

function! lightline_settings#FileName() abort
    let fname = expand('%')
    return strlen(fname) ? fnamemodify(fname, ':~:.') : '[No Name]'
endfunction

function! lightline_settings#Reload() abort
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
function! lightline_settings#Init() abort
    setglobal noshowmode

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

    augroup LightlineSettingsBufferCount
        autocmd!
        autocmd BufEnter,WinEnter,WinLeave * call s:UpdateBufferCount()
    augroup END
endfunction
