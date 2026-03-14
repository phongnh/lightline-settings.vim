function! lightline_settings#gitrebase#Mode(...) abort
    return {
                \ 'name': lightline#concatenate([
                \   'Git Rebase',
                \   lightline_settings#parts#Spell(),
                \ ], 0),
                \ 'plugin': lightline_settings#git#Branch(),
                \ 'info': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
