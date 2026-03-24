vim9script

export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'Git Rebase',
        section_b: lightline_settings#gitbranch#Component(),
        section_x: lightline_settings#components#Position(),
        section_y: lightline_settings#components#Spell(),
    }
enddef
