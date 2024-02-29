" https://github.com/chrisbra/NrrwRgn
function! lightline_settings#nrrwrgn#Mode(...) abort
    let result = { 'name': 'NrrwRgn' }

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
            let vmode = { 'v': ' [C]', 'V': '', '': ' [B]' }
            let result['name'] = (dict.multi ? 'Multi' : '') . result['name'] . vmode[dict.visual ? dict.visual : 'V']
            let result['plugin'] = fnamemodify(dict.fullname, ':~:.') . (dict.multi ? '' : printf(' [%d-%d]', dict.start[1], dict.end[1]))
            let result['plugin_inactive'] = result['plugin']
        elseif get(b:, 'orig_buf', 0)
            let result['plugin'] = bufname(b:orig_buf)
            let result['plugin_inactive'] = result['plugin']
        endif
    endif

    return result
endfunction
