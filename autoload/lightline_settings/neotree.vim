" https://github.com/nvim-neo-tree/neo-tree.nvim
function! lightline_settings#neotree#Mode(...) abort
    return { 'name': 'NeoTree', 'plugin': exists('b:neo_tree_source') ? b:neo_tree_source : '' }
endfunction

