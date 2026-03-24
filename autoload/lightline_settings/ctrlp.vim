vim9script

# https://github.com/ctrlpvim/ctrlp.vim
var lightline_ctrlp: dict<any> = {}

def GetCurrentDir(): string
    var cwd = getcwd()
    var dir = fnamemodify(cwd, ':~:.')
    dir = empty(dir) ? cwd : dir
    return len(dir) > 30 ? pathshorten(dir) : dir
enddef

export def MainStatus(focus: any, byfname: any, regex: any, prev: any, item: any, next: any, marked: any): string
    lightline_ctrlp.main    = 1
    lightline_ctrlp.focus   = focus
    lightline_ctrlp.byfname = byfname
    lightline_ctrlp.regex   = regex
    lightline_ctrlp.prev    = prev
    lightline_ctrlp.item    = item
    lightline_ctrlp.next    = next
    lightline_ctrlp.marked  = marked
    lightline_ctrlp.dir     = GetCurrentDir()

    return call('lightline#statusline', [0])
enddef

export def ProgressStatus(len: any): string
    lightline_ctrlp.main = 0
    lightline_ctrlp.len  = len
    lightline_ctrlp.dir  = GetCurrentDir()

    return call('lightline#statusline', [0])
enddef

export def Mode(...args: list<any>): dict<any>
    var result = {
        section_a: 'CtrlP',
        section_z: lightline_ctrlp.dir,
    }

    if lightline_ctrlp.main != 0
        lightline#link('nR'[lightline_ctrlp.regex])

        extend(result, {
            section_b: lightline#concatenate([
                lightline_ctrlp.prev,
                '« ' .. lightline_ctrlp.item .. ' »',
                lightline_ctrlp.next,
            ], 0),
            section_y: lightline#concatenate([
                lightline_ctrlp.focus,
                lightline_ctrlp.byfname,
            ], 1),
        })
    else
        extend(result, {
            section_y: lightline_ctrlp.len,
        })
    endif

    return result
enddef
