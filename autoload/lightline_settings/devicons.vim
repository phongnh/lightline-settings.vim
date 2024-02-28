function! lightline_settings#devicons#Detect() abort
    if findfile('autoload/nerdfont.vim', &rtp) != ''
        function! s:GetFileTypeSymbol(filename) abort
            return nerdfont#find(a:filename)
        endfunction

        function! s:GetFileFormatSymbol(...) abort
            return nerdfont#fileformat#find()
        endfunction

        return 1
    elseif findfile('plugin/webdevicons.vim', &rtp) != ''
        function! s:GetFileTypeSymbol(filename) abort
            return WebDevIconsGetFileTypeSymbol(a:filename)
        endfunction

        function! s:GetFileFormatSymbol(...) abort
            return WebDevIconsGetFileFormatSymbol()
        endfunction

        return 1
    elseif exists('g:LightlineWebDevIconsFind')
        function! s:GetFileTypeSymbol(filename) abort
            return g:LightlineWebDevIconsFind(a:filename)
        endfunction

        let s:web_devicons_fileformats = {
                    \ 'dos': '',
                    \ 'mac': '',
                    \ 'unix': '',
                    \ }

        function! s:GetFileFormatSymbol(...) abort
            return get(s:web_devicons_fileformats, &fileformat, '')
        endfunction

        return 1
    endif

    return 0
endfunction

function! lightline_settings#devicons#FileType(filename) abort
    return s:GetFileTypeSymbol(a:filename)
endfunction

function! lightline_settings#devicons#FileFormat(...) abort
    return s:GetFileFormatSymbol()
endfunction
