function! lightline_settings#cmdline#Mode(...) abort
    return {
                \ 'section_a':   'Command Line',
                \ 'section_b': lightline#concatenate([
                \   '<C-C>: edit',
                \   '<CR>: execute',
                \ ], 0),
                \ 'section_x': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
