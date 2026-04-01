" https://github.com/dyng/ctrlsf.vim
function! lightline_settings#ctrlsf#Statusline(...) abort
    return {
                \ 'section_a': 'CtrlSF',
                \ 'section_b': substitute(ctrlsf#utils#SectionB(), 'Pattern: ', '', ''),
                \ 'section_c': fnamemodify(ctrlsf#utils#SectionC(), ':p:~:.'),
                \ 'section_z': ctrlsf#utils#SectionX(),
                \ }
endfunction

function! lightline_settings#ctrlsf#PreviewStatusline(...) abort
    return { 'section_a': 'Preview', 'section_c': fnamemodify(ctrlsf#utils#PreviewSectionC(), ':~:.') }
endfunction
