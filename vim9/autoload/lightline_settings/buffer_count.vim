vim9script

# Copied from https://github.com/itchyny/lightline-powerful/blob/master/autoload/lightline_powerful.vim
g:lightline_buffer_count_by_basename = {}

# Throttle buffer count updates to avoid expensive operations on every event
var last_buffer_update: list<any> = []
var buffer_update_interval = 100  # milliseconds

export def Update()
    # Throttle updates - only run if enough time has passed
    var now = reltime()
    if !empty(last_buffer_update) && reltimefloat(reltime(last_buffer_update)) * 1000 < buffer_update_interval
        return
    endif
    last_buffer_update = now

    g:lightline_buffer_count_by_basename = {}
    var bufnrs = range(1, bufnr('$'))
        ->filter((_, v) => buflisted(v) && bufexists(v) && !empty(bufname(v)))
        ->map((_, v) => expand('#' .. v .. ':t'))
    for name in bufnrs
        if !empty(name)
            g:lightline_buffer_count_by_basename[name] = get(g:lightline_buffer_count_by_basename, name, 0) + 1
        endif
    endfor
enddef
