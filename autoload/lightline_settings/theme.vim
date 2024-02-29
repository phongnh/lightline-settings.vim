function! s:FindLightlineThemes() abort
    if exists('s:lightline_colorschemes')
        return s:lightline_colorschemes
    endif
    let s:lightline_colorschemes = map(split(globpath(&rtp, 'autoload/lightline/colorscheme/*.vim')), "fnamemodify(v:val, ':t:r')")
    let s:lightline_colorschemes_completion = join(s:lightline_colorschemes, "\n")
endfunction

function! lightline_settings#theme#ListColorschemes(...) abort
    return s:lightline_colorschemes_completion
endfunction

let g:lightline_colorscheme_mappings = get(g:, 'lightline_colorscheme_mappings', {})

function! s:DetectLightlineTheme() abort
    let l:original_colorscheme = get(g:, 'colors_name', '')

    if has('vim_starting') && exists('g:lightline_theme')
        let l:original_colorscheme = g:lightline_theme
    endif

    if l:original_colorscheme =~ 'solarized\|soluarized\|flattened'
        let l:original_colorscheme = 'solarized'
    endif

    let l:colorscheme = l:original_colorscheme
    if index(s:lightline_colorschemes, l:colorscheme) > -1
        return l:colorscheme
    endif

    let l:colorscheme = tolower(l:original_colorscheme)
    if index(s:lightline_colorschemes, l:colorscheme) > -1
        return l:colorscheme
    endif

    for l:alternative_colorscheme in get(g:lightline_colorscheme_mappings, l:colorscheme, [])
        if index(s:lightline_colorschemes, l:alternative_colorscheme) > -1
            return l:alternative_colorscheme
        endif
    endfor

    let l:colorscheme = substitute(l:original_colorscheme, '-', '_', 'g')
    if index(s:lightline_colorschemes, l:colorscheme) > -1
        return l:colorscheme
    endif

    return substitute(l:original_colorscheme, '-', '', 'g')
endfunction

function! lightline_settings#theme#Set(colorscheme) abort
    if index(s:lightline_colorschemes, a:colorscheme) < 0
        return
    endif

    " Reload palette
    let l:colorscheme_path = findfile(printf('autoload/lightline/colorscheme/%s.vim', a:colorscheme), &rtp)
    if !empty(l:colorscheme_path) && filereadable(l:colorscheme_path)
        execute 'source ' . l:colorscheme_path
    endif

    let g:lightline.colorscheme = a:colorscheme
    call lightline_settings#Reload()
endfunction


function! lightline_settings#theme#Reload() abort
    call s:FindLightlineThemes()

    let l:colorscheme = s:DetectLightlineTheme()

    call lightline_settings#theme#Set(l:colorscheme)
endfunction
