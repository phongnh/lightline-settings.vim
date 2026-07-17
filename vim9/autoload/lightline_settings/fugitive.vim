vim9script

# https://github.com/tpope/vim-fugitive
const names = {staged: 'Staged', unstaged: 'Unstaged', untracked: 'Untracked'}

def FugitiveStatus(): list<string>
    if exists('b:fugitive_status')
        return ['staged', 'unstaged', 'untracked']
            ->filter((_, key) => len(b:fugitive_status[key]) > 0)
            ->map((_, key) => $'{names[key]}: {len(b:fugitive_status[key])}')
    endif
    return []
enddef

export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'Git Status',
        section_b: lightline_settings#gitbranch#Component(),
        section_c: lightline#concatenate(FugitiveStatus(), 0),
    }
enddef

export def FugitiveChanged()
    if !exists('g:_fugitive_last_job')
        return
    endif

    const bufnr = get(g:_fugitive_last_job, 'capture_bufnr', -1)
    if bufnr > 0
        const cmd = join(extendnew(g:_fugitive_last_job.git, g:_fugitive_last_job.args), ' ')
        setbufvar(bufnr, 'fugitive_git_command', cmd)
        lightline#update()
    endif
enddef
