vim9script

export def Simple(...args: list<any>): string
    return printf('%3d:%-3d', line('.'), col('.'))
enddef

export def Full(...args: list<any>): string
    var percent: string
    if line('w0') == 1 && line('w$') == line('$')
        percent = 'All'
    elseif line('w0') == 1
        percent = 'Top'
    elseif line('w$') == line('$')
        percent = 'Bot'
    else
        percent = (line('.') * 100 / line('$')) .. '%'
    endif

    return printf('%4d:%-3d %3s', line('.'), col('.'), percent)
enddef
