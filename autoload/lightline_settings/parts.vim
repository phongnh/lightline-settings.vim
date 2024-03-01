function! lightline_settings#parts#Mode() abort
    if lightline_settings#IsCompact()
        return get(g:lightline_short_mode_map, mode(), '')
    else
        return lightline#mode()
    endif
endfunction

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

function! lightline_settings#parts#SimpleLineInfo(...) abort
    return printf('%3d:%-3d', line('.'), col('.'))
endfunction

function! lightline_settings#parts#LineInfo(...) abort
    if line('w0') == 1 && line('w$') == line('$')
        let l:percent = 'All'
    elseif line('w0') == 1
        let l:percent = 'Top'
    elseif line('w$') == line('$')
        let l:percent = 'Bot'
    else
        let l:percent = printf('%d%%', line('.') * 100 / line('$'))
    endif

    return printf('%4d:%-3d %3s', line('.'), col('.'), l:percent)
endfunction

function! lightline_settings#parts#FileEncodindAndFormat() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:bomb     = &bomb ? '[BOM]' : ''
    let l:format   = strlen(&fileformat) ? printf('[%s]', &fileformat) : ''

    " Skip common string utf-8[unix]
    if (l:encoding . l:format) ==# 'utf-8[unix]'
        return l:bomb
    endif

    return l:encoding . l:bomb . l:format
endfunction

function! lightline_settings#parts#FileType(...) abort
    return lightline_settings#BufferType() . lightline_settings#devicons#FileType(expand('%'))
endfunction

function! lightline_settings#parts#FileInfo(...) abort
    let parts = [
                \ lightline_settings#parts#FileEncodindAndFormat(),
                \ lightline_settings#parts#FileType(),
                \ ]
    return join(filter(copy(parts), 'v:val !=# ""'), ' ')
endfunction
