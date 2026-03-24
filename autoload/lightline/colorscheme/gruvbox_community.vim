vim9script

# -----------------------------------------------------------------------------
# File: gruvbox.vim
# Description: Gruvbox colorscheme for Lightline (itchyny/lightline.vim)
# Author: gmoe <me@griffinmoe.com>
# Source: https://github.com/gruvbox-community/gruvbox
# -----------------------------------------------------------------------------

var bg0: list<any>
var bg1: list<any>
var bg2: list<any>
var bg4: list<any>
var fg1: list<any>
var fg4: list<any>
var yellow: list<any>
var blue: list<any>
var aqua: list<any>
var orange: list<any>
var red: list<any>
var green: list<any>

if &background ==# 'dark'
    bg0    = ['#1d2021', '234']
    bg1    = ['#3c3836', '237']
    bg2    = ['#504945', '239']
    bg4    = ['#7c6f64', '243']
    fg1    = ['#ebdbb2', '223']
    fg4    = ['#a89984', '246']
    yellow = ['#fabd2f', '214']
    blue   = ['#83a598', '109']
    aqua   = ['#8ec07c', '108']
    orange = ['#fe8019', '208']
    red    = ['#fb4934', '167']
    green  = ['#b8bb26', '142']
else
    bg0    = ['#f9f5d7', '230']
    bg1    = ['#ebdbb2', '223']
    bg2    = ['#d5c4a1', '250']
    bg4    = ['#a89984', '246']
    fg1    = ['#3c3836', '237']
    fg4    = ['#7c6f64', '243']
    yellow = ['#b57614', '136']
    blue   = ['#076678', '24']
    aqua   = ['#427b58', '65']
    orange = ['#af3a03', '130']
    red    = ['#9d0006', '88']
    green  = ['#79740e', '100']
endif

var p = {normal: {}, inactive: {}, insert: {}, replace: {}, visual: {}, tabline: {}, terminal: {}}

p.normal.left     = [[bg0, fg4, 'bold'], [fg4, bg2]]
p.normal.right    = [[bg0, fg4], [fg4, bg2]]
p.normal.middle   = [[fg4, bg1]]
p.inactive.right  = [[bg4, bg1], [bg4, bg1]]
p.inactive.left   = [[bg4, bg1], [bg4, bg1]]
p.inactive.middle = [[bg4, bg1]]
p.insert.left     = [[bg0, blue, 'bold'], [fg1, bg2]]
p.insert.right    = [[bg0, blue], [fg1, bg2]]
p.insert.middle   = [[fg4, bg1]]
p.terminal.left   = [[bg0, green, 'bold'], [fg1, bg2]]
p.terminal.right  = [[bg0, green], [fg1, bg2]]
p.terminal.middle = [[fg4, bg1]]
p.replace.left    = [[bg0, aqua, 'bold'], [fg1, bg2]]
p.replace.right   = [[bg0, aqua], [fg1, bg2]]
p.replace.middle  = [[fg4, bg1]]
p.visual.left     = [[bg0, orange, 'bold'], [bg0, bg4]]
p.visual.right    = [[bg0, orange], [bg0, bg4]]
p.visual.middle   = [[fg4, bg1]]
p.tabline.left    = [[fg4, bg2]]
p.tabline.tabsel  = [[bg0, fg4]]
p.tabline.middle  = [[bg0, bg4]]
p.tabline.right   = [[bg0, orange]]
p.normal.error    = [[bg0, red]]
p.normal.warning  = [[bg0, yellow]]

g:lightline#colorscheme#gruvbox_community#palette = lightline#colorscheme#flatten(p)

# vim:set et sw=4 ts=4 fdm=marker:
