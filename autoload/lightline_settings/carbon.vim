" https://github.com/SidOfc/carbon.nvim
function! lightline_settings#carbon#Statusline(...) abort
    return { 'section_a': 'Carbon', 'section_c': exists('b:carbon') ? fnamemodify(b:carbon['path'], ':p:~:.:h') : '' }
endfunction
