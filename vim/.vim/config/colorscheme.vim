if exists('g:loaded_colorscheme_config')
    finish
endif
let g:loaded_colorscheme_config = 1

set background=dark
"colorscheme spaceduck

" for ayu-vim-darker, you can set ayucolor="darker" (ayu-theme/ayu-vim) or
" g:ayucolor (luxed/ayu-vim) to get an even darker
" version of ayu
let ayucolor="dark"
let g:ayucolor="dark"
" These options only work for luxed/ayu-vim variant of the theme
let g:ayu_extended_palette = 1
colorscheme ayu

