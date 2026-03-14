function! lightline_settings#diff#Mode(...) abort
    let l:result = { 'name': 'Diff' }
    let l:bufname = expand('%:t')
    if exists('t:diffpanel') && t:diffpanel.bufname ==# l:bufname
        " https://github.com/mbbill/undotree
        let l:result['plugin'] = t:diffpanel.GetStatusLine()
    elseif l:bufname ==# '__Gundo_Preview__'
        " https://github.com/sjl/gundo.vim
        let l:result['name'] = 'Gundo Preview'
    endif
    return l:result
endfunction
