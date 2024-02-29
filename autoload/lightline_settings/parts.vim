function! lightline_settings#parts#Clipboard() abort
    return lightline_settings#IsClipboardEnabled() ? g:lightline_symbols.clipboard : ''
endfunction

function! lightline_settings#parts#Paste() abort
    return &paste ? g:lightline_symbols.paste : ''
endfunction

function! lightline_settings#parts#Spell() abort
    return &spell ? toupper(substitute(&spelllang, ',', '/', 'g')) : ''
endfunction

function! lightline_settings#parts#Indentation(...) abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = get(a:, 1, 0)
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! lightline_settings#parts#Readonly(...) abort
    return &readonly ? g:lightline_symbols.readonly . ' ' : ''
endfunction

function! lightline_settings#parts#Modified(...) abort
    if &modified
        if !&modifiable
            return '[+-]'
        else
            return '[+]'
        endif
    elseif !&modifiable
        return '[-]'
    endif

    return ''
endfunction

function! lightline_settings#parts#BufferType() abort
    return strlen(&filetype) ? &filetype : &buftype
endfunction

function! lightline_settings#parts#FileName() abort
    let fname = expand('%')

    if empty(fname)
        return '[No Name]'
    endif

    return fnamemodify(fname, ':~:.')
endfunction
