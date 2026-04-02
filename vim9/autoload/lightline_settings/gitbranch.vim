vim9script

var git_branch_expiry = 5.0 # 5 seconds
var git_branch_cache = ''
var git_branch_time: list<any> = []

def GetGitBranch(): string
    # If cache is empty or older than 5 seconds, update it
    if empty(git_branch_cache) || reltimefloat(reltime(git_branch_time)) > git_branch_expiry
        var branch: string
        if exists('*FugitiveHead')
            branch = call('FugitiveHead', [])
            if empty(branch) && !exists('b:git_dir')
                call('FugitiveDetect', [])
                branch = call('FugitiveHead', [])
            endif
        else
            branch = system('git branch --show-current 2>/dev/null')
            branch = trim(branch)
        endif
        # Caching
        git_branch_cache = branch
        git_branch_time = reltime()
    endif

    return git_branch_cache
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
