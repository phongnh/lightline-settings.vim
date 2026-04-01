vim9script

# https://github.com/preservim/tagbar
var lightline_tagbar: dict<any> = {}

export def Status(current: any, sort: any, fname: any, flags: any, ...args: list<any>): string
    lightline_tagbar.sort  = sort
    lightline_tagbar.fname = fname
    lightline_tagbar.flags = flags

    return lightline#statusline(0)
enddef

export def Statusline(...args: list<any>): dict<any>
    var flags: string
    if empty(lightline_tagbar.flags)
        flags = ''
    elseif type(lightline_tagbar.flags) == v:t_list
        flags = '[' .. join(lightline_tagbar.flags, '') .. ']'
    else
        flags = '[' .. string(lightline_tagbar.flags) .. ']'
    endif

    return {
        section_a: lightline_tagbar.sort,
        section_b: flags,
        section_c: lightline_tagbar.fname,
    }
enddef
