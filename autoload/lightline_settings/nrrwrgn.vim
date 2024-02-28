function! lightline_settings#nrrwrgn#Mode(...) abort
    let result = {}

    if exists(':WidenRegion') == 2
        let result['type'] = 'nrrwrgn'

        if exists('b:nrrw_instn')
            let result['name'] = printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
        else
            let l:mode = substitute(bufname('%'), '^Nrrwrgn_\zs.*\ze_\d\+$', submatch(0), '')
            let l:mode = substitute(l:mode, '__', '#', '')
            let result['name'] = l:mode
        endif

        let dict = exists('*nrrwrgn#NrrwRgnStatus()') ? nrrwrgn#NrrwRgnStatus() : {}

        if len(dict)
            let result['plugin'] = fnamemodify(dict.fullname, ':~:.')
            let result['plugin_inactive'] = result['plugin']
        elseif get(b:, 'orig_buf', 0)
            let result['plugin'] = bufname(b:orig_buf)
            let result['plugin_inactive'] = result['plugin']
        endif
    endif

    return result
endfunction
