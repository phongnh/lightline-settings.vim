function! lightline_settings#gitcommit#Statusline(...) abort
    return {
                \ 'section_a': 'Commit Message',
                \ 'section_b': lightline_settings#gitbranch#Name(),
                \ 'section_x': lightline_settings#components#Position(),
                \ 'section_y': lightline_settings#components#Spell(),
                \ }
endfunction
