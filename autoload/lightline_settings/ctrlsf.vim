" https://github.com/dyng/ctrlsf.vim
function! lightline_settings#ctrlsf#Mode(...) abort
    let pattern = substitute(ctrlsf#utils#SectionB(), 'Pattern: ', '', '')

    let plugin_status = lightline#concatenate([
                \ pattern,
                \ ctrlsf#utils#SectionC(),
                \ ], 0)

    return {
                \ 'plugin': plugin_status,
                \ 'plugin_inactive': pattern,
                \ 'plugin_extra': ctrlsf#utils#SectionX(),
                \ }
endfunction

function! lightline_settings#ctrlsf#PreviewMode(...) abort
    let stl = ctrlsf#utils#PreviewSectionC()
    return {
                \ 'plugin': stl,
                \ 'plugin_inactive': stl,
                \ }
endfunction
