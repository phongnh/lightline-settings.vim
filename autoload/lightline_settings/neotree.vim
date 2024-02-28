function! lightline_settings#neotree#Mode(...) abort
    let result = {}

    if exists('b:neo_tree_source')
        let result['plugin'] = b:neo_tree_source
    endif

    return result
endfunction

