vim9script

var icon_type = 0  # 0: none, 1: nerdfont, 2: webdevicons, 3: custom

export def FileType(filename: string): string
    if icon_type == 1
        return ' ' .. call('nerdfont#find', [filename]) .. ' '
    elseif icon_type == 2
        return ' ' .. call('WebDevIconsGetFileTypeSymbol', [filename]) .. ' '
    elseif icon_type == 3
        return ' ' .. call(g:LightlineWebDevIconsFind, [filename]) .. ' '
    endif
    return ''
enddef

export def Detect(): bool
    if !empty(findfile('autoload/nerdfont.vim', &rtp))
        icon_type = 1
        return true
    elseif !empty(findfile('plugin/webdevicons.vim', &rtp))
        icon_type = 2
        return true
    elseif exists('g:LightlineWebDevIconsFind')
        icon_type = 3
        return true
    endif

    return false
enddef
