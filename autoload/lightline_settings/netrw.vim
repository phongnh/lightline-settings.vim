function! lightline_settings#netrw#Mode(...) abort
    return {
                \ 'plugin': exists('b:netrw_curdir') ? fnamemodify(b:netrw_curdir, ':p:~:.:h') : '',
                \ 'buffer': get(g:, 'netrw_sort_by', ''),
                \ 'settings': get(g:, 'netrw_sort_direction', 'n') =~ 'n' ? '[+]' : '[-]',
                \ }
endfunction
