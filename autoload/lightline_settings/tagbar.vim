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
        let plugin_status = lightline#concatenate([
                    \ s:lightline_tagbar.sort,
                    \ s:lightline_tagbar.fname,
                    \ ], 0)
    else
        let plugin_status = lightline#concatenate([
                    \ s:lightline_tagbar.sort,
                    \ s:lightline_tagbar.fname,
                    \ join(s:lightline_tagbar.flags, ''),
                    \ ], 0)
    endif

    return {
                \ 'name': 'Tagbar',
                \ 'plugin': plugin_status,
                \ 'type': 'tagbar',
                \ }
endfunction
