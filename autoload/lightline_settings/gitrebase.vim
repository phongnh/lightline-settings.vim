function! lightline_settings#gitrebase#Mode(...) abort
    return {
                \ 'name': 'Git Rebase',
                \ 'plugin': lightline_settings#git#Branch(),
                \ 'info': lightline_settings#lineinfo#Simple(),
                \ 'settings': lightline_settings#parts#Spell(),
                \ }
endfunction
