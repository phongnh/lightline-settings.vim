" https://github.com/junegunn/gv.vim
function! lightline_settings#gv#Mode(...) abort
    return {
                \ 'plugin': lightline#concatenate(
                \   [
                \       'o: open split',
                \       'O: open tab',
                \       'gb: GBrowse',
                \       'q: quit',
                \   ],
                \   0
                \ ),
                \ 'info': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
