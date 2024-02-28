function! lightline_settings#vista#Mode(...) abort
    let provider = get(get(g:, 'vista', {}), 'provider', '')
    return {
                \ 'plugin': provider,
                \ 'plugin_inactive': provider,
                \ 'type': 'vista',
                \ }
endfunction
