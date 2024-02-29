function! lightline_settings#quickfix#Mode(...) abort
    let result = { 'name': 'Quickfix' }

    if getwininfo(win_getid())[0]['loclist']
        let result['name'] = 'Location'
    endif

    let qf_title = lightline_settings#Trim(get(w:, 'quickfix_title', ''))
    return extend(result, {
                \ 'plugin': qf_title,
                \ 'plugin_inactive': qf_title,
                \ })
endfunction
