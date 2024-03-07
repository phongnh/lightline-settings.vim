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
        endif
        return get(l:mode, 'plugin', '')
    endif
    return call('s:RenderPluginSection', a:000)
endfunction

function! s:RenderPluginSection(...) abort
    return lightline_settings#parts#FileName()
endfunction

function! lightline_settings#sections#GitBranch(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return ''
    endif

    if winwidth(0) >= g:lightline_winwidth_config.default
        return lightline_settings#parts#GitBranch()
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
    return ''
endfunction

function!  lightline_settings#sections#Buffer(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'buffer', '')
    endif
    return call('s:RenderBufferSection', a:000)
endfunction

function! s:RenderBufferSection(...) abort
    return lightline_settings#parts#FileType()
endfunction

function!  lightline_settings#sections#Settings(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'settings', '')
    endif
    return call('s:RenderSettingsSection', a:000)
endfunction

function! s:RenderSettingsSection(...) abort
    return lightline#concatenate([
                \ lightline_settings#parts#Indentation(),
                \ lightline_settings#parts#FileEncodingAndFormat(),
                \ ], 1)
endfunction

function! lightline_settings#sections#Info(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return get(l:mode, 'info', '')
    endif
    return call('s:RenderInfoSection', a:000)
endfunction

function! s:RenderInfoSection(...) abort
    if winwidth(0) <= g:lightline_winwidth_config.compact
        return ''
    endif
    return lightline_settings#parts#LineInfo()
endfunction

function!  lightline_settings#sections#InactiveMode(...) abort
    let l:mode = lightline_settings#parts#Integration()
    if len(l:mode)
        return lightline#concatenate([
                    \ l:mode['name'],
                    \ get(l:mode, 'plugin', ''),
                    \ get(l:mode, 'filename', ''),
                    \ ], 0)
    endif
    return call('s:RenderInactiveModeSection', a:000)
endfunction

function! s:RenderInactiveModeSection(...) abort
    " plugin/statusline.vim[+]
    return lightline_settings#parts#InactiveFileName()
endfunction
