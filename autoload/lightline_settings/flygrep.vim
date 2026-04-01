" https://github.com/wsdjeg/FlyGrep.vim
function! lightline_settings#flygrep#Statusline(...) abort
    return {
                \ 'section_a': 'FlyGrep',
                \ 'section_b': SpaceVim#plugins#flygrep#mode(),
                \ 'section_c': fnamemodify(getcwd(), ':~'),
                \ 'section_z': SpaceVim#plugins#flygrep#lineNr(),
                \ }
endfunction
