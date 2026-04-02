function! lightline_settings#diff#Statusline(...) abort
    let l:result = { 'section_a': 'Diff' }
    let l:bufname = expand('%:t')
    if exists('t:diffpanel') && t:diffpanel.bufname ==# l:bufname
        " https://github.com/mbbill/undotree
        let l:result['section_b'] = t:diffpanel.GetStatusLine()
    elseif l:bufname ==# '__Gundo_Preview__'
        " https://github.com/sjl/gundo.vim
        let l:result['section_a'] = 'Gundo Preview'
    endif
    return l:result
endfunction
