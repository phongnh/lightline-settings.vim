vim9script

var lightline_separator_styles: dict<dict<string>>
var lightline_subseparator_styles: dict<dict<string>>
var styles_initialized = false

def InitPowerlineStyles()
    if styles_initialized
        return
    endif
    styles_initialized = true

    lightline_separator_styles = {
        default: {left: "\ue0b0", right: "\ue0b2"},
        angle:   {left: "\ue0b0", right: "\ue0b2"},
        curvy:   {left: "\ue0b4", right: "\ue0b6"},
        slant:   {left: "\ue0bc", right: "\ue0ba"},
        '><':      {left: "\ue0b0", right: "\ue0b2"},
        '>(':      {left: "\ue0b0", right: "\ue0b6"},
        '>\':      {left: "\ue0b0", right: "\ue0be"},
        '>/':      {left: "\ue0b0", right: "\ue0ba"},
        ')(':      {left: "\ue0b4", right: "\ue0b6"},
        ')<':      {left: "\ue0b4", right: "\ue0b2"},
        ')\':      {left: "\ue0b4", right: "\ue0be"},
        ')/':      {left: "\ue0b4", right: "\ue0ba"},
        '\\':      {left: "\ue0b8", right: "\ue0be"},
        '\/':      {left: "\ue0b8", right: "\ue0ba"},
        '\<':      {left: "\ue0b8", right: "\ue0b2"},
        '\(':      {left: "\ue0b8", right: "\ue0b6"},
        '//':      {left: "\ue0bc", right: "\ue0ba"},
        '/\':      {left: "\ue0bc", right: "\ue0be"},
        '/<':      {left: "\ue0bc", right: "\ue0b2"},
        '/(':      {left: "\ue0bc", right: "\ue0b6"},
        '||':      {left: '',       right: ''},
    }

    lightline_subseparator_styles = {
        default: {left: "\ue0b1", right: "\ue0b3"},
        angle:   {left: "\ue0b1", right: "\ue0b3"},
        curvy:   {left: "\ue0b5", right: "\ue0b7"},
        slant:   {left: "\ue0bb", right: "\ue0bb"},
        '><':      {left: "\ue0b1", right: "\ue0b3"},
        '>(':      {left: "\ue0b1", right: "\ue0b7"},
        '>\':      {left: "\ue0b1", right: "\ue0b9"},
        '>/':      {left: "\ue0b1", right: "\ue0bb"},
        ')(':      {left: "\ue0b5", right: "\ue0b7"},
        ')<':      {left: "\ue0b5", right: "\ue0b3"},
        ')\':      {left: "\ue0b5", right: "\ue0b9"},
        ')/':      {left: "\ue0b5", right: "\ue0bb"},
        '\\':      {left: "\ue0b9", right: "\ue0b9"},
        '\/':      {left: "\ue0b9", right: "\ue0bb"},
        '\<':      {left: "\ue0b9", right: "\ue0b3"},
        '\(':      {left: "\ue0b9", right: "\ue0b7"},
        '//':      {left: "\ue0bb", right: "\ue0bb"},
        '/\':      {left: "\ue0bd", right: "\ue0b9"},
        '/<':      {left: "\ue0bb", right: "\ue0b3"},
        '/(':      {left: "\ue0bb", right: "\ue0b7"},
        '||':      {left: '|',      right: '|'},
    }
enddef

def GetStyle(style: any): string
    var result = 'default'

    if type(style) == v:t_string && !empty(style)
        result = style
    endif

    if result ==? 'random'
        const rand = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1 :])
        result = keys(lightline_separator_styles)[rand % len(lightline_separator_styles)]
    endif

    return result
enddef

def SetStatuslineSeparators(style: any)
    const style_str = GetStyle(style)

    const separator    = get(lightline_separator_styles, style_str, lightline_separator_styles['default'])
    const subseparator = get(lightline_subseparator_styles, style_str, lightline_subseparator_styles['default'])

    extend(g:lightline, {
        separator:    deepcopy(separator),
        subseparator: deepcopy(subseparator),
    })
enddef

def SetTablineSeparators(style: any)
    const style_str = GetStyle(style)

    const separator    = get(lightline_separator_styles, style_str, lightline_separator_styles['default'])
    const subseparator = get(lightline_subseparator_styles, style_str, lightline_subseparator_styles['default'])

    extend(g:lightline, {
        tabline_separator:    deepcopy(separator),
        tabline_subseparator: deepcopy(subseparator),
    })
enddef

export def SetSeparators(style: any, ...args: list<any>)
    InitPowerlineStyles()
    SetStatuslineSeparators(style)
    SetTablineSeparators(get(args, 0, style))
enddef
