" https://github.com/mbbill/undotree
function! lightline_settings#undotree#Mode(...) abort
    return {
                \ 'section_a': 'Undo',
                \ 'section_b': exists('t:undotree') ? t:undotree.GetStatusLine() : '',
                \ }
endfunction
