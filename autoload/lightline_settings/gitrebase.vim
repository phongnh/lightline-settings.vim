function! lightline_settings#gitrebase#Mode(...) abort
    return {
                \ 'section_a': 'Git Rebase',
                \ 'section_b': lightline_settings#git#Branch(),
                \ 'section_x': lightline_settings#lineinfo#Simple(),
                \ 'section_y': lightline_settings#parts#Spell(),
                \ }
endfunction
