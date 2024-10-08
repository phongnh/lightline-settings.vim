" https://github.com/lambdalisue/fern.vim
function! lightline_settings#fern#Mode(...) abort
    let result = {}

    let bufname = get(a:, 1, expand('%'))
    let data = matchlist(bufname, '^fern://\(.\+\)/file://\(.\+\)\$')

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
