vim9script

# https://github.com/wsdjeg/FlyGrep.vim
export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'FlyGrep',
        section_b: call('SpaceVim#plugins#flygrep#mode', []),
        section_c: fnamemodify(getcwd(), ':~'),
        section_z: call('SpaceVim#plugins#flygrep#lineNr', []),
    }
enddef
