function! lightline_settings#sections#Mode(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return l:mode['name']
    endif

    return lightline#concatenate([
                \ lightline_settings#parts#Mode(),
                \ lightline_settings#parts#Clipboard(),
                \ lightline_settings#parts#Paste(),
                \ lightline_settings#parts#Spell(),
                \ ], 0)
endfunction
