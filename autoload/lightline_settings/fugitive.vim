vim9script

# https://github.com/tpope/vim-fugitive
const names = {staged: 'Staged', unstaged: 'Unstaged', untracked: 'Untracked'}

def FugitiveStatus(): list<string>
    if exists('b:fugitive_status')
        return ['staged', 'unstaged', 'untracked']
            ->filter('len(b:fugitive_status[v:val]) > 0')
            ->map('names[v:val] .. ": " .. len(b:fugitive_status[v:val])')
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
