" https://github.com/preservim/tagbar
let s:lightline_tagbar = {}

function! lightline_settings#tagbar#Status(current, sort, fname, flags, ...) abort
    let s:lightline_tagbar.sort  = a:sort
    let s:lightline_tagbar.fname = a:fname
    let s:lightline_tagbar.flags = a:flags

    return lightline#statusline(0)
endfunction

function! lightline_settings#tagbar#Statusline(...) abort
    if empty(s:lightline_tagbar.flags)
        let l:flags = ''
    else
        let l:flags = '[' .. join(s:lightline_tagbar.flags, '') .. ']'
    endif

    return {
                \ 'section_a': s:lightline_tagbar.sort,
                \ 'section_b': l:flags,
                \ 'section_c': s:lightline_tagbar.fname,
                \ }
endfunction
