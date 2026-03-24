vim9script

export def Init()
    if empty(findfile('plugin/bufferline.vim', &rtp))
        return
    endif

    # https://github.com/mengelbrecht/lightline-bufferline
    g:lightline.tabline          = {left: [['bufferlabel', 'buffers']], right: [['close']]}
    g:lightline.component_expand = {buffers: 'lightline#bufferline#buffers'}
    g:lightline.component_type   = {buffers: 'tabsel'}

    g:lightline#bufferline#unicode_symbols   = g:lightline_powerline_fonts
    g:lightline#bufferline#filename_modifier = ':t'
    g:lightline#bufferline#show_number       = 1
    g:lightline#bufferline#shorten_path      = 1
    g:lightline#bufferline#unnamed           = '[No Name]'
    g:lightline#bufferline#enable_devicons   = !empty(findfile('autoload/webdevicons.vim', &rtp))
    g:lightline#bufferline#enable_nerdfont   = !empty(findfile('autoload/nerdfont.vim', &rtp))
    g:lightline#bufferline#icon_position     = 'right'

    # g:lightline#bufferline#number_map = {
    #             0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
    #             5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
    #             }

    # g:lightline#bufferline#number_map = {
    #             0: '₀', 1: '₁', 2: '₂', 3: '₃', 4: '₄',
    #             5: '₅', 6: '₆', 7: '₇', 8: '₈', 9: '₉'
    #             }
enddef
