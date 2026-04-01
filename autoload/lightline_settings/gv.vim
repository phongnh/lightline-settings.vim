vim9script

# https://github.com/junegunn/gv.vim
export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'GV',
        section_b: lightline#concatenate([
            'o: open split',
            'O: open tab',
            'gb: GBrowse',
            'q: quit',
        ], 0),
        section_x: lightline_settings#components#Position(),
    }
enddef
