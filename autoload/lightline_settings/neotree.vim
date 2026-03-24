vim9script

# https://github.com/nvim-neo-tree/neo-tree.nvim
export def Mode(...args: list<any>): dict<any>
    return {section_a: 'NeoTree', section_c: exists('b:neo_tree_source') ? b:neo_tree_source : ''}
enddef
