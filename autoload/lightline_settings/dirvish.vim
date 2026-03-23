" https://github.com/justinmk/vim-dirvish
function! lightline_settings#dirvish#Mode(...) abort
    return { 'section_a': 'Dirvish', 'section_b': expand('%:p:~:.:h') }
endfunction
