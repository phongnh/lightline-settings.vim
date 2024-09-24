" https://github.com/mbbill/undotree
function! lightline_settings#undotree#Mode(...) abort
    return {
                \ 'name': 'Undo',
                \ 'plugin': exists('t:undotree') ? t:undotree.GetStatusLine() : '',
                \ }
endfunction

function! lightline_settings#undotree#DiffStatus(...) abort
    return {
                \ 'name': 'Diff',
                \ 'plugin': exists('t:diffpanel') ? t:diffpanel.GetStatusLine() : '',
                \ }
endfunction
