" https://github.com/mbbill/undotree
function! lightline_settings#undotree#Mode(...) abort
    let result = { 'name': 'Undo' }

    if exists('t:undotree')
        let result['plugin'] = t:undotree.GetStatusLine()
    endif

    return result
endfunction

function! lightline_settings#undotree#DiffStatus(...) abort
    let result = { 'name': 'Diff' }

    if exists('t:diffpanel')
        let result['plugin'] = t:diffpanel.GetStatusLine()
    endif

    return result
endfunction
