vim9script

var bg0: list<any>
var bg1: list<any>
var bg2: list<any>
var bg4: list<any>
var fg1: list<any>
var fg4: list<any>
var green: list<any>
var yellow: list<any>
var blue: list<any>
var aqua: list<any>
var orange: list<any>

if &background ==# 'dark'
    bg0 = ['#282828', 235]
    bg1 = ['#3c3836', 237]
    bg2 = ['#504945', 239]
    bg4 = ['#7c6f64', 243]

    fg1 = ['#ebdbb2', 187]
    fg4 = ['#a89984', 137]

    green  = ['#98971a', 100]
    yellow = ['#d79921', 172]
    blue   = ['#458588', 66]
    aqua   = ['#689d6a', 71]
    orange = ['#d65d0e', 166]

    var p = {normal: {}, inactive: {}, insert: {}, replace: {}, visual: {}, tabline: {}, terminal: {}}

    p.normal.left   = [[bg0, fg4, 'bold'], [fg4, bg2]]
    p.normal.right  = [[bg0, fg4], [fg4, bg2]]
    p.normal.middle = [[fg4, bg1]]

    p.inactive.left   = [[bg4, bg1], [bg4, bg1]]
    p.inactive.right  = [[bg4, bg1], [bg4, bg1]]
    p.inactive.middle = [[bg4, bg1]]

    p.insert.left   = [[bg0, blue, 'bold'], [fg1, bg2]]
    p.insert.right  = [[bg0, blue], [fg1, bg2]]
    p.insert.middle = [[fg4, bg2]]

    p.terminal.left   = [[bg0, green, 'bold'], [fg1, bg2]]
    p.terminal.right  = [[bg0, green], [fg1, bg2]]
    p.terminal.middle = [[fg4, bg1]]

    p.replace.left   = [[bg0, aqua, 'bold'], [fg1, bg2]]
    p.replace.right  = [[bg0, aqua], [fg1, bg2]]
    p.replace.middle = [[fg4, bg2]]

    p.visual.left   = [[bg0, orange, 'bold'], [bg0, bg4]]
    p.visual.right  = [[bg0, orange], [bg0, bg4]]
    p.visual.middle = [[fg4, bg1]]

    p.tabline.left   = [[fg4, bg2]]
    p.tabline.right  = [[bg0, orange]]
    p.tabline.middle = [[bg0, bg4]]
    p.tabline.tabsel = [[bg0, fg4]]

    p.normal.error   = [[bg0, orange]]
    p.normal.warning = [[bg2, yellow]]

    g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(p)
endif

if &background ==# 'light'
    bg0 = ['#fbf1c7', 230]
    bg1 = ['#ebdbb2', 187]
    bg2 = ['#d5c4a1', 187]
    bg4 = ['#a89984', 137]

    fg1 = ['#3c3836', 237]
    fg4 = ['#7c6f64', 243]

    green  = ['#98971a', 100]
    yellow = ['#d79921', 172]
    blue   = ['#458588', 66]
    aqua   = ['#689d6a', 71]
    orange = ['#d65d0e', 166]

    var p = {normal: {}, inactive: {}, insert: {}, replace: {}, visual: {}, tabline: {}, terminal: {}}

    p.normal.left   = [[bg0, fg4, 'bold'], [fg4, bg2]]
    p.normal.right  = [[bg0, fg4], [fg4, bg2]]
    p.normal.middle = [[fg4, bg1]]

    p.inactive.left   = [[bg4, bg1], [bg4, bg1]]
    p.inactive.right  = [[bg4, bg1], [bg4, bg1]]
    p.inactive.middle = [[bg4, bg1]]

    p.insert.left   = [[bg0, blue, 'bold'], [fg1, bg2]]
    p.insert.right  = [[bg0, blue], [fg1, bg2]]
    p.insert.middle = [[fg4, bg2]]

    p.terminal.left   = [[bg0, green, 'bold'], [fg1, bg2]]
    p.terminal.right  = [[bg0, green], [fg1, bg2]]
    p.terminal.middle = [[fg4, bg1]]

    p.replace.left   = [[bg0, aqua, 'bold'], [fg1, bg2]]
    p.replace.right  = [[bg0, aqua], [fg1, bg2]]
    p.replace.middle = [[fg4, bg2]]

    p.visual.left   = [[bg0, orange, 'bold'], [bg0, bg4]]
    p.visual.right  = [[bg0, orange], [bg0, bg4]]
    p.visual.middle = [[fg4, bg1]]

    p.tabline.left   = [[fg4, bg2]]
    p.tabline.right  = [[bg0, orange]]
    p.tabline.middle = [[bg0, bg4]]
    p.tabline.tabsel = [[bg0, fg4]]

    p.normal.error   = [[bg0, orange]]
    p.normal.warning = [[bg2, yellow]]

    g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(p)
endif

# vim:set et sw=4 ts=4 fdm=marker:
