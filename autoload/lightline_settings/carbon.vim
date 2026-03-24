vim9script

# https://github.com/SidOfc/carbon.nvim
export def Mode(...args: list<any>): dict<any>
    return {section_a: 'Carbon', section_c: exists('b:carbon') ? fnamemodify(b:carbon['path'], ':p:~:.:h') : ''}
enddef
