vim9script

export def Statusline(...args: list<any>): dict<any>
    var result = {section_a: 'Diff'}
    const bufname = expand('%:t')
    if exists('t:diffpanel') && t:diffpanel.bufname ==# bufname
        # https://github.com/mbbill/undotree
        result['section_b'] = t:diffpanel.GetStatusLine()
    elseif bufname ==# '__Gundo_Preview__'
        # https://github.com/sjl/gundo.vim
        result['section_a'] = 'Gundo Preview'
    endif
    return result
enddef
