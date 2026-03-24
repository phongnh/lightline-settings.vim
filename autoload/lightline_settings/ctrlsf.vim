vim9script

# https://github.com/dyng/ctrlsf.vim
export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: 'CtrlSF',
        section_b: substitute(call('ctrlsf#utils#SectionB', []), 'Pattern: ', '', ''),
        section_c: fnamemodify(call('ctrlsf#utils#SectionC', []), ':p:~:.'),
        section_z: call('ctrlsf#utils#SectionX', []),
    }
enddef

export def PreviewStatusline(...args: list<any>): dict<any>
    return {section_a: 'Preview', section_c: fnamemodify(call('ctrlsf#utils#PreviewSectionC', []), ':~:.')}
enddef
