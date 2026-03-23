function! lightline_settings#netrw#Mode(...) abort
    return {
                \ 'section_a': 'Netrw',
                \ 'section_b': exists('b:netrw_curdir') ? fnamemodify(b:netrw_curdir, ':p:~:.:h') : '',
                \ 'section_z': printf('%s:%s', g:netrw_sort_by, get(g:, 'netrw_sort_direction', 'n') =~# 'n' ? '+' : '-'),
                \ }
endfunction
