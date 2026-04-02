vim9script

# Expose for use in other modules
export def GetWinWidth(...args: list<any>): number
    var winnr = get(args, 0, 0)
    return winwidth(winnr)
enddef

export def FormatFileName(fname: string, ...args: list<any>): string
    var path = fname
    var maxlen = get(args, 0, 50)

    # Use cached window width if available
    var winwidth = GetWinWidth(0)

    if winwidth <= g:lightline_winwidth_config.compact
        return fnamemodify(path, ':t')
    endif

    if len(path) > maxlen && g:lightline_shorten_path
        path = pathshorten(path)
    endif

    if len(path) > maxlen
        path = fnamemodify(path, ':t')
    endif

    return path
enddef

export def ReloadLightline()
    lightline#init()
    lightline#colorscheme()
    lightline#update()
enddef
