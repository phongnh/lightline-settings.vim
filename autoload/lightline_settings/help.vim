function! lightline_settings#help#Mode(...) abort
    return {
                \ 'section_a': 'HELP',
                \ 'section_c': expand('%:~:.'),
                \ 'section_x': lightline_settings#lineinfo#Full(),
                \ }
endfunction
