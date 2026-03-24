vim9script

# https://github.com/cocopon/vaffle.vim
export def Statusline(...args: list<any>): dict<any>
    const bufname = get(args, 0, expand('%'))
    const dir = get(matchlist(bufname, '^vaffle://\(\d\+\)/\(.\+\)$'), 2, '')
    return {section_a: 'Vaffle', section_c: !empty(dir) ? fnamemodify(dir, ':p:~:.:h') : ''}
enddef
