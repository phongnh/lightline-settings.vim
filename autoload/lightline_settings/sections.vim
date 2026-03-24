function! lightline_settings#sections#SectionA(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return l:integration['section_a']
    endif

    return lightline#concatenate([
                \   lightline_settings#parts#Mode(),
                \   lightline_settings#parts#Clipboard(),
                \   lightline_settings#parts#Paste(),
                \ ], 0)
endfunction

function! lightline_settings#sections#SectionB(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return get(l:integration, 'section_b', '')
    endif

    if lightline_settings#GetWinWidth(0) >= g:lightline_winwidth_config.default
        return lightline_settings#parts#GitBranch()
    endif

    return ''
endfunction

function! lightline_settings#sections#SectionC(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return get(l:integration, 'section_c', '')
    endif

    return lightline_settings#parts#FileName()
endfunction

function! lightline_settings#sections#SectionX(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return get(l:integration, 'section_x', '')
    endif

    if lightline_settings#GetWinWidth(0) <= g:lightline_winwidth_config.compact
        return ''
    endif

    return lightline_settings#parts#LineInfo()
endfunction

function!  lightline_settings#sections#SectionY(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return get(l:integration, 'section_y', '')
    endif

    return lightline#concatenate([
                \   lightline_settings#parts#Spell(),
                \   lightline_settings#parts#Indentation(),
                \   lightline_settings#parts#FileEncodingAndFormat(),
                \ ], 1)
endfunction

function!  lightline_settings#sections#SectionZ(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return get(l:integration, 'section_z', '')
    endif

    return lightline_settings#parts#FileType()
endfunction

function!  lightline_settings#sections#InactiveSectionA(...) abort
    let l:integration = lightline_settings#parts#Integration()
    if len(l:integration)
        return lightline#concatenate([
                    \   l:integration['section_a'],
                    \   get(l:integration, 'section_b', ''),
                    \   get(l:integration, 'section_c', ''),
                    \ ], 0)
    endif

    " plugin/statusline.vim[+]
    return lightline_settings#parts#InactiveFileName()
endfunction
