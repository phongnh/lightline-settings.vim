function! s:BufferType() abort
    return strlen(&filetype) ? &filetype : &buftype
endfunction

function! s:FileName() abort
    let fname = expand('%')
    return strlen(fname) ? fnamemodify(fname, ':~:.') : '[No Name]'
endfunction

function! s:IsClipboardEnabled() abort
    return match(&clipboard, 'unnamed') > -1
endfunction

function! s:IsCompact(...) abort
    let l:winnr = get(a:, 1, 0)
    return winwidth(l:winnr) <= g:lightline_winwidth_config.compact ||
                \ count([
                \   s:IsClipboardEnabled(),
                \   &paste,
                \   &spell,
                \   &bomb,
                \   !&eol,
                \ ], 1) > 1
endfunction

function! lightline_settings#parts#Mode() abort
    if s:IsCompact()
        return get(g:lightline_short_mode_map, mode(), '')
    else
        return lightline#mode()
    endif
endfunction

function! lightline_settings#parts#Clipboard() abort
    return s:IsClipboardEnabled() ? g:lightline_symbols.clipboard : ''
endfunction

function! lightline_settings#parts#Paste() abort
    return &paste ? g:lightline_symbols.paste : ''
endfunction

function! lightline_settings#parts#Spell() abort
    return &spell ? toupper(substitute(&spelllang, ',', '/', 'g')) : ''
endfunction

function! lightline_settings#parts#Indentation(...) abort
    let l:shiftwidth = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
    let compact = get(a:, 1, s:IsCompact())
    if compact
        return printf(&expandtab ? 'SPC: %d' : 'TAB: %d', l:shiftwidth)
    else
        return printf(&expandtab ? 'Spaces: %d' : 'Tab Size: %d', l:shiftwidth)
    endif
endfunction

function! lightline_settings#parts#Readonly(...) abort
    return &readonly ? g:lightline_symbols.readonly . ' ' : ''
endfunction

function! lightline_settings#parts#Modified(...) abort
    if &modified
        return !&modifiable ? '[+-]' : '[+]'
    else
        return !&modifiable ? '[-]' : ''
    endif
endfunction

function! lightline_settings#parts#Zoomed(...) abort
    return get(g:, 'lightline_zoomed', 0) ? '[Z]' : ''
endfunction

function! s:SimpleLineInfo(...) abort
    return printf('%3d:%-3d', line('.'), col('.'))
endfunction

function! s:FullLineInfo(...) abort
    if line('w0') == 1 && line('w$') == line('$')
        let l:percent = 'All'
    elseif line('w0') == 1
        let l:percent = 'Top'
    elseif line('w$') == line('$')
        let l:percent = 'Bot'
    else
        let l:percent = printf('%d%%', line('.') * 100 / line('$'))
    endif

    return printf('%4d:%-3d %3s', line('.'), col('.'), l:percent)
endfunction

function! lightline_settings#parts#LineInfo(...) abort
    return ''
endfunction

function! lightline_settings#parts#FileEncodingAndFormat() abort
    let l:encoding = strlen(&fileencoding) ? &fileencoding : &encoding
    let l:encoding = (l:encoding ==# 'utf-8') ? '' : l:encoding . ' '
    let l:bomb     = &bomb ? g:lightline_symbols.bomb . ' ' : ''
    let l:noeol    = &eol ? '' : g:lightline_symbols.noeol . ' '
    let l:format   = get(g:lightline_symbols, &fileformat, '[empty]')
    let l:format   = (l:format ==# '[unix]') ? '' : l:format . ' '
    return l:encoding . l:bomb . l:noeol . l:format
endfunction

function! lightline_settings#parts#FileType(...) abort
    return s:BufferType() . lightline_settings#devicons#FileType(expand('%'))
endfunction

function! lightline_settings#parts#FileName(...) abort
    return lightline_settings#parts#Readonly() . lightline_settings#FormatFileName(s:FileName()) . lightline_settings#parts#Modified() . lightline_settings#parts#Zoomed()
endfunction

function! lightline_settings#parts#InactiveFileName(...) abort
    return lightline_settings#parts#Readonly() . s:FileName() . lightline_settings#parts#Modified()
endfunction

function! lightline_settings#parts#Integration() abort
    let fname = expand('%:t')

    if has_key(g:lightline_filename_modes, fname)
        let result = { 'name': g:lightline_filename_modes[fname] }

        if has_key(g:lightline_filename_integrations, fname)
            return extend(result, function(g:lightline_filename_integrations[fname])())
        endif

        return result
    endif

    if fname =~# '^NrrwRgn_\zs.*\ze_\d\+$'
        return lightline_settings#nrrwrgn#Mode()
    endif

    let ft = s:BufferType()

    if ft ==# 'undotree' && exists('*t:undotree.GetStatusLine')
        return lightline_settings#undotree#Mode()
    endif

    if ft ==# 'diff' && exists('*t:diffpanel.GetStatusLine')
        return lightline_settings#undotree#DiffStatus()
    endif

    if has_key(g:lightline_filetype_modes, ft)
        let result = { 'name': g:lightline_filetype_modes[ft] }

        if has_key(g:lightline_filetype_integrations, ft)
            return extend(result, function(g:lightline_filetype_integrations[ft])())
        endif

        return result
    endif

    return {}
endfunction

function! lightline_settings#parts#GitBranch(...) abort
    return ''
endfunction

function! lightline_settings#parts#Init() abort
    if g:lightline_show_git_branch > 0
        function! lightline_settings#parts#GitBranch(...) abort
            return lightline_settings#git#Branch()
        endfunction
    endif

    if g:lightline_show_linenr > 1
        function! lightline_settings#parts#LineInfo(...) abort
            return call('s:FullLineInfo', a:000) . ' '
        endfunction
    elseif g:lightline_show_linenr > 0
        function! lightline_settings#parts#LineInfo(...) abort
            return call('s:SimpleLineInfo', a:000) . ' '
        endfunction
    endif
endfunction
