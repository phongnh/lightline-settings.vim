function! lightline_settings#gitrebase#Statusline(...) abort
    return {
                \ 'section_a': 'Git Rebase',
                \ 'section_b': lightline_settings#gitbranch#Name(),
                \ 'section_x': lightline_settings#components#Position(),
                \ 'section_y': lightline_settings#components#Spell(),
                \ }
endfunction
