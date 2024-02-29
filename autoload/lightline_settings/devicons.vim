function! lightline_settings#devicons#Detect() abort
    if findfile('autoload/nerdfont.vim', &rtp) != ''
        function! s:GetFileTypeSymbol(filename) abort
            return nerdfont#find(a:filename)
        endfunction

        return 1
    elseif findfile('plugin/webdevicons.vim', &rtp) != ''
        function! s:GetFileTypeSymbol(filename) abort
            return WebDevIconsGetFileTypeSymbol(a:filename)
        endfunction

        return 1
    elseif exists('g:LightlineWebDevIconsFind')
        function! s:GetFileTypeSymbol(filename) abort
            return g:LightlineWebDevIconsFind(a:filename)
        endfunction

        return 1
    endif

    return 0
endfunction

function! lightline_settings#devicons#FileType(filename) abort
    return s:GetFileTypeSymbol(a:filename)
endfunction
