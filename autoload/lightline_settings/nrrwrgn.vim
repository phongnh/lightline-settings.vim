" https://github.com/chrisbra/NrrwRgn
function! lightline_settings#nrrwrgn#Mode(...) abort
    let result = { 'name': 'NrrwRgn' }

    if exists(':WR') == 2 || exists(':WidenRegion') == 2
        if exists('b:nrrw_instn')
            let result['name'] = printf('%s#%d', 'NrrwRgn', b:nrrw_instn)
        else
            let result['name'] = substitute(bufname('%'), '^NrrwRgn_\zs.*\ze_\d\+$', submatch(0), '')
            let result['name'] = substitute(result['name'], '__', '#', '')
        endif

        let dict = exists('*nrrwrgn#NrrwRgnStatus()') ? nrrwrgn#NrrwRgnStatus() : {}

        if len(dict)
            let vmode = { '': '', 'v': ' [C]', 'V': '', '': ' [B]' }
            let result['name'] = (dict.multi ? 'Multi' : '') . result['name'] . vmode[dict.visual ? dict.visual : 'V']
            let result['plugin'] = fnamemodify(dict.fullname, ':~:.') . (dict.multi ? '' : printf(' [%d-%d]', dict.start[1], dict.end[1]))
        elseif get(b:, 'orig_buf', 0)
            let result['plugin'] = bufname(b:orig_buf)
        endif
    endif

    return result
endfunction
