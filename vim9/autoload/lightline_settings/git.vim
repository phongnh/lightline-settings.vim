vim9script

export def Statusline(...args: list<any>): dict<any>
    var result = {
        section_a: 'Git',
        section_c: expand('%:t'),
        section_x: lightline_settings#components#Position(),
    }
    if exists('b:fugitive_git_command')
        result.section_c = b:fugitive_git_command
    elseif exists('g:_fugitive_last_job') && get(g:_fugitive_last_job, 'capture_bufnr', -1) ==# bufnr('%')
        const cmd = g:_fugitive_last_job.git->extendnew(g:_fugitive_last_job.args)->join(' ')
        setbufvar(g:_fugitive_last_job.capture_bufnr, 'fugitive_git_command', cmd)
        result.section_c = cmd
    endif
    return result
enddef
