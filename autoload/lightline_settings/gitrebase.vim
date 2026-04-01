function! lightline_settings#gitrebase#Mode(...) abort
    return {
                \ 'section_a': 'Git Rebase',
                \ 'section_b': lightline_settings#gitbranch#Name(),
                \ 'section_x': lightline_settings#lineinfo#Simple(),
                \ 'section_y': lightline_settings#components#Spell(),
                \ }
endfunction
