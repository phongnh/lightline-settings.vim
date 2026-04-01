function! lightline_settings#terminal#Statusline(...) abort
    return { 'section_a': 'TERMINAL', 'section_c': expand('%') }
endfunction
