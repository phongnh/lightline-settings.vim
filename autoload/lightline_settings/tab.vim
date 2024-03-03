function! s:TabNumber(n) abort
    return printf('%d: ', a:n)
endfunction

function! s:TabBufferType(n) abort
    let ft = gettabwinvar(a:n, tabpagewinnr(a:n), '&filetype')
    return strlen(ft) ? ft : gettabwinvar(a:n, tabpagewinnr(a:n), '&buftype')
endfunction

function! s:TabBufferName(n) abort
    let ft = s:TabBufferType(a:n)
    if has_key(g:lightline_filetype_modes, ft)
        return g:lightline_filetype_modes[ft]
    endif
    let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
    let bufname = expand('#' . bufnr . ':t')
    if get(g:lightline_buffer_count_by_basename, bufname) > 1
        let fname = substitute(expand('#' . bufnr . ':p'), '.*/\([^/]\+/\)', '\1', '')
    else
        let fname = bufname
    endif
    return fname =~# '^\[preview' ? 'Preview' : get(g:lightline_filename_modes, fname, fname)
endfunction

" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
function! s:TabReadonly(n) abort
    return gettabwinvar(a:n, tabpagewinnr(a:n), '&readonly') ? g:lightline_symbols.readonly . ' ' : ''
endfunction

function! lightline_settings#tab#Modified(n) abort
    let winnr = tabpagewinnr(a:n)
    if gettabwinvar(a:n, winnr, '&modified')
        return !gettabwinvar(a:n, winnr, '&modifiable') ? '+-' : '+'
    else
        return !gettabwinvar(a:n, winnr, '&modifiable') ? '-' : ''
    endif
endfunction

function! lightline_settings#tab#Name(n) abort
    return s:TabNumber(a:n) . s:TabReadonly(a:n) . s:TabBufferName(a:n)
endfunction
