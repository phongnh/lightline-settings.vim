function! lightline_settings#terminal#Mode(...) abort
    return { 'section_a': 'TERMINAL', 'section_c': expand('%') }
endfunction
