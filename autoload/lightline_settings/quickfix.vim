vim9script

export def Statusline(...args: list<any>): dict<any>
    return {
        section_a: getwininfo(win_getid())[0]['loclist'] ? 'Location' : 'Quickfix',
        section_b: trim(get(w:, 'quickfix_title', '')),
    }
enddef
