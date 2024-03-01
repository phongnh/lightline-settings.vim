" lightline_settings.vim
" Maintainer: Phong Nguyen
" Version:    0.1.0

if exists('g:loaded_vim_lightline_settings') || v:version < 700
    finish
endif

let g:loaded_vim_lightline_settings = 1

let s:save_cpo = &cpo
set cpo&vim

call lightline_settings#Setup()

function! LightlineFileNameStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    return lightline_settings#parts#FileName()
endfunction

function! LightlineFileInfoStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    return lightline_settings#parts#FileInfo()
endfunction

function! LightlineLineInfoStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    return lightline_settings#parts#SimpleLineInfo()
endfunction

function! LightlineBufferStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'buffer', '')
    endif

    return lightline_settings#parts#Indentation(lightline_settings#IsCompact())
endfunction

function! LightlinePluginExtraStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'plugin_extra', '')
    endif

    return ''
endfunction

function! LightlineInactiveStatus() abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        if has_key(l:mode, 'plugin_inactive')
            return lightline#concatenate(
                        \ [
                        \   l:mode['name'],
                        \   get(l:mode, 'plugin_inactive', '')
                        \ ], 0)
        endif
        return l:mode['name']
    endif

    return lightline_settings#parts#InactiveFileName()
endfunction

command! LightlineReload call lightline_settings#Reload()
command! -nargs=1 -complete=custom,lightline_settings#theme#ListColorschemes LightlineTheme call lightline_settings#theme#Set(<f-args>)

augroup LightlineSettings
    autocmd!
    autocmd VimEnter * call lightline_settings#Init()
    autocmd VimEnter * call lightline_settings#theme#Reload()
    autocmd ColorScheme * call lightline_settings#theme#Reload()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
