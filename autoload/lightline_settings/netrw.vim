vim9script

export def Mode(...args: list<any>): dict<any>
    return {
        section_a: 'Netrw',
        section_c: exists('b:netrw_curdir') ? fnamemodify(b:netrw_curdir, ':p:~:.:h') : '',
        section_z: printf('%s:%s', g:netrw_sort_by, get(g:, 'netrw_sort_direction', 'n') =~# 'n' ? '+' : '-'),
    }
enddef
