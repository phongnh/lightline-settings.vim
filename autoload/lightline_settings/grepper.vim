vim9script

# https://github.com/mhinz/vim-grepper
def GrepperSideStatus(): string
    if !empty(b:grepper_side_status)
        return printf(
            'Found %d %s in %d %s.',
            b:grepper_side_status.matches,
            b:grepper_side_status.matches == 1 ? 'match' : 'matches',
            b:grepper_side_status.files,
            b:grepper_side_status.files == 1 ? 'file' : 'files'
        )
    endif
    return ''
enddef

export def Statusline(...args: list<any>): dict<any>
    return {section_a: 'GrepperSide', section_b: GrepperSideStatus()}
enddef
