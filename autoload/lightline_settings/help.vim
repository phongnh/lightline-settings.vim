function! lightline_settings#help#Mode(...) abort
    let fname = expand('%:p')
    return {
                \ 'name': 'HELP',
                \ 'plugin': fname,
                \ 'plugin_inactive': fname,
                \ }
endfunction
