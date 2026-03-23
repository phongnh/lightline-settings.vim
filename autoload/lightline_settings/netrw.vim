function! lightline_settings#netrw#Mode(...) abort
    return {
                \ 'name': 'Netrw',
                \ 'plugin': exists('b:netrw_curdir') ? fnamemodify(b:netrw_curdir, ':p:~:.:h') : '',
                \ 'buffer': printf('%s:%s', g:netrw_sort_by, get(g:, 'netrw_sort_direction', 'n') =~# 'n' ? '+' : '-'),
                \ }
endfunction
