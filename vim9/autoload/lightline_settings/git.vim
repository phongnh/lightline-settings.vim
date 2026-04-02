vim9script

export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'Git',
        section_c: expand('%:t'),
        section_x: lightline_settings#components#Position(),
    }
enddef
