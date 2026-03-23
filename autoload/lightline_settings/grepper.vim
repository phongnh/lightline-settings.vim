" https://github.com/mhinz/vim-grepper
function! s:GrepperSideStatus() abort
    if exists('b:grepper_side_statusline')
        return b:grepper_side_statusline
    endif
    if !empty(b:grepper_side_status)
        return printf(
                    \ 'Found %d %s in %d %s.',
                    \ b:grepper_side_status.matches,
                    \ b:grepper_side_status.matches == 1 ? 'match' : 'matches',
                    \ b:grepper_side_status.files,
                    \ b:grepper_side_status.files == 1 ? 'file' : 'files'
                    \ )
    endif
    return ''
endfunction

function! lightline_settings#grepper#Mode(...) abort
    return { 'name': 'GrepperSide', 'plugin': s:GrepperSideStatus() }
endfunction
