" https://github.com/chrisbra/NrrwRgn
let s:visual_mode_indicators = { 'v': ' [C]', 'V': '', '': ' [B]' }

function! s:GetName() abort
    if exists('b:nrrw_instn')
        return 'NrrwRgn#' .. b:nrrw_instn
    endif
    let l:name = substitute(bufname('%'), '^NrrwRgn_\zs.*\ze_\d\+$', submatch(0), '')
    return = substitute(l:name, '__', '#', '')
endfunction

function! lightline_settings#nrrwrgn#Mode(...) abort
    let l:result = { 'name': s:GetName() }

    if exists('*nrrwrgn#NrrwRgnStatus')
        let l:status = nrrwrgn#NrrwRgnStatus()

        if !empty(l:status)
            let l:prefix = l:status.multi ? 'Multi' : ''
            let l:indicator = s:visual_mode_indicators[l:status.visual ? l:status.visual : 'V']
            let l:result['name'] = l:prefix .. l:result['name'] .. l:indicator

            let l:result['plugin'] = fnamemodify(l:status.fullname, ':~:.')
            if !l:status.multi
                let l:result['plugin'] ..= ' [' .. l:status.start[1] .. '-' .. l:status.end[1] .. ']'
            endif
        endif
    endif

    if empty(l:result['plugin']) && get(b:, 'orig_buf', 0)
        let l:result['plugin'] = bufname(b:orig_buf)
    endif

    return l:result
endfunction
