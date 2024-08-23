function! s:InitPowerlineStyles() abort
    if exists('s:lightline_separator_styles')
        return
    endif

    let s:lightline_separator_styles = {
                \ 'default': { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ 'angle':   { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ 'curvy':   { 'left': "\ue0b4", 'right': "\ue0b6" },
                \ 'slant':   { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ '><':      { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ '>(':      { 'left': "\ue0b0", 'right': "\ue0b6" },
                \ '>\':      { 'left': "\ue0b0", 'right': "\ue0be" },
                \ '>/':      { 'left': "\ue0b0", 'right': "\ue0ba" },
                \ ')(':      { 'left': "\ue0b4", 'right': "\ue0b6" },
                \ ')<':      { 'left': "\ue0b4", 'right': "\ue0b2" },
                \ ')\':      { 'left': "\ue0b4", 'right': "\ue0be" },
                \ ')/':      { 'left': "\ue0b4", 'right': "\ue0ba" },
                \ '\\':      { 'left': "\ue0b8", 'right': "\ue0be" },
                \ '\/':      { 'left': "\ue0b8", 'right': "\ue0ba" },
                \ '\<':      { 'left': "\ue0b8", 'right': "\ue0b2" },
                \ '\(':      { 'left': "\ue0b8", 'right': "\ue0b6" },
                \ '//':      { 'left': "\ue0bc", 'right': "\ue0ba" },
                \ '/\':      { 'left': "\ue0bc", 'right': "\ue0be" },
                \ '/<':      { 'left': "\ue0bc", 'right': "\ue0b2" },
                \ '/(':      { 'left': "\ue0bc", 'right': "\ue0b6" },
                \ '||':      { 'left': '',       'right': ''       },
                \ }

    let s:lightline_subseparator_styles = {
                \ 'default': { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ 'angle':   { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ 'curvy':   { 'left': "\ue0b5", 'right': "\ue0b7" },
                \ 'slant':   { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ '><':      { 'left': "\ue0b1", 'right': "\ue0b3" },
                \ '>(':      { 'left': "\ue0b1", 'right': "\ue0b7" },
                \ '>\':      { 'left': "\ue0b1", 'right': "\ue0b9" },
                \ '>/':      { 'left': "\ue0b1", 'right': "\ue0bb" },
                \ ')(':      { 'left': "\ue0b5", 'right': "\ue0b7" },
                \ ')<':      { 'left': "\ue0b5", 'right': "\ue0b3" },
                \ ')\':      { 'left': "\ue0b5", 'right': "\ue0b9" },
                \ ')/':      { 'left': "\ue0b5", 'right': "\ue0bb" },
                \ '\\':      { 'left': "\ue0b9", 'right': "\ue0b9" },
                \ '\/':      { 'left': "\ue0b9", 'right': "\ue0bb" },
                \ '\<':      { 'left': "\ue0b9", 'right': "\ue0b3" },
                \ '\(':      { 'left': "\ue0b9", 'right': "\ue0b7" },
                \ '//':      { 'left': "\ue0bb", 'right': "\ue0bb" },
                \ '/\':      { 'left': "\ue0bd", 'right': "\ue0b9" },
                \ '/<':      { 'left': "\ue0bb", 'right': "\ue0b3" },
                \ '/(':      { 'left': "\ue0bb", 'right': "\ue0b7" },
                \ '||':      { 'left': '|',      'right': '|'      },
                \ }
endfunction

function! s:GetStyle(style) abort
    let l:style = 'default'

    if type(a:style) == v:t_string && strlen(a:style)
        let l:style = a:style
    endif

    if l:style ==? 'random'
        let l:rand = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
        let l:style = keys(s:lightline_separator_styles)[l:rand % len(s:lightline_separator_styles)]
    endif

    return l:style
endfunction

function! s:SetStatuslineSeparators(style) abort
    let l:style = s:GetStyle(a:style)

    let l:separator    = get(s:lightline_separator_styles, l:style, s:lightline_separator_styles['default'])
    let l:subseparator = get(s:lightline_subseparator_styles, l:style, s:lightline_subseparator_styles['default'])

    call extend(g:lightline, {
                \ 'separator':    deepcopy(l:separator),
                \ 'subseparator': deepcopy(l:subseparator),
                \ })
endfunction

function! s:SetTablineSeparators(style) abort
    let l:style = s:GetStyle(a:style)

    let l:separator    = get(s:lightline_separator_styles, l:style, s:lightline_separator_styles['default'])
    let l:subseparator = get(s:lightline_subseparator_styles, l:style, s:lightline_subseparator_styles['default'])

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
