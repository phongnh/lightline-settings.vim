" https://github.com/cocopon/vaffle.vim
function! lightline_settings#vaffle#Mode(...) abort
    let l:bufname = get(a:, 1, expand('%'))
    let l:dir = get(matchlist(l:bufname, '^vaffle://\(\d\+\)/\(.\+\)$'), 2, '')
    return { 'name': 'Vaffle', 'plugin': !empty(l:dir) ? fnamemodify(l:dir, ':p:~:.:h') : '' }
endfunction
