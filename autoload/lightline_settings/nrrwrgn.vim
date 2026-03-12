" https://github.com/chrisbra/NrrwRgn
function! lightline_settings#nrrwrgn#Mode(...) abort
    let l:result = { 'name': 'NrrwRgn' }

    if exists(':WR') == 2 || exists(':WidenRegion') == 2
        if exists('b:nrrw_instn')
            let l:result['name'] = 'NrrwRgn#' .. b:nrrw_instn
        else
            let l:result['name'] = substitute(bufname('%'), '^NrrwRgn_\zs.*\ze_\d\+$', submatch(0), '')
            let l:result['name'] = substitute(l:result['name'], '__', '#', '')
        endif

        let l:dict = exists('*nrrwrgn#NrrwRgnStatus()') ? nrrwrgn#NrrwRgnStatus() : {}

        if len(l:dict)
            let l:vmode = { '': '', 'v': ' [C]', 'V': '', '': ' [B]' }
            let l:result['name'] = (l:dict.multi ? 'Multi' : '') .. l:result['name'] .. l:vmode[l:dict.visual ? l:dict.visual : 'V']
            let l:result['plugin'] = fnamemodify(l:dict.fullname, ':~:.') .. (l:dict.multi ? '' : printf(' [%d-%d]', l:dict.start[1], l:dict.end[1]))
        elseif get(b:, 'orig_buf', 0)
            let l:result['plugin'] = bufname(b:orig_buf)
        endif
    endif

    return l:result
endfunction
