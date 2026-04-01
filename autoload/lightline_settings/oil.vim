" https://github.com/stevearc/oil.nvim
function! s:GetCurrentDir(bufname) abort
    let l:dir = ''
    if a:bufname =~# '^oil://'
        let l:dir = substitute(a:bufname, '^oil://', '', '')
    elseif exists('b:oil_ready') && b:oil_ready
        let l:dir = luaeval('require("oil").get_current_dir()')
    endif
    return !empty(l:dir) ? fnamemodify(l:dir, ':p:~:.:h') : ''
endfunction

function! lightline_settings#oil#Mode(...) abort
    return { 'section_a': 'Oil', 'section_c': s:GetCurrentDir(get(a:, 1, expand('%'))) }
endfunction
