vim9script

# https://github.com/justinmk/vim-dirvish
export def Mode(...args: list<any>): dict<any>
    return {section_a: 'Dirvish', section_c: expand('%:p:~:.:h')}
enddef
