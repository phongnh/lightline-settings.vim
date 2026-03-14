" https://github.com/SidOfc/carbon.nvim
function! lightline_settings#carbon#Mode(...) abort
    return { 'name': 'Carbon', 'plugin': exists('b:carbon') ? fnamemodify(b:carbon['path'], ':p:~:.:h') : '' }
endfunction
