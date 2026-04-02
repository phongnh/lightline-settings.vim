function! lightline_settings#help#Statusline(...) abort
    return {
                \ 'section_a': 'HELP',
                \ 'section_c': expand('%:~:.'),
                \ 'section_x': lightline_settings#components#Ruler(),
                \ }
endfunction
