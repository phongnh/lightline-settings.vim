" Theme mappings
let s:lightline_theme_mappings = extend({
            \ '^\(solarized\|soluarized\|flattened\|neosolarized\)': 'solarized',
            \ '^gruvbox$': 'gruvbox_material',
            \ '^gruvbox-baby$': 'gruvbox_material',
            \ '^gruvbox-baby': 'gruvbox',
            \ '^gruvbox': 'gruvbox',
            \ '^retrobox$': 'gruvbox',
            \ '^habamax$': 'deus',
            \ }, get(g:, 'lightline_theme_mappings', {}))

function! s:FindTheme() abort
    let g:lightline_theme = substitute(get(g:, 'colors_name', 'default'), '[ -]', '_', 'g')
    if index(s:lightline_themes, g:lightline_theme) > -1
        return
    endif

    let l:lightline_theme = g:lightline_theme . (&background == 'light' ? '_light' : '_dark')
    if index(s:lightline_themes, l:lightline_theme) > -1
        let g:lightline_theme = l:lightline_theme
        return
    endif

    for [l:pattern, l:theme] in items(s:lightline_theme_mappings)
        if match(g:lightline_theme, l:pattern) > -1 && index(s:lightline_themes, l:theme) > -1
            let g:lightline_theme = l:theme
            return
        endif
    endfor

    let g:lightline_theme = 'default'
endfunction

function! lightline_settings#theme#List(...) abort
    return join(s:lightline_themes, "\n")
endfunction

function! lightline_settings#theme#Set(theme) abort
    let g:lightline_theme = a:theme
    let g:lightline.colorscheme = g:lightline_theme
    " Reload palette
    let l:colorscheme_path = findfile(printf('autoload/lightline/colorscheme/%s.vim', g:lightline_theme), &rtp)
    if !empty(l:colorscheme_path) && filereadable(l:colorscheme_path)
        execute 'source' l:colorscheme_path
    endif
    call lightline_settings#ReloadLightline()
endfunction

function! lightline_settings#theme#Apply() abort
    if !exists('s:lightline_themes')
        let s:lightline_themes = map(split(globpath(&rtp, 'autoload/lightline/colorscheme/*.vim')), "fnamemodify(v:val, ':t:r')")
    endif
    call s:FindTheme()
    call lightline_settings#theme#Set(g:lightline_theme)
endfunction
