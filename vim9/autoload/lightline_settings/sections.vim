vim9script

export def SectionA(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return integration['section_a']
    endif

    return lightline#concatenate([
        lightline_settings#components#Mode(),
        lightline_settings#components#Clipboard(),
        lightline_settings#components#Paste(),
    ], 0)
enddef

export def SectionB(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return get(integration, 'section_b', '')
    endif

    if g:lightline_show_git_branch > 0 && lightline_settings#GetWinWidth(0) >= g:lightline_winwidth_config.default
        return lightline_settings#components#Branch()
    endif

    return ''
enddef

export def SectionC(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return get(integration, 'section_c', '')
    endif

    return lightline_settings#components#FileName()
enddef

export def SectionX(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return get(integration, 'section_x', '')
    endif

    if lightline_settings#GetWinWidth(0) > g:lightline_winwidth_config.compact
        if g:lightline_show_linenr > 1
            return lightline_settings#components#Ruler()
        elseif g:lightline_show_linenr > 0
            return lightline_settings#components#Position()
        endif
    endif

    return ''
enddef

export def SectionY(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return get(integration, 'section_y', '')
    endif

    return lightline#concatenate([
        lightline_settings#components#Spell(),
        lightline_settings#components#Indentation(),
        lightline_settings#components#FileEncodingAndFormat(),
    ], 1)
enddef

export def SectionZ(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return get(integration, 'section_z', '')
    endif

    return lightline_settings#components#FileType()
enddef

export def InactiveSectionA(...args: list<any>): string
    const integration = lightline_settings#components#Integration()
    if !empty(integration)
        return lightline#concatenate([
            integration['section_a'],
            get(integration, 'section_b', ''),
            get(integration, 'section_c', ''),
        ], 0)
    endif

    # plugin/statusline.vim[+]
    return lightline_settings#components#InactiveFileName()
enddef
