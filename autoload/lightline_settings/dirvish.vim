function! lightline_settings#dirvish#Mode(...) abort
    return { 'plugin': expand('%:p:~:h') }
endfunction
