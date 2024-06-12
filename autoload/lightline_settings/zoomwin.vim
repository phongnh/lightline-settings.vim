" https://github.com/phongnh/ZoomWin
function! lightline_settings#zoomwin#Status(zoomstate) abort
    for F in g:lightline_zoomwin_funcref
        if type(F) == v:t_func && F != function('lightline_settings#zoomwin#Status')
            call F(a:zoomstate)
        endif
    endfor
    let g:lightline_zoomed = a:zoomstate
    if exists('*lightline#update')
        call lightline#update()
    endif
endfunction
