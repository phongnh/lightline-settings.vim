vim9script

# https://github.com/mbbill/undotree
export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'Undo',
        section_b: exists('t:undotree') ? t:undotree.GetStatusLine() : '',
    }
enddef
