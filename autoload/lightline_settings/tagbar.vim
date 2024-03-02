" https://github.com/preservim/tagbar
let s:lightline_tagbar = {}

function! lightline_settings#tagbar#Status(current, sort, fname, flags, ...) abort
    let s:lightline_tagbar.sort  = a:sort
    let s:lightline_tagbar.fname = a:fname
    let s:lightline_tagbar.flags = a:flags

    return lightline#statusline(0)
endfunction

function! lightline_settings#tagbar#Mode(...) abort
    if empty(s:lightline_tagbar.flags)
        let flags = ''
    else
        let flags = printf('[%s]', join(s:lightline_tagbar.flags, ''))
    endif

    return {
                \ 'name': s:lightline_tagbar.sort,
                \ 'plugin': lightline#concatenate([s:lightline_tagbar.fname, flags], 0),
                \ }
endfunction
