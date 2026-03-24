vim9script

# https://github.com/liuchengxu/vista.vim
export def Mode(...args: list<any>): dict<any>
    const provider = get(get(g:, 'vista', {}), 'provider', '')
    return {section_a: 'Vista', section_b: provider}
enddef
