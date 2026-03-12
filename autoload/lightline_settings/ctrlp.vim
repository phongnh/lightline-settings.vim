" https://github.com/ctrlpvim/ctrlp.vim
let s:lightline_ctrlp = {}

function! s:GetCurrentDir() abort
    let l:cwd = getcwd()
    let l:dir = fnamemodify(l:cwd, ':~:.')
    let l:dir = empty(l:dir) ? l:cwd : l:dir
    return len(l:dir) > 30 ? lightline_settings#ShortenPath(l:dir) : l:dir
endfunction

function! lightline_settings#ctrlp#MainStatus(focus, byfname, regex, prev, item, next, marked) abort
    let s:lightline_ctrlp.main    = 1
    let s:lightline_ctrlp.focus   = a:focus
    let s:lightline_ctrlp.byfname = a:byfname
    let s:lightline_ctrlp.regex   = a:regex
    let s:lightline_ctrlp.prev    = a:prev
    let s:lightline_ctrlp.item    = a:item
    let s:lightline_ctrlp.next    = a:next
    let s:lightline_ctrlp.marked  = a:marked
    let s:lightline_ctrlp.dir     = s:GetCurrentDir()

    return lightline#statusline(0)
endfunction

function! lightline_settings#ctrlp#ProgressStatus(len) abort
    let s:lightline_ctrlp.main = 0
    let s:lightline_ctrlp.len  = a:len
    let s:lightline_ctrlp.dir  = s:GetCurrentDir()

    return lightline#statusline(0)
endfunction

function! lightline_settings#ctrlp#Mode(...) abort
    let l:result = {
                \ 'name': 'CtrlP',
                \ 'buffer': s:lightline_ctrlp.dir,
                \ }

    if s:lightline_ctrlp.main
        let l:plugin_status = lightline#concatenate([
                    \ s:lightline_ctrlp.prev,
                    \ printf('%s %s %s', '«', s:lightline_ctrlp.item, '»'),
                    \ s:lightline_ctrlp.next,
                    \ ], 0)

        let l:buffer_status = lightline#concatenate([
                    \ s:lightline_ctrlp.focus,
                    \ s:lightline_ctrlp.byfname,
                    \ ], 1)

        call extend(l:result, {
                    \ 'link': 'nR'[s:lightline_ctrlp.regex],
                    \ 'plugin': l:plugin_status,
                    \ 'settings': l:buffer_status,
                    \ })
    else
        call extend(l:result, {
                    \ 'settings': s:lightline_ctrlp.len,
                    \ })
    endif

    return l:result
endfunction
