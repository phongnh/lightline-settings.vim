function! lightline_settings#git#Mode(...) abort
    return {
                \ 'section_a': 'Git',
                \ 'section_b': expand('%:t'),
                \ 'section_x': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
