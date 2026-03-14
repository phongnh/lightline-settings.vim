function! lightline_settings#cmdline#Mode(...) abort
    return {
                \ 'name':   'Command Line',
                \ 'plugin': lightline#concatenate(
                \   [
                \       '<C-C>: edit',
                \       'CR: execute',
                \   ],
                \   0
                \ ),
                \ 'info': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
