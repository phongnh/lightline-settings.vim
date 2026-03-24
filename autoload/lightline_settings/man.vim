vim9script

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: 'MAN',
        section_b: expand('%:t'),
        section_x: lightline_settings#lineinfo#Full(),
    }
enddef
