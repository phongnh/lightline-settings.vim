" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Gruvbox colorscheme for Lightline (itchyny/lightline.vim)
" Author: gmoe <me@griffinmoe.com>
" Source: https://github.com/gruvbox-community/gruvbox
" -----------------------------------------------------------------------------

if &background == 'dark'
    let s:bg0    = ['#1d2021', '234']
    let s:bg1    = ['#3c3836', '237']
    let s:bg2    = ['#504945', '239']
    let s:bg4    = ['#7c6f64', '243']
    let s:fg1    = ['#ebdbb2', '223']
    let s:fg4    = ['#a89984', '246']
    let s:yellow = ['#fabd2f', '214']
    let s:blue   = ['#83a598', '109']
    let s:aqua   = ['#8ec07c', '108']
    let s:orange = ['#fe8019', '208']
    let s:red    = ['#fb4934', '167']
    let s:green  = ['#b8bb26', '142']
else
    let s:bg0    = ['#f9f5d7', '230']
    let s:bg1    = ['#ebdbb2', '223']
    let s:bg2    = ['#d5c4a1', '250']
    let s:bg4    = ['#a89984', '246']
    let s:fg1    = ['#3c3836', '237']
    let s:fg4    = ['#7c6f64', '243']
    let s:yellow = ['#b57614', '136']
    let s:blue   = ['#076678', '24']
    let s:aqua   = ['#427b58', '65']
    let s:orange = ['#af3a03', '130']
    let s:red    = ['#9d0006', '88']
    let s:green  = ['#79740e', '100']
endif

let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal': {} }

let s:p.normal.left     = [[s:bg0, s:fg4, 'bold'], [s:fg4, s:bg2]]
let s:p.normal.right    = [[s:bg0, s:fg4], [s:fg4, s:bg2]]
let s:p.normal.middle   = [[s:fg4, s:bg1]]
let s:p.inactive.right  = [[s:bg4, s:bg1], [s:bg4, s:bg1]]
let s:p.inactive.left   = [[s:bg4, s:bg1], [s:bg4, s:bg1]]
let s:p.inactive.middle = [[s:bg4, s:bg1]]
let s:p.insert.left     = [[s:bg0, s:blue, 'bold'], [s:fg1, s:bg2]]
let s:p.insert.right    = [[s:bg0, s:blue], [s:fg1, s:bg2]]
let s:p.insert.middle   = [[s:fg4, s:bg1]]
let s:p.terminal.left   = [[s:bg0, s:green, 'bold'], [s:fg1, s:bg2]]
let s:p.terminal.right  = [[s:bg0, s:green], [s:fg1, s:bg2]]
let s:p.terminal.middle = [[s:fg4, s:bg1]]
let s:p.replace.left    = [[s:bg0, s:aqua, 'bold'], [s:fg1, s:bg2]]
let s:p.replace.right   = [[s:bg0, s:aqua], [s:fg1, s:bg2]]
let s:p.replace.middle  = [[s:fg4, s:bg1]]
let s:p.visual.left     = [[s:bg0, s:orange, 'bold'], [s:bg0, s:bg4]]
let s:p.visual.right    = [[s:bg0, s:orange], [s:bg0, s:bg4]]
let s:p.visual.middle   = [[s:fg4, s:bg1]]
let s:p.tabline.left    = [[s:fg4, s:bg2]]
let s:p.tabline.tabsel  = [[s:bg0, s:fg4]]
let s:p.tabline.middle  = [[s:bg0, s:bg4]]
let s:p.tabline.right   = [[s:bg0, s:orange]]
let s:p.normal.error    = [[s:bg0, s:red]]
let s:p.normal.warning  = [[s:bg0, s:yellow]]

let g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:p)
