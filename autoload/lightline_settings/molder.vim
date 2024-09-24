" https://github.com/mattn/vim-molder
function! lightline_settings#molder#Mode(...) abort
    return { 'plugin': exists('b:molder_dir') ? fnamemodify(b:molder_dir, ':p:~:.:h') : '' }
endfunction
