vim9script

def DefaultFind(filename: string): string
    return ''
enddef

def NerdfontFind(filename: string): string
    return ' ' .. call('nerdfont#find', [filename, 0]) .. ' '
enddef

def WebDevIconsFind(filename: string): string
    return ' ' .. call('WebDevIconsGetFileTypeSymbol', [filename, 0]) .. ' '
enddef

# 0: none, 1: nerdfont, 2: webdevicons or SupraIcons
var IconFindFunc: any = DefaultFind

export def FileType(filename: string): string
    return call(IconFindFunc, [filename])
enddef

export def Detect(): bool
    if !empty(findfile('autoload/nerdfont.vim', &rtp))
        IconFindFunc = NerdfontFind
        return true
    elseif !empty(findfile('plugin/webdevicons.vim', &rtp))
        IconFindFunc = WebDevIconsFind
        return true
    elseif !empty(findfile('plugin/SupraIcons.vim', &rtp))
        IconFindFunc = WebDevIconsFind
        return true
    endif

    return false
enddef
