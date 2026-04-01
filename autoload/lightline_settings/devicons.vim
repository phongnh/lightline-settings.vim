function! lightline_settings#devicons#FileType(filename) abort
    return ''
endfunction

function! lightline_settings#devicons#Detect() abort
    if !empty(findfile('autoload/nerdfont.vim', &rtp))
        function! lightline_settings#devicons#FileType(filename) abort
            return ' ' .. nerdfont#find(a:filename) .. ' '
        endfunction

        return 1
    elseif !empty(findfile('plugin/webdevicons.vim', &rtp))
        function! lightline_settings#devicons#FileType(filename) abort
            return ' ' .. WebDevIconsGetFileTypeSymbol(a:filename) .. ' '
        endfunction

        return 1
    elseif exists('g:LightlineWebDevIconsFind')
        function! lightline_settings#devicons#FileType(filename) abort
            return ' ' .. g:LightlineWebDevIconsFind(a:filename) .. ' '
        endfunction

        return 1
    endif

    return 0
endfunction
