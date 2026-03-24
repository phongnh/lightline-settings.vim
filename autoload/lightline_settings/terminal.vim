vim9script

export def Mode(...args: list<any>): dict<any>
    return {section_a: 'TERMINAL', section_c: expand('%')}
enddef
