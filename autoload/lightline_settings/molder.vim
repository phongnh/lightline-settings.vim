vim9script

# https://github.com/mattn/vim-molder
export def Mode(...args: list<any>): dict<any>
    return {section_a: 'Molder', section_c: exists('b:molder_dir') ? fnamemodify(b:molder_dir, ':p:~:.:h') : ''}
enddef
