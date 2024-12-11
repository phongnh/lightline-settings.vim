" https://github.com/mhinz/vim-grepper
function! lightline_settings#grepper#Mode(...) abort
    if exists('b:grepper_side_statusline')
        return { 'plugin': b:grepper_side_statusline }
    endif
    return {}
endfunction
