vim9script

# https://github.com/stevearc/oil.nvim
def GetCurrentDir(bufname: string): string
    var dir = ''
    if bufname =~# '^oil://'
        dir = substitute(bufname, '^oil://', '', '')
    elseif exists('b:oil_ready') && b:oil_ready
        dir = luaeval('require("oil").get_current_dir()')
    endif
    return !empty(dir) ? fnamemodify(dir, ':p:~:.:h') : ''
enddef

export def Mode(...args: list<any>): dict<any>
    return {section_a: 'Oil', section_c: GetCurrentDir(get(args, 0, expand('%')))}
enddef
