" https://github.com/SidOfc/carbon.nvim
function! lightline_settings#carbon#Mode(...) abort
    return { 'section_a': 'Carbon', 'section_b': exists('b:carbon') ? fnamemodify(b:carbon['path'], ':p:~:.:h') : '' }
endfunction
