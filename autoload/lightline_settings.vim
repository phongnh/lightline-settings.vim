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

function! lightline_settings#Init() abort
    setglobal noshowmode laststatus=2

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
            elseif type(g:ZoomWin_funcref) == v:t_func
                let g:lightline_zoomwin_funcref = g:ZoomWin_funcref
            endif
            let g:lightline_zoomwin_funcref = uniq(copy(g:lightline_zoomwin_funcref))
        endif

        let g:ZoomWin_funcref = function('lightline_settings#zoomwin#Status')
    endif
endfunction
