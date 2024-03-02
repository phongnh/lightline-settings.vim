" https://github.com/stevearc/oil.nvim
function! lightline_settings#oil#Mode(...) abort
    let result = {}

    let l:oil_dir = get(a:, 1, expand('%'))
    if l:oil_dir =~# '^oil://'
        let l:oil_dir = substitute(l:oil_dir, '^oil://', '', '')
        let result['plugin'] = fnamemodify(l:oil_dir, ':p:~:.:h')
    elseif exists('b:oil_ready') && b:oil_ready
        let result['plugin'] = fnamemodify(luaeval('require("oil").get_current_dir()'), ':p:~:.:h')
    endif

    return result
endfunction
