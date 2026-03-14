" https://github.com/dyng/ctrlsf.vim
function! lightline_settings#ctrlsf#Mode(...) abort
    return {
                \ 'name':     'CtrlSF',
                \ 'plugin':   substitute(ctrlsf#utils#SectionB(), 'Pattern: ', '', ''),
                \ 'filename': fnamemodify(ctrlsf#utils#SectionC(), ':p:~:.'),
                \ 'buffer':   ctrlsf#utils#SectionX(),
                \ }
endfunction

function! lightline_settings#ctrlsf#PreviewMode(...) abort
    return { 'name': 'Preview', 'filename': fnamemodify(ctrlsf#utils#PreviewSectionC(), ':~:.') }
endfunction
