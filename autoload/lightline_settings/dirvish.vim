" https://github.com/justinmk/vim-dirvish
function! lightline_settings#dirvish#Mode(...) abort
    return { 'plugin': expand('%:p:~:h') }
endfunction
