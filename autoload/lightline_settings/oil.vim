" https://github.com/stevearc/oil.nvim
function! s:GetCurrentDir(bufname) abort
    let dir = ''
    if a:bufname =~# '^oil://'
        let dir = substitute(a:bufname, '^oil://', '', '')
    elseif exists('b:oil_ready') && b:oil_ready
        let dir = luaeval('require("oil").get_current_dir()')
    endif
    return strlen(dir) ? fnamemodify(dir, ':p:~:.:h') : ''
endfunction

function! lightline_settings#oil#Mode(...) abort
    return { 'plugin': s:GetCurrentDir(get(a:, 1, expand('%'))) }
endfunction
