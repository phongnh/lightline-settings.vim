vim9script

export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'MAN',
        section_b: expand('%:t'),
        section_x: lightline_settings#components#Ruler(),
    }
enddef
