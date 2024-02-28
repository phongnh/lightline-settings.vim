function! s:TabNumber(n) abort
    return printf('%d:', a:n)
endfunction

function! s:TabFileType(n) abort
    let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
    let bufname = expand('#' . bufnr . ':t')
    let ft = gettabwinvar(a:n, tabpagewinnr(a:n), '&ft')
    if get(g:lightline_buffer_count_by_basename, bufname) > 1
        let fname = substitute(expand('#' . bufnr . ':p'), '.*/\([^/]\+/\)', '\1', '')
    else
        let fname = bufname
    endif
    return fname =~# '^\[preview' ? 'Preview' : get(g:lightline_filetype_modes, ft, get(g:lightline_filename_modes, fname, fname))
endfunction

" Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
function! s:TabReadonly(n) abort
    let winnr = tabpagewinnr(a:n)
    return gettabwinvar(a:n, winnr, '&readonly') ? g:lightline_symbols.readonly . ' ' : ''
endfunction

function! lightline_settings#tab#Name(n) abort
    return join([
                \ s:TabNumber(a:n),
                \ s:TabReadonly(a:n),
                \ s:TabFileType(a:n),
                \ ], ' ')
endfunction
