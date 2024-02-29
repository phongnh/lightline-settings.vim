function! s:InitPowerlineStyles() abort
    if exists('g:lightline_separator_styles')
        return
    endif

    let g:lightline_separator_styles = {
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

    let g:lightline_subseparator_styles = {
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

    call extend(g:lightline_separator_styles, {
                \ 'default': copy(g:lightline_separator_styles['><']),
                \ 'angle':   copy(g:lightline_separator_styles['><']),
                \ 'curvy':   copy(g:lightline_separator_styles[')(']),
                \ 'slant':   copy(g:lightline_separator_styles['//']),
                \ })

    call extend(g:lightline_subseparator_styles, {
                \ 'default': copy(g:lightline_subseparator_styles['><']),
                \ 'angle':   copy(g:lightline_subseparator_styles['><']),
                \ 'curvy':   copy(g:lightline_subseparator_styles[')(']),
                \ 'slant':   copy(g:lightline_subseparator_styles['//']),
                \ })
endfunction

function! s:GetStyle(style) abort
    let l:style = 'default'

    if type(a:style) == v:t_string && strlen(a:style)
        let l:style = a:style
    endif

    if l:style ==? 'random'
        let l:rand = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
        let l:style = keys(g:lightline_separator_styles)[l:rand % len(g:lightline_separator_styles)]
    endif

    return l:style
endfunction

function! s:SetStatuslineSeparators(style) abort
    let l:style = s:GetStyle(a:style)

    let l:separator    = get(g:lightline_separator_styles, l:style, g:lightline_separator_styles['default'])
    let l:subseparator = get(g:lightline_subseparator_styles, l:style, g:lightline_subseparator_styles['default'])

    call extend(g:lightline, {
                \ 'separator':    deepcopy(l:separator),
                \ 'subseparator': deepcopy(l:subseparator),
                \ })
endfunction

function! s:SetTablineSeparators(style) abort
    let l:style = s:GetStyle(a:style)

    let l:separator    = get(g:lightline_separator_styles, l:style, g:lightline_separator_styles['default'])
    let l:subseparator = get(g:lightline_subseparator_styles, l:style, g:lightline_subseparator_styles['default'])

    call extend(g:lightline, {
                \ 'tabline_separator':    deepcopy(l:separator),
                \ 'tabline_subseparator': deepcopy(l:subseparator),
                \ })
endfunction

function! lightline_settings#powerline#SetSeparators(style, ...) abort
    call s:InitPowerlineStyles()
    call s:SetStatuslineSeparators(a:style)
    call s:SetTablineSeparators(get(a:, 1, a:style))
endfunction
