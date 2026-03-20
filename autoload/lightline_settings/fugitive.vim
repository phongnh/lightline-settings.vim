" https://github.com/tpope/vim-fugitive
let s:names = { 'staged': 'Staged', 'unstaged': 'Unstaged', 'untracked': 'Untracked' }

function! s:FugitiveStatus() abort
    if exists('b:fugitive_status')
        return ['staged', 'unstaged', 'untracked']
                    \ ->filter('len(b:fugitive_status[v:val]) > 0')
                    \ ->map('s:names[v:val] .. ": " .. len(b:fugitive_status[v:val])')
    endif
    return []
endfunction

function! lightline_settings#fugitive#Mode(...) abort
    return {
                \ 'name': 'Fugitive',
                \ 'plugin': lightline_settings#git#Branch(),
                \ 'filename': lightline#concatenate(s:FugitiveStatus(), 0),
                \ }
endfunction
