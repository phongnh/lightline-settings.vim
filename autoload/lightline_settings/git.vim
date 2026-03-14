" Caching - increased threshold for better performance
let s:lightline_time_threshold = 2.0
let s:lightline_cache = {}
let s:lightline_fugitive_detected = {}

function! s:ShortenBranch(branch, length) abort
    let l:len = strlen(a:branch)
    
    " Early exit if already short enough
    if l:len <= a:length
        return a:branch
    endif

    let l:branch = a:branch
    if g:lightline_shorten_path
        let l:branch = lightline_settings#ShortenPath(l:branch)
        let l:len = strlen(l:branch)
        
        if l:len <= a:length
            return l:branch
        endif
    endif

    let l:branch = fnamemodify(l:branch, ':t')
    let l:len = strlen(l:branch)

    if l:len <= a:length
        return l:branch
    endif

    " Show only JIRA ticket prefix
    let l:branch = substitute(l:branch, '^\([A-Z]\{3,}-\d\{1,}\)-.\+', '\1', '')
    return l:branch
endfunction

function! s:FormatBranch(branch) abort
    let l:winwidth = exists('*lightline_settings#parts#GetWinWidth')
                \ ? lightline_settings#parts#GetWinWidth(0)
                \ : winwidth(0)

    if l:winwidth >= g:lightline_winwidth_config.normal
        return s:ShortenBranch(a:branch, 50)
    endif

    let l:branch = s:ShortenBranch(a:branch, 30)

    if strlen(l:branch) > 30
        let l:branch = strcharpart(l:branch, 0, 29) .. g:lightline_symbols.ellipsis
    endif

    return l:branch
endfunction

function! s:GetGitBranch() abort
    let l:bufnr = bufnr('%')
    let l:cwd = getcwd()
    let l:cache_key = l:bufnr . ':' . l:cwd
    
    " Check cache with timestamp
    if has_key(s:lightline_cache, l:cache_key)
        let l:cache_entry = s:lightline_cache[l:cache_key]
        if reltimefloat(reltime(l:cache_entry.time)) < s:lightline_time_threshold
            return l:cache_entry.branch
        endif
    endif

    let l:branch = ''

    if exists('*FugitiveHead')
        " Only detect once per buffer+cwd combination
        if !get(s:lightline_fugitive_detected, l:cache_key, 0) && !exists('b:git_dir')
            call FugitiveDetect(l:cwd)
            let s:lightline_fugitive_detected[l:cache_key] = 1
        endif
        let l:branch = FugitiveHead()
    elseif exists('*fugitive#head')
        " Only detect once per buffer+cwd combination
        if !get(s:lightline_fugitive_detected, l:cache_key, 0) && !exists('b:git_dir')
            call fugitive#detect(l:cwd)
            let s:lightline_fugitive_detected[l:cache_key] = 1
        endif
        let l:branch = fugitive#head()
    elseif exists(':Gina') == 2
        let l:branch = gina#component#repo#branch()
    endif

    " Update cache
    let s:lightline_cache[l:cache_key] = {
                \ 'branch': l:branch,
                \ 'time': reltime()
                \ }

    return l:branch
endfunction

function! lightline_settings#git#Branch(...) abort
    let l:branch = s:FormatBranch(s:GetGitBranch())

    if !empty(l:branch)
        return g:lightline_symbols.branch .. ' ' .. l:branch
    endif

    return l:branch
endfunction

" Clear cache on buffer events to ensure fresh data on branch changes
function! lightline_settings#git#ClearCache() abort
    let s:lightline_cache = {}
    let s:lightline_fugitive_detected = {}
endfunction

" Optionally set up autocmds to clear cache on git operations
" Users can add to their vimrc:
" autocmd User FugitiveChanged call lightline_settings#git#ClearCache()
" autocmd BufWritePost * call lightline_settings#git#ClearCache()
