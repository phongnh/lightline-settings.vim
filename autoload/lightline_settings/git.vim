" Caching
let s:lightline_time_threshold = 0.50
let s:lightline_last_finding_branch_time = reltime()

function! s:ShortenBranch(branch, length) abort
    let l:branch = a:branch

    if strlen(l:branch) > a:length && g:lightline_shorten_path
        let l:branch = lightline_settings#ShortenPath(l:branch)
    endif

    if strlen(l:branch) > a:length
        let l:branch = fnamemodify(l:branch, ':t')
    endif

    if strlen(l:branch) > a:length
        " Show only JIRA ticket prefix
        let l:branch = substitute(l:branch, '^\([A-Z]\{3,}-\d\{1,}\)-.\+', '\1', '')
    endif

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
    if has_key(b:, 'lightline_git_branch') && reltimefloat(reltime(s:lightline_last_finding_branch_time)) < s:lightline_time_threshold
        return b:lightline_git_branch
    endif

    let l:branch = ''

    if exists('*FugitiveHead')
        let l:branch = FugitiveHead()

        if empty(l:branch) && exists('*FugitiveDetect') && !exists('b:git_dir')
            call FugitiveDetect(getcwd())
            let l:branch = FugitiveHead()
        endif
    elseif exists('*fugitive#head')
        let l:branch = fugitive#head()

        if empty(l:branch) && exists('*fugitive#detect') && !exists('b:git_dir')
            call fugitive#detect(getcwd())
            let l:branch = fugitive#head()
        endif
    elseif exists(':Gina') == 2
        let l:branch = gina#component#repo#branch()
    endif

    " Caching
    let b:lightline_git_branch = l:branch
    let s:lightline_last_finding_branch_time = reltime()

    return l:branch
endfunction

function! lightline_settings#git#Branch(...) abort
    let l:branch = s:FormatBranch(s:GetGitBranch())

    if !empty(l:branch)
        return g:lightline_symbols.branch .. ' ' .. l:branch
    endif

    return l:branch
endfunction
