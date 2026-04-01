" https://github.com/junegunn/gv.vim
function! lightline_settings#gv#Mode(...) abort
    return {
                \ 'section_a': 'GV',
                \ 'section_b': lightline#concatenate([
                \   'o: open split',
                \   'O: open tab',
                \   'gb: GBrowse',
                \   'q: quit',
                \ ], 0),
                \ 'section_x': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
