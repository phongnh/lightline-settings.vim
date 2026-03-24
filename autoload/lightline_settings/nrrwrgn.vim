vim9script

# https://github.com/chrisbra/NrrwRgn
var visual_mode_indicators = {'': '', 'v': ' [C]', 'V': '', "\<C-V>": ' [B]'}

def GetMode(): string
    var name = exists('b:nrrw_instn') ? 'NrrwRgn#' .. b:nrrw_instn : 'NrrwRgn'
    var prefix = stridx(bufname('%'), 'NrrwRgn_multi') == 0 ? 'Multi' : ''
    var visual = ''
    var status = call('nrrwrgn#NrrwRgnStatus', [])
    if !empty(status)
        prefix = status.multi ? 'Multi' : ''
        visual = visual_mode_indicators[status.visual]
    endif
    return '[' .. prefix .. name .. ']' .. visual
enddef

def GetBufName(): string
    var status = call('nrrwrgn#NrrwRgnStatus', [])
    var bufname = !empty(status) ? status.fullname : bufname(get(b:, 'orig_buf', '%'))
    bufname = fnamemodify(bufname, ':~:.')
    if !empty(status) && !status.multi
        bufname = bufname .. printf(' [%d-%d]', status.start[1], status.end[1])
    endif
    return bufname
enddef

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: GetMode(),
        section_c: GetBufName(),
    }
enddef
