vim9script

# https://github.com/phongnh/ZoomWin
export def Status(zoomstate: any)
    const Z = function('lightline_settings#zoomwin#Status')
    for F in g:lightline_zoomwin_funcref
        if type(F) == v:t_func && F != Z
            F(zoomstate)
        endif
    endfor
    g:lightline_zoomstate = zoomstate
    lightline#update()
enddef
