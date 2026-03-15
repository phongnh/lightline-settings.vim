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

        let l:status = exists('*nrrwrgn#NrrwRgnStatus()') ? nrrwrgn#NrrwRgnStatus() : {}

        if len(l:status)
            let l:result['name'] ..= { 'v': ' [C]', 'V': '', '': ' [B]' }[l:status.visual ? l:status.visual : 'V']
            let l:result['plugin'] = fnamemodify(l:status.fullname, ':~:.')
            if l:status.multi
                let l:result['name'] = 'Multi' .. l:result['name']
            else
                let l:result['plugin'] ..= ' [' .. l:status.start[1] .. '-' .. l:status.end[1] .. ']'
            endif
        elseif get(b:, 'orig_buf', 0)
            let l:result['plugin'] = bufname(b:orig_buf)
        endif
    endif

    return l:result
endfunction
