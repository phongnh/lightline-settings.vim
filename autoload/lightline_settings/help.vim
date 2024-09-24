function! lightline_settings#help#Mode(...) abort
    return {
                \ 'name': 'HELP',
                \ 'plugin': expand('%:~:.'),
                \ 'info': lightline_settings#lineinfo#Full(),
                \ }
endfunction
