function! s:InitPowerlineStyles() abort
    let s:statusline_separator_styles = {
                \ '><': { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ '>(': { 'left': "\ue0b0", 'right': "\ue0b6" },
                \ '>\': { 'left': "\ue0b0", 'right': "\ue0be" },
                \ '>/': { 'left': "\ue0b0", 'right': "\ue0ba" },
                \ ')(': { 'left': "\ue0b4", 'right': "\ue0b6" },
                \ ')<': { 'left': "\ue0b4", 'right': "\ue0b2" },
                \ ')\': { 'left': "\ue0b4", 'right': "\ue0be" },
                \ ')/': { 'left': "\ue0b4", 'right': "\ue0ba" },
                \ '\\': { 'left': "\ue0b8", 'right': "\ue0be" },
                \ '\/': { 'left': "\ue0b8", 'right': "\ue0ba" },
                \ '\<': { 'left': "\ue0b8", 'right': "\ue0b2" },
                \ '\(': { 'left': "\ue0b8", 'right': "\ue0b6" },
                \ '//': { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ '/\': { 'left': "\ue0bc", 'right': "\ue0be" },
                \ '/<': { 'left': "\ue0bc", 'right': "\ue0b2" },
                \ '/(': { 'left': "\ue0bc", 'right': "\ue0b6" },
                \ '||': { 'left': '', 'right': '' },
                \ }

    let s:statusline_subseparator_styles = {
                \ '><': { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ '>(': { 'left': "\ue0b1", 'right': "\ue0b7" },
                \ '>\': { 'left': "\ue0b1", 'right': "\ue0b9" },
                \ '>/': { 'left': "\ue0b1", 'right': "\ue0bb" },
                \ ')(': { 'left': "\ue0b5", 'right': "\ue0b7" },
                \ ')<': { 'left': "\ue0b5", 'right': "\ue0b1" },
                \ ')\': { 'left': "\ue0b5", 'right': "\ue0b9" },
                \ ')/': { 'left': "\ue0b5", 'right': "\ue0bb" },
                \ '\\': { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ '\/': { 'left': "\ue0b9", 'right': "\ue0bb" },
                \ '\<': { 'left': "\ue0b9", 'right': "\ue0b3" },
                \ '\(': { 'left': "\ue0b9", 'right': "\ue0b7" },
                \ '//': { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ '/\': { 'left': "\ue0bd", 'right': "\ue0b9" },
                \ '/<': { 'left': "\ue0bb", 'right': "\ue0b3" },
                \ '/(': { 'left': "\ue0bb", 'right': "\ue0b7" },
                \ '||': { 'left': '|', 'right': '|' },
                \ }

    call extend(s:statusline_separator_styles, {
                \ 'default': copy(s:statusline_separator_styles['><']),
                \ 'angle':   copy(s:statusline_separator_styles['><']),
                \ 'curvy':   copy(s:statusline_separator_styles[')(']),
                \ 'slant':   copy(s:statusline_separator_styles['//']),
                \ })

    call extend(s:statusline_subseparator_styles, {
                \ 'default': copy(s:statusline_subseparator_styles['><']),
                \ 'angle':   copy(s:statusline_subseparator_styles['><']),
                \ 'curvy':   copy(s:statusline_subseparator_styles[')(']),
                \ 'slant':   copy(s:statusline_subseparator_styles['//']),
                \ })

    let s:tabline_separator_styles = deepcopy(s:statusline_separator_styles)

    let s:tabline_subseparator_styles = deepcopy(s:statusline_subseparator_styles)
endfunction

function! s:Rand() abort
    return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfunction

function! s:GetStyle(style) abort
    if type(a:style) == type([])
        let l:statusline_style = get(a:style, 0, 'default')
        let l:tabline_style = get(a:style, 1, 'default')
    elseif type(a:style) == type('')
        let l:statusline_style = a:style
        let l:tabline_style = a:style
    else
        let l:statusline_style = 'default'
        let l:tabline_style = 'default'
    endif

    if empty(l:statusline_style)
        let l:statusline_style = 'default'
    endif

    if empty(l:tabline_style)
        let l:tabline_style = 'default'
    endif

    if l:statusline_style ==? 'random'
        let l:statusline_style = keys(s:statusline_separator_styles)[s:Rand() % len(s:statusline_separator_styles)]
    endif

    if l:tabline_style ==? 'random'
        let l:tabline_style = keys(s:tabline_separator_styles)[s:Rand() % len(s:tabline_separator_styles)]
    endif

    return [l:statusline_style, l:tabline_style]
endfunction

function! s:SetSeparator(statusline_style, tabline_style) abort
    let l:statusline_separator    = get(s:statusline_separator_styles, a:statusline_style, s:statusline_separator_styles['default'])
    let l:statusline_subseparator = get(s:statusline_subseparator_styles, a:statusline_style, s:statusline_subseparator_styles['default'])

    let l:tabline_separator    = get(s:tabline_separator_styles, a:tabline_style, s:tabline_separator_styles['default'])
    let l:tabline_subseparator = get(s:tabline_subseparator_styles, a:tabline_style, s:tabline_subseparator_styles['default'])

    call extend(g:lightline, {
                \ 'separator':            l:statusline_separator,
                \ 'subseparator':         l:statusline_subseparator,
                \ 'tabline_separator':    l:tabline_separator,
                \ 'tabline_subseparator': l:tabline_subseparator,
                \ })
endfunction

function! lightline_settings#SetPowerlineSeparators(style) abort
    call s:InitPowerlineStyles()

    let [l:statusline_style, l:tabline_style] = s:GetStyle(a:style)

    call s:SetSeparator(l:statusline_style, l:tabline_style)
endfunction
