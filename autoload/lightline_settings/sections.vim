function! lightline_settings#sections#Mode(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return l:mode['name']
    endif

    return lightline#concatenate([
                \ lightline_settings#parts#Mode(),
                \ lightline_settings#parts#Clipboard(),
                \ lightline_settings#parts#Paste(),
                \ lightline_settings#parts#Spell(),
                \ ], 0)
endfunction

function! lightline_settings#sections#Plugin(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        if has_key(l:mode, 'link')
            call lightline#link(l:mode['link'])
        else
            return get(l:mode, 'plugin', '')
        endif
    endif
    return call('s:RenderPluginSection', a:000)
endfunction

function! s:RenderPluginSection(...) abort
    return ''
endfunction

function! lightline_settings#sections#GitBranch(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    if winwidth(0) >= g:lightline_winwidth_config.small
        return lightline_settings#git#Branch()
    endif

    return ''
endfunction

function! lightline_settings#sections#FileName(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif
    return call('s:RenderFileNameSection', a:000)
endfunction

function! s:RenderFileNameSection(...) abort
    return lightline_settings#parts#FileName()
endfunction

function! lightline_settings#sections#FileType(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif
    return call('s:RenderFileTypeSection', a:000)
endfunction

function! s:RenderFileTypeSection(...) abort
    return lightline_settings#parts#FileType()
endfunction
