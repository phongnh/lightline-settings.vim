" https://github.com/chrisbra/NrrwRgn
let s:visual_mode_indicators = { '': '', 'v': ' [C]', 'V': '', '': ' [B]', '\<C-V>': ' [B]' }

function! s:GetMode() abort
    let l:name = exists('b:nrrw_instn') ? 'NrrwRgn#' .. b:nrrw_instn : 'NrrwRgn'
    let l:prefix = stridx(bufname('%'), 'NrrwRgn_multi') == 0 ? 'Multi' : ''
    let l:visual = ''
    let l:status = nrrwrgn#NrrwRgnStatus()
    if !empty(l:status)
        let l:prefix = l:status.multi ? 'Multi' : ''
        let l:visual = s:visual_mode_indicators[l:status.visual]
    endif
    return '[' .. l:prefix .. l:name .. ']' .. l:visual
endfunction

function! s:GetBufName() abort
    let l:status = nrrwrgn#NrrwRgnStatus()
    let l:bufname = !empty(l:status) ? l:status.fullname : bufname(get(b:, 'orig_buf', '%'))
    let l:bufname = fnamemodify(l:bufname, ':~:.')
    if !empty(l:status) && !l:status.multi
        let l:bufname = l:bufname .. printf(' [%d-%d]', l:status.start[1], l:status.end[1])
    endif
    return l:bufname
endfunction

function! lightline_settings#nrrwrgn#Mode(...) abort
    return {
                \ 'section_a': s:GetMode(),
                \ 'section_c': s:GetBufName(),
                \ }
endfunction
