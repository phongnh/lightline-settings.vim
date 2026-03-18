" https://github.com/preservim/nerdtree
function! lightline_settings#nerdtree#Mode(...) abort
    return {
                \ 'name': 'NERDTree',
                \ 'plugin': exists('b:NERDTree') ? fnamemodify(b:NERDTree.root.path.str(), ':p:~:.:h') : '',
                \ }
endfunction
