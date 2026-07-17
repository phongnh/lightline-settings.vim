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

function! lightline_settings#fugitive#Statusline(...) abort
    return {
                \ 'section_a': 'Git Status',
                \ 'section_b': lightline_settings#gitbranch#Component(),
                \ 'section_c': lightline#concatenate(s:FugitiveStatus(), 0),
                \ }
endfunction

function! lightline_settings#fugitive#FugitiveChanged() abort
    if !exists('g:_fugitive_last_job')
        return
    endif

    let l:bufnr = get(g:_fugitive_last_job, 'capture_bufnr', -1)
    if l:bufnr > 0
        let l:cmd = join(extendnew(g:_fugitive_last_job.git, g:_fugitive_last_job.args), ' ')
        call setbufvar(l:bufnr, 'fugitive_git_command', l:cmd)
    endif
endfunction
