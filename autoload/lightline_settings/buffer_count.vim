" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
let g:lightline_buffer_count_by_basename = {}

" Throttle buffer count updates to avoid expensive operations on every event
let s:last_buffer_update = []
let s:buffer_update_interval = 100  " milliseconds

function! lightline_settings#buffer_count#Update() abort
    " Throttle updates - only run if enough time has passed
    let l:now = reltime()
    if !empty(s:last_buffer_update) && reltimefloat(reltime(s:last_buffer_update)) * 1000 < s:buffer_update_interval
        return
    endif
    let s:last_buffer_update = l:now

    let g:lightline_buffer_count_by_basename = {}
    let l:bufnrs = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufexists(v:val) && !empty(bufname(v:val))')
    for l:name in map(l:bufnrs, 'expand("#" .. v:val .. ":t")')
        if !empty(l:name)
            let g:lightline_buffer_count_by_basename[l:name] = get(g:lightline_buffer_count_by_basename, l:name, 0) + 1
        endif
    endfor
endfunction
