function! s:TabNumber(n) abort
    return a:n .. ': '
endfunction

function! s:TabBufferType(n) abort
    let l:ft = gettabwinvar(a:n, tabpagewinnr(a:n), '&filetype')
    return !empty(l:ft) ? l:ft : gettabwinvar(a:n, tabpagewinnr(a:n), '&buftype')
endfunction

function! s:TabBufferName(n) abort
    let l:ft = s:TabBufferType(a:n)
    if has_key(g:lightline_filetype_modes, l:ft)
        return g:lightline_filetype_modes[l:ft]
    endif
    let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
    let l:bufname = expand('#' .. l:bufnr .. ':t')
    if get(g:lightline_buffer_count_by_basename, l:bufname, 0) > 1
        let l:fname = substitute(expand('#' .. l:bufnr .. ':p'), '.*/\([^/]\+/\)', '\1', '')
    else
        let l:fname = l:bufname
    endif
    return l:fname =~# '^\[preview' ? 'Preview' : get(g:lightline_filename_modes, l:fname, l:fname)
endfunction

" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
function! s:TabReadonly(n) abort
    return gettabwinvar(a:n, tabpagewinnr(a:n), '&readonly') ? g:lightline_symbols.readonly .. ' ' : ''
endfunction

function! lightline_settings#tab#Modified(n) abort
    let l:winnr = tabpagewinnr(a:n)
    if gettabwinvar(a:n, l:winnr, '&modified')
        return !gettabwinvar(a:n, l:winnr, '&modifiable') ? '+-' : '+'
    else
        return !gettabwinvar(a:n, l:winnr, '&modifiable') ? '-' : ''
    endif
endfunction

function! lightline_settings#tab#Name(n) abort
    return s:TabNumber(a:n) .. s:TabReadonly(a:n) .. s:TabBufferName(a:n)
endfunction
