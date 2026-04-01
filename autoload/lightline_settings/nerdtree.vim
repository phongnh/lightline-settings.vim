vim9script

# https://github.com/preservim/nerdtree
export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'NERDTree',
        section_c: exists('b:NERDTree') ? fnamemodify(b:NERDTree.root.path.str(), ':p:~:.:h') : '',
    }
enddef
