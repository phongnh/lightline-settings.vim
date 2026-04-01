" https://github.com/justinmk/vim-dirvish
function! lightline_settings#dirvish#Statusline(...) abort
    return { 'section_a': 'Dirvish', 'section_c': expand('%:p:~:.:h') }
endfunction
