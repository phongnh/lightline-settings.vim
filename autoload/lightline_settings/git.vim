" Caching
let s:lightline_time_threshold = 2.0

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
    " Get branch from caching if it is available
    if has_key(b:, 'lightline_git_branch') && reltimefloat(reltime(get(b:, 'lightline_last_finding_branch_time', -1))) < s:lightline_time_threshold
        return b:lightline_git_branch
    endif

    let l:branch = ''

    if exists('*FugitiveHead')
        let l:branch = FugitiveHead()

        if empty(l:branch) && !exists('b:git_dir')
            call FugitiveDetect()
            let l:branch = FugitiveHead()
        endif
    endif

    " Caching
    let b:lightline_git_branch = l:branch
    let b:lightline_last_finding_branch_time = reltime()

    return l:branch
endfunction

function! lightline_settings#git#Branch(...) abort
    let l:branch = s:FormatBranch(s:GetGitBranch())

    if !empty(l:branch)
        return g:lightline_symbols.branch .. ' ' .. l:branch
    endif

    return l:branch
endfunction

function! lightline_settings#git#Mode(...) abort
    let l:result = { 'name': 'Git', 'info': lightline_settings#lineinfo#Simple() }
    if expand('%:t')->len() >= 7
        let l:result['plugin'] = expand('%:t')
    endif
    return l:result
endfunction
