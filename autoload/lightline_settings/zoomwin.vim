" https://github.com/phongnh/ZoomWin
function! lightline_settings#zoomwin#Status(zoomstate) abort
    for l:F in g:lightline_zoomwin_funcref
        if type(l:F) == v:t_func && l:F != function('lightline_settings#zoomwin#Status')
            call l:F(a:zoomstate)
        endif
    endfor
    let g:lightline_zoomed = a:zoomstate
    if exists('*lightline#update')
        call lightline#update()
    endif
endfunction
