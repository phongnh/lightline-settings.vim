vim9script

export def SectionA(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return integration['section_a']
    endif

    return lightline#concatenate([
        lightline_settings#parts#Mode(),
        lightline_settings#parts#Clipboard(),
        lightline_settings#parts#Paste(),
    ], 0)
enddef

export def SectionB(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return get(integration, 'section_b', '')
    endif

    if lightline_settings#GetWinWidth(0) >= g:lightline_winwidth_config.default
        return lightline_settings#parts#GitBranch()
    endif

    return ''
enddef

export def SectionC(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return get(integration, 'section_c', '')
    endif

    return lightline_settings#parts#FileName()
enddef

export def SectionX(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return get(integration, 'section_x', '')
    endif

    if lightline_settings#GetWinWidth(0) <= g:lightline_winwidth_config.compact
        return ''
    endif

    return lightline_settings#parts#LineInfo()
enddef

export def SectionY(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return get(integration, 'section_y', '')
    endif

    return lightline#concatenate([
        lightline_settings#parts#Spell(),
        lightline_settings#parts#Indentation(),
        lightline_settings#parts#FileEncodingAndFormat(),
    ], 1)
enddef

export def SectionZ(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return get(integration, 'section_z', '')
    endif

    return lightline_settings#parts#FileType()
enddef

export def InactiveSectionA(...args: list<any>): string
    const integration = lightline_settings#parts#Integration()
    if !empty(integration)
        return lightline#concatenate([
            integration['section_a'],
            get(integration, 'section_b', ''),
            get(integration, 'section_c', ''),
        ], 0)
    endif

    # plugin/statusline.vim[+]
    return lightline_settings#parts#InactiveFileName()
enddef
