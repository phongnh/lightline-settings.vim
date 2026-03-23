function! lightline_settings#help#Mode(...) abort
    return {
                \ 'section_a': 'HELP',
                \ 'section_b': expand('%:~:.'),
                \ 'section_x': lightline_settings#lineinfo#Full(),
                \ }
endfunction
