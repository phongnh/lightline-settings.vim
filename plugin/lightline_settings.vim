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
