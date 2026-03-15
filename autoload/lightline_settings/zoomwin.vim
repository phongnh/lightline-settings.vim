" https://github.com/phongnh/ZoomWin
function! lightline_settings#zoomwin#Status(zoomstate) abort
    let l:Z = function('lightline_settings#zoomwin#Status')
    for l:F in g:lightline_zoomwin_funcref
        if type(l:F) == v:t_func && l:F != l:Z
            call l:F(a:zoomstate)
        endif
    endfor
    let b:lightline_zoomstate = a:zoomstate
    call lightline#update()
endfunction
