" https://github.com/preservim/nerdtree
function! lightline_settings#nerdtree#Mode(...) abort
    return {
                \ 'section_a': 'NERDTree',
                \ 'section_b': exists('b:NERDTree') ? fnamemodify(b:NERDTree.root.path.str(), ':p:~:.:h') : '',
                \ }
endfunction
