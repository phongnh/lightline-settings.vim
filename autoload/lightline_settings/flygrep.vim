" https://github.com/wsdjeg/FlyGrep.vim
function! lightline_settings#flygrep#Mode(...) abort
    return {
                \ 'name':     'FlyGrep',
                \ 'plugin':   SpaceVim#plugins#flygrep#mode(),
                \ 'filename': fnamemodify(getcwd(), ':~'),
                \ 'buffer':   SpaceVim#plugins#flygrep#lineNr(),
                \ }
endfunction
