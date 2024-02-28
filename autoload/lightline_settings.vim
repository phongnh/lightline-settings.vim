if exists('*trim')
    function! s:Strip(str) abort
        return trim(a:str)
    endfunction
else
    function! s:Strip(str) abort
        return substitute(a:str, '^\s*\(.\{-}\)\s*$', '\1', '')
    endfunction
endif

function! lightline_settings#Strip(str) abort
    return s:Strip(a:str)
endfunction

if exists('*pathshorten')
    function! s:ShortenPath(filename) abort
        return pathshorten(a:filename)
    endfunction
else
    function! s:ShortenPath(filename) abort
        return substitute(a:filename, '\v\w\zs.{-}\ze(\\|/)', '', 'g')
    endfunction
endif

function! lightline_settings#ShortenPath(file) abort
    return s:ShortenPath(a:file)
endfunction
