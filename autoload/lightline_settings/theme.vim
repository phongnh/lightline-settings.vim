vim9script

# Theme mappings
var lightline_theme_mappings = extend({
    '^\(solarized\|soluarized\|flattened\|neosolarized\)': 'solarized',
    '^gruvbox$': 'gruvbox_material',
    '^gruvbox-baby$': 'gruvbox_material',
    '^gruvbox-baby': 'gruvbox',
    '^gruvbox': 'gruvbox',
    '^retrobox$': 'gruvbox',
    '^habamax$': 'deus',
}, get(g:, 'lightline_theme_mappings', {}))

var lightline_themes: list<string>

def LoadThemes()
    if empty(lightline_themes)
        lightline_themes = map(split(globpath(&rtp, 'autoload/lightline/colorscheme/*.vim')), "fnamemodify(v:val, ':t:r')")
    endif
enddef

def FindTheme()
    g:lightline_theme = tr(get(g:, 'colors_name', 'default'), ' -', '__')
    if index(lightline_themes, g:lightline_theme) > -1
        return
    endif

    var lightline_theme_var = g:lightline_theme .. (&background == 'light' ? '_light' : '_dark')
    if index(lightline_themes, lightline_theme_var) > -1
        g:lightline_theme = lightline_theme_var
        return
    endif

    for [pattern, theme] in items(lightline_theme_mappings)
        if match(g:lightline_theme, pattern) > -1 && index(lightline_themes, theme) > -1
            g:lightline_theme = theme
            return
        endif
    endfor

    g:lightline_theme = 'default'
enddef

export def List(...args: list<any>): string
    return join(lightline_themes, "\n")
enddef

export def Set(theme: string)
    g:lightline_theme = theme
    # Reload palette
    var colorscheme_path = findfile(printf('autoload/lightline/colorscheme/%s.vim', theme), &rtp)
    if !empty(colorscheme_path) && filereadable(colorscheme_path)
        if exists('g:lightline')
            g:lightline.colorscheme = g:lightline_theme
        endif
        execute 'source' colorscheme_path
    endif
    lightline_settings#ReloadLightline()
enddef

export def Apply()
    LoadThemes()
    FindTheme()
    Set(g:lightline_theme)
enddef

export def Detect()
    if has('vim_starting') && exists('g:lightline_theme') && g:lightline_theme ==# 'default'
        LoadThemes()
        FindTheme()
        if g:lightline_theme !=# 'default'
            Set(g:lightline_theme)
        endif
    elseif !exists('g:lightline_theme')
        Apply()
    endif
enddef
