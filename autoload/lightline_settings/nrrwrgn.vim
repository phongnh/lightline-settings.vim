vim9script

# https://github.com/chrisbra/NrrwRgn
const VISUAL_MODE_INDICATORS = {'': '', v: ' [C]', V: '', "\<C-V>": ' [B]'}

def GetMode(): string
    const name = exists('b:nrrw_instn') ? $'NrrwRgn#{b:nrrw_instn}' : 'NrrwRgn'
    var prefix = stridx(bufname('%'), 'NrrwRgn_multi') == 0 ? 'Multi' : ''
    var visual = ''
    const status = nrrwrgn#NrrwRgnStatus()
    if !empty(status)
        prefix = status.multi ? 'Multi' : ''
        visual = VISUAL_MODE_INDICATORS[status.visual]
    endif
    return $'[{prefix}{name}]{visual}'
enddef

def GetBufName(): string
    const status = nrrwrgn#NrrwRgnStatus()
    var bufname = !empty(status) && !empty(status.fullname) ? status.fullname : bufname(get(b:, 'orig_buf', '%'))
    bufname = fnamemodify(bufname, ':~:.')
    if !empty(status) && !status.multi
        bufname = $'{bufname} [{status.start[1]}-{status.end[1]}]'
    endif
    return bufname
enddef

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: GetMode(),
        section_c: GetBufName(),
    }
enddef
