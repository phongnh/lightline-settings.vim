vim9script

# https://github.com/lambdalisue/fern.vim
export def Statusline(...args: list<any>): dict<any>
    const bufname = get(args, 0, expand('%'))
    const data = matchlist(bufname, '^fern://\(.\+\)/file://\(.\+\)\$')

    if empty(data)
        return {section_a: 'Fern'}
    endif

    var name = get(data, 1, '')
    name = stridx(name, 'drawer') > -1 ? 'Drawer' : 'Fern'

    var folder = get(data, 2, '')
    folder = substitute(folder, ';\?\(#.\+\)\?\$\?$', '', '')
    folder = fnamemodify(folder, ':p:~:.:h')

    return {section_a: name, section_c: folder}
enddef
