function! lightline_settings#quickfix#Statusline(...) abort
    return {
                \ 'section_a': getwininfo(win_getid())[0]['loclist'] ? 'Location' : 'Quickfix',
                \ 'section_b': lightline_settings#Trim(get(w:, 'quickfix_title', '')),
                \ }
endfunction
