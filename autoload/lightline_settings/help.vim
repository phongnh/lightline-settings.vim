function! lightline_settings#help#Mode(...) abort
    return { 'name': 'HELP', 'plugin': expand('%:p') }
endfunction
