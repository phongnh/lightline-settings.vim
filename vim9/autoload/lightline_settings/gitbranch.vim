vim9script

const git_branch_expiry = 5.0 # 5 seconds
var git_branch_time: list<any> = []

def GetGitBranch(): string
    if has_key(b:, 'lightline_git_branch') && reltimefloat(reltime(git_branch_time)) < git_branch_expiry
        return b:lightline_git_branch
    endif

    var branch: string = null_string

    # exists('*FugitiveHead') is resolved at compile time inside a def
    # always return false for late-loaded plugins. Use try/call() instead so
    # the lookup happens at runtime on every call.
    try
        branch = call('FugitiveHead', [])
        if empty(branch) && !exists('b:git_dir')
            call('FugitiveDetect', [])
            branch = call('FugitiveHead', [])
        endif
    catch /E117:/
    endtry

    if branch is null_string
        const cwd = getcwd()
        try
            lcd %:p:h
            silent branch = system('git branch --show-current 2>/dev/null')->trim()
        finally
            execute 'lcd' cwd
        endtry
    endif

    # Caching
    b:lightline_git_branch = branch
    git_branch_time = reltime()

    return b:lightline_git_branch
enddef

# Extract JIRA / YouTrack ticket number
const ticket_number_pattern = '^\([A-Z]\{3,}-\d\{1,}\)'
const nested_ticket_number_pattern = '^\([A-Z]\{3,}-\d\{1,}\)\(\/[A-Z]\{3,}-\d\{1,}\)\+'

# JIRA-123/JIRA-456-*
def ExtractNestedTicketNumbers(branch: string): string
    if match(branch, nested_ticket_number_pattern) > -1
        var result: list<string> = []
        for part in split(branch, '/')
            if match(part, ticket_number_pattern) > -1
                add(result, matchstr(part, ticket_number_pattern))
            endif
        endfor
        return join(result, '/')
    endif
    return branch
enddef

def ExtractTicketNumber(branch: string): string
    for part in split(branch, '/')->reverse()
        if match(part, ticket_number_pattern) > -1
            return matchstr(part, ticket_number_pattern)
        endif
    endfor
    return branch
enddef

def TruncateBranch(branch: string, length: number): string
    return strcharpart(branch, 0, length - 1) .. g:lightline_symbols.ellipsis
enddef

def SplitBranch(branch: string, length: number): string
    const branch_tail = fnamemodify(branch, ':t')
    if strlen(branch_tail) <= length
        return branch_tail
    endif
    var sep = '-'
    var parts = split(branch_tail, sep)
    if len(parts) == 1
        sep = '_'
        parts = split(branch_tail, sep)
    endif
    var truncated_branch = parts[0]
    for idx in range(1, len(parts) - 1)
        var part = parts[idx]
        if strlen(truncated_branch .. sep .. part) > length
            break
        endif
        truncated_branch = truncated_branch .. sep .. part
    endfor
    if strlen(truncated_branch) > length
        return TruncateBranch(branch_tail, length)
    endif
    return truncated_branch .. g:lightline_symbols.ellipsis
enddef

const shorten_branch_rules: list<any> = [
    (branch) => branch,
    (branch) => g:lightline_shorten_path ? pathshorten(branch) : branch,
    (branch) => fnamemodify(branch, ':t'),
    (branch) => ExtractNestedTicketNumbers(branch),
    (branch) => ExtractTicketNumber(branch),
]

def ShortenBranch(branch: string, length: number): string
    for F in shorten_branch_rules
        const shortened_branch = F(branch)
        if strlen(shortened_branch) <= length
            return shortened_branch
        endif
    endfor
    return SplitBranch(branch, 30)
enddef

def FormatBranch(branch: string): string
    const winwidth = lightline_settings#GetWinWidth(0)

    if winwidth >= g:lightline_winwidth_config.normal
        return ShortenBranch(branch, 50)
    endif

    return ShortenBranch(branch, 30)
enddef

export def Component(...args: list<any>): string
    const branch = FormatBranch(GetGitBranch())

    if !empty(branch)
        return g:lightline_symbols.branch .. ' ' .. branch
    endif

    return branch
enddef
