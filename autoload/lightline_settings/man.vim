function! lightline_settings#man#Statusline(...) abort
    return {
                \ 'section_a': 'MAN',
                \ 'section_b': expand('%:t'),
                \ 'section_x': lightline_settings#lineinfo#Full(),
                \ }
endfunction
