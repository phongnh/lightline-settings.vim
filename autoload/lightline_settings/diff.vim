function! lightline_settings#diff#Mode(...) abort
    let l:result = { 'name': 'Diff' }
    if exists('t:diffpanel')
        " https://github.com/mbbill/undotree
        let l:result['plugin'] = t:diffpanel.GetStatusLine()
    elseif expand('%:t') ==# '__Gundo_Preview__'
        " https://github.com/sjl/gundo.vim
        let l:result['name'] = 'Gundo Preview'
    endif
    return l:result
endfunction
