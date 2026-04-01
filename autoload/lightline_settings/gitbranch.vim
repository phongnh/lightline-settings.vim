let s:git_branch_expiry = 5.0 " 5 seconds
let s:git_branch_cache = ''
let s:git_branch_time = ''

function! s:GetGitBranch() abort
    " If cache is empty or older than 5 seconds, update it
    if empty(s:git_branch_cache) || reltimefloat(reltime(s:git_branch_time)) > s:git_branch_expiry
        if exists('*FugitiveHead')
            let l:branch = FugitiveHead()
            if empty(l:branch) && !exists('b:git_dir')
                call FugitiveDetect()
                let l:branch = FugitiveHead()
            endif
        else
            let l:branch = system('git branch --show-current 2>/dev/null')
            let l:branch = lightline_settings#Trim(l:branch)
        endif
        " Caching
        let s:git_branch_cache = l:branch
        let s:git_branch_time = reltime()
    endif

    return s:git_branch_cache
endfunction

" Extract JIRA / YouTrack ticket number
let s:ticket_number_pattern = '^\([A-Z]\{3,}-\d\{1,}\)'
let s:nested_ticket_number_pattern = '^\([A-Z]\{3,}-\d\{1,}\)\(\/[A-Z]\{3,}-\d\{1,}\)\+'

" JIRA-123/JIRA-456-*
function! s:ExtractNestedTicketNumbers(branch) abort
    if match(a:branch, s:nested_ticket_number_pattern) > -1
        let l:result = []
        for l:part in split(a:branch, '/')
            if match(l:part, s:ticket_number_pattern) > -1
                call add(l:result, matchstr(l:part, s:ticket_number_pattern))
            endif
        endfor
        return join(l:result, '/')
    endif
    return a:branch
endfunction

function! s:ExtractTicketNumber(branch) abort
    for l:part in split(a:branch, '/')->reverse()
        if match(l:part, s:ticket_number_pattern) > -1
            return matchstr(l:part, s:ticket_number_pattern)
        endif
    endfor
    return a:branch
endfunction

function! s:TruncateBranch(branch, length) abort
    return strcharpart(a:branch, 0, a:length - 1) .. g:lightline_symbols.ellipsis
endfunction

function! s:SplitBranch(branch, length) abort
    let l:branch = fnamemodify(a:branch, ':t')
    if strlen(l:branch) <= a:length
        return l:branch
    endif
    let l:sep = '-'
    let l:parts = split(l:branch, l:sep)
    if len(l:parts) == 1
        let l:sep = '_'
        let l:parts = split(l:branch, l:sep)
    endif
    let l:truncated_branch = l:parts[0]
    for l:idx in range(1, len(l:parts) - 1)
        let l:part = l:parts[l:idx]
        if strlen(l:truncated_branch .. l:sep .. l:part) > a:length
            break
        endif
        let l:truncated_branch = l:truncated_branch .. l:sep .. l:part
    endfor
    if strlen(l:truncated_branch) > a:length
        return s:TruncateBranch(l:branch, a:length)
    endif
    return l:truncated_branch .. g:lightline_symbols.ellipsis
endfunction

let s:shorten_branch_rules = [
            \ { branch -> branch },
            \ { branch -> g:lightline_shorten_path ? lightline_settings#ShortenPath(branch) : branch },
            \ { branch -> fnamemodify(branch, ':t') },
            \ { branch -> s:ExtractNestedTicketNumbers(branch) },
            \ { branch -> s:ExtractTicketNumber(branch) },
            \ ]

function! s:ShortenBranch(branch, length) abort
    for l:F in s:shorten_branch_rules
        let l:branch = l:F(a:branch)
        if strlen(l:branch) <= a:length
            return l:branch
        endif
    endfor
    return s:SplitBranch(a:branch, 30)
endfunction

function! s:FormatBranch(branch) abort
    let l:winwidth = lightline_settings#GetWinWidth(0)

    if l:winwidth >= g:lightline_winwidth_config.normal
        return s:ShortenBranch(a:branch, 50)
    endif

    return s:ShortenBranch(a:branch, 30)
endfunction

function! lightline_settings#gitbranch#Name(...) abort
    let l:branch = s:FormatBranch(s:GetGitBranch())

    if !empty(l:branch)
        return g:lightline_symbols.branch .. ' ' .. l:branch
    endif

    return l:branch
endfunction
