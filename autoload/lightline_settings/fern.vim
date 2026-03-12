" https://github.com/lambdalisue/fern.vim
function! lightline_settings#fern#Mode(...) abort
    let l:result = {}

    let l:bufname = get(a:, 1, expand('%'))
    let l:data = matchlist(l:bufname, '^fern://\(.\+\)/file://\(.\+\)\$')

    if len(l:data)
        let l:fern_mode = get(l:data, 1, '')
        if match(l:fern_mode, 'drawer') > -1
            let l:result['name'] = 'Drawer'
        endif

        let l:fern_folder = get(l:data, 2, '')
        let l:fern_folder = substitute(l:fern_folder, ';\?\(#.\+\)\?\$\?$', '', '')
        let l:fern_folder = fnamemodify(l:fern_folder, ':p:~:.:h')

        let l:result['plugin'] = l:fern_folder
    endif

    return l:result
endfunction
