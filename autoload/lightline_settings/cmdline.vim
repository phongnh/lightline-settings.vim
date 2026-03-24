vim9script

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: 'Command Line',
        section_b: lightline#concatenate([
            '<C-C>: edit',
            '<CR>: execute',
        ], 0),
        section_x: lightline_settings#components#Position(),
    }
enddef
