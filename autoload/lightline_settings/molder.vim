" https://github.com/mattn/vim-molder
function! lightline_settings#molder#Statusline(...) abort
    return { 'section_a': 'Molder', 'section_c': exists('b:molder_dir') ? fnamemodify(b:molder_dir, ':p:~:.:h') : '' }
endfunction
