vim9script

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: 'HELP',
        section_c: expand('%:~:.'),
        section_x: lightline_settings#components#Ruler(),
    }
enddef
