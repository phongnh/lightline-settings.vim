" https://github.com/SidOfc/carbon.nvim
function! lightline_settings#carbon#Mode(...) abort
    return { 'plugin': exists('b:carbon') ? fnamemodify(b:carbon['path'], ':p:~:.:h') : '' }
endfunction
