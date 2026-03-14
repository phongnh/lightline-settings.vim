" https://github.com/mhinz/vim-grepper
function! lightline_settings#grepper#Mode(...) abort
    let l:result = { 'name': 'GrepperSide' }
    if exists('b:grepper_side_statusline')
        let l:result['plugin'] = b:grepper_side_statusline
    endif
    return l:result
endfunction
