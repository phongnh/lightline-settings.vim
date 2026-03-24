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

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: 'Git Status',
        section_b: lightline_settings#gitbranch#Name(),
        section_c: lightline#concatenate(FugitiveStatus(), 0),
    }
enddef
