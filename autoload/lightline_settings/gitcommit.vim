function! lightline_settings#gitcommit#Mode(...) abort
    return {
                \ 'name': lightline#concatenate(
                \   [
                \       'Commit Message',
                \       lightline_settings#parts#Spell(),
                \   ],
                \   0
                \ ),
                \ 'plugin': lightline_settings#git#Branch(),
                \ 'info': lightline_settings#lineinfo#Simple(),
                \ }
endfunction
