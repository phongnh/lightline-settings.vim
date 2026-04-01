vim9script

def TabNumber(n: number): string
    return n .. ': '
enddef

def TabBufferType(n: number): string
    const ft = gettabwinvar(n, tabpagewinnr(n), '&filetype')
    return !empty(ft) ? ft : gettabwinvar(n, tabpagewinnr(n), '&buftype')
enddef

def TabBufferName(n: number): string
    const ft = TabBufferType(n)
    if has_key(g:lightline_filetype_modes, ft)
        return g:lightline_filetype_modes[ft]
    endif
    const bufnr = tabpagebuflist(n)[tabpagewinnr(n) - 1]
    const bufname = expand('#' .. bufnr .. ':t')
    var fname: string
    if get(g:lightline_buffer_count_by_basename, bufname, 0) > 1
        fname = substitute(expand('#' .. bufnr .. ':p'), '.*/\([^/]\+/\)', '\1', '')
    else
        fname = bufname
    endif
    return fname =~# '^\[preview' ? 'Preview' : get(g:lightline_filename_modes, fname, fname)
enddef

# Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
def TabReadonly(n: number): string
    return gettabwinvar(n, tabpagewinnr(n), '&readonly') ? g:lightline_symbols.readonly .. ' ' : ''
enddef

export def Modified(n: number): string
    const winnr = tabpagewinnr(n)
    if gettabwinvar(n, winnr, '&modified')
        return !gettabwinvar(n, winnr, '&modifiable') ? '+-' : '+'
    else
        return !gettabwinvar(n, winnr, '&modifiable') ? '-' : ''
    endif
enddef

export def Name(n: number): string
    return TabNumber(n) .. TabReadonly(n) .. TabBufferName(n)
enddef
