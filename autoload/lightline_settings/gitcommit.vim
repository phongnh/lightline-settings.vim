function! lightline_settings#gitcommit#Mode(...) abort
    return {
                \ 'name': 'Commit Message',
                \ 'plugin': lightline_settings#git#Branch(),
                \ 'info': lightline_settings#lineinfo#Simple(),
                \ 'settings': lightline_settings#parts#Spell(),
                \ }
endfunction
