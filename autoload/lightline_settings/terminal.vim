vim9script

export def Statusline(...args: list<any>): dict<any>
    return {section_a: 'TERMINAL', section_c: expand('%')}
enddef
