function! lightline_settings#git#Statusline(...) abort
    let l:result = {
                \ 'section_a': 'Git',
                \ 'section_c': expand('%:t'),
                \ 'section_x': lightline_settings#components#Position(),
                \ }
    if exists('g:_fugitive_last_job') && get(g:_fugitive_last_job, 'capture_bufnr', -1) == bufnr('%')
        let l:cmd = join(extendnew(g:_fugitive_last_job.git, g:_fugitive_last_job.args), ' ')
        let l:result['section_c'] = l:cmd
    endif
    return l:result
endfunction
