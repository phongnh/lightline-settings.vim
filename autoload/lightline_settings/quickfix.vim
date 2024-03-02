function! lightline_settings#quickfix#Mode(...) abort
    return {
                \ 'name': getwininfo(win_getid())[0]['loclist'] ? 'Location' : 'Quickfix',
                \ 'plugin': lightline_settings#Trim(get(w:, 'quickfix_title', '')),
                \ }
endfunction
