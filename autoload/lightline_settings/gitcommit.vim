vim9script

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: 'Commit Message',
        section_b: lightline_settings#gitbranch#Component(),
        section_x: lightline_settings#components#Position(),
        section_y: lightline_settings#components#Spell(),
    }
enddef
