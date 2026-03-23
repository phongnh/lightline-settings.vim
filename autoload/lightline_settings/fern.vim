" https://github.com/lambdalisue/fern.vim
function! lightline_settings#fern#Mode(...) abort
    let l:bufname = get(a:, 1, expand('%'))
    let l:data = matchlist(l:bufname, '^fern://\(.\+\)/file://\(.\+\)\$')

    if empty(l:data)
        return { 'section_a': 'Fern' }
    endif

    let l:name = get(l:data, 1, '')
    let l:name = stridx(l:name, 'drawer') > -1 ? 'Drawer' : 'Fern'

    let l:folder = get(l:data, 2, '')
    let l:folder = substitute(l:folder, ';\?\(#.\+\)\?\$\?$', '', '')
    let l:folder = fnamemodify(l:folder, ':p:~:.:h')

    return { 'section_a': l:name, 'section_c': l:folder }
endfunction
