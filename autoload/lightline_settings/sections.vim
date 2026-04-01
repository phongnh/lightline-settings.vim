function! lightline_settings#sections#SectionA(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return l:integration['section_a']
    endif

    return lightline#concatenate([
                \   lightline_settings#components#Mode(),
                \   lightline_settings#components#Clipboard(),
                \   lightline_settings#components#Paste(),
                \ ], 0)
endfunction

function! lightline_settings#sections#SectionB(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return get(l:integration, 'section_b', '')
    endif

    if lightline_settings#GetWinWidth(0) >= g:lightline_winwidth_config.default
        return lightline_settings#components#GitBranch()
    endif

    return ''
endfunction

function! lightline_settings#sections#SectionC(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return get(l:integration, 'section_c', '')
    endif

    return lightline_settings#components#FileName()
endfunction

function! lightline_settings#sections#SectionX(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return get(l:integration, 'section_x', '')
    endif

    if lightline_settings#GetWinWidth(0) <= g:lightline_winwidth_config.compact
        return ''
    endif

    if g:lightline_show_linenr > 1
        return lightline_settings#components#Ruler()
    elseif g:lightline_show_linenr > 0
        return lightline_settings#components#Position()
    endif
    return ''
endfunction

function!  lightline_settings#sections#SectionY(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return get(l:integration, 'section_y', '')
    endif

    return lightline#concatenate([
                \   lightline_settings#components#Spell(),
                \   lightline_settings#components#Indentation(),
                \   lightline_settings#components#FileEncodingAndFormat(),
                \ ], 1)
endfunction

function!  lightline_settings#sections#SectionZ(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return get(l:integration, 'section_z', '')
    endif

    return lightline_settings#components#FileType()
endfunction

function!  lightline_settings#sections#InactiveSectionA(...) abort
    let l:integration = lightline_settings#components#Integration()
    if len(l:integration)
        return lightline#concatenate([
                    \   l:integration['section_a'],
                    \   get(l:integration, 'section_b', ''),
                    \   get(l:integration, 'section_c', ''),
                    \ ], 0)
    endif

    " plugin/statusline.vim[+]
    return lightline_settings#components#InactiveFileName()
endfunction
