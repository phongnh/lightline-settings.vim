" https://github.com/cocopon/vaffle.vim
function! lightline_settings#vaffle#Mode(...) abort
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
