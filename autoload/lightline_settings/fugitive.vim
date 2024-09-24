" https://github.com/tpope/vim-fugitive
function! lightline_settings#fugitive#Mode(...) abort
    return {
                \ 'plugin': lightline_settings#git#Branch(),
                \ 'filename': exists('b:fugitive_type') ? b:fugitive_type : '',
                \ }
endfunction
