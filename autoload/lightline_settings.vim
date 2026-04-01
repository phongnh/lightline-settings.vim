vim9script

# Cache window width to avoid repeated winwidth() calls
var cached_winwidth = 0
var cached_winwidth_nr = 0

def GetWinWidthImpl(winnr: number = 0): number
    # Cache is only valid for current window in current update
    if winnr == cached_winwidth_nr && cached_winwidth > 0
        return cached_winwidth
    endif
    cached_winwidth = winwidth(winnr)
    cached_winwidth_nr = winnr
    return cached_winwidth
enddef

# Expose for use in other modules
export def GetWinWidth(...args: list<any>): number
    var winnr = get(args, 0, 0)
    return GetWinWidthImpl(winnr)
enddef

# Clear width cache (called by lightline on update)
export def ClearWidthCache()
    cached_winwidth = 0
    cached_winwidth_nr = 0
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

export def Init()
    setglobal noshowmode laststatus=2

    # Disable Vim Quickfix's statusline
    g:qf_disable_statusline = 1

    # Disable NERDTree statusline
    g:NERDTreeStatusline = -1

    # CtrlP Integration
    if exists(':CtrlP') == 2
        g:ctrlp_status_func = {
            main: 'lightline_settings#ctrlp#MainStatus',
            prog: 'lightline_settings#ctrlp#ProgressStatus',
        }
    endif

    # Tagbar Integration
    if exists(':Tagbar') == 2
        g:tagbar_status_func = 'lightline_settings#tagbar#Status'
    endif

    if exists(':ZoomWin') == 2
        g:lightline_zoomwin_funcref = []

        if exists('g:ZoomWin_funcref')
            if type(g:ZoomWin_funcref) == v:t_func
                g:lightline_zoomwin_funcref = [g:ZoomWin_funcref]
            elseif type(g:ZoomWin_funcref) == v:t_list
                g:lightline_zoomwin_funcref = g:ZoomWin_funcref
            endif
            g:lightline_zoomwin_funcref = uniq(copy(g:lightline_zoomwin_funcref))
        endif

        g:ZoomWin_funcref = function('lightline_settings#zoomwin#Status')
    endif
enddef
