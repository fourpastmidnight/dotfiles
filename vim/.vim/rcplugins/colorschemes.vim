Plug 'ackyshake/Spacegray.vim'
Plug 'AlessandroYorba/Sierra'
"let g:sierra_Midnight = 1
let g:sierra_Pitch = 1
Plug 'aliou/moriarty.vim'
Plug 'arcticicestudio/nord-vim' " Needs tweaking
Plug 'arzg/vim-substrata'
Plug 'ayu-theme/ayu-vim'
let g:ayucolor="dark" " light, mirage, dark
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep-theme'}
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'cocopon/iceberg.vim'
Plug 'cseelus/vim-colors-lucid'
Plug 'cseelus/vim-colors-tone'
Plug 'danilo-augusto/vim-afterglow'
Plug 'drewtempelmeyer/palenight.vim' " Make the background darker
Plug 'EdenEast/nightfox.nvim'
Plug 'eemed/sitruuna.vim'
Plug 'ehartc/Spink'
Plug 'fcevado/molokai_dark'
Plug 'flazz/vim-colorschemes' " ??
Plug 'flrnd/plastic.vim'
Plug 'fmoralesc/molokayo'
Plug 'fourpastmidnight/seabird', { 'branch': 'no-hardcoded-background' } " Need to update the seagull theme to use a dark background
augroup colorscheme_seagull
  autocmd!
  autocmd Colorscheme seagull hi Normal ctermbg=0
        \ | set background=dark
        \ | hi Normal guibg=#202020
augroup END
Plug 'haishanh/night-owl.vim'
Plug 'kadekillary/Turtles'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
let g:material_theme_style = 'darker'
let g:material_theme_italics = 1
Plug 'koirand/tokyo-metro.vim'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'Lokaltog/vim-distinguished'
Plug 'Marfisc/vorange'
Plug 'maksimr/Lucius2'
Plug 'mhartington/oceanic-next' " Needs tweeeaking
Plug 'mkarmona/colorsbox' " colorsbox-stbright, colorsbox-stnight
Plug 'nanotech/jellybeans.vim'
Plug 'nightsense/nemo'
Plug 'nightsense/stellarized'
Plug 'nightsense/seagrey'
Plug 'nn1ks/vim-darkspace'
Plug 'noahfrederick/vim-hemisu'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'rainglow/vim', { 'as': 'rainglow' }
Plug 'relastle/bluewery.vim'
Plug 'rhysd/wallaby.vim'
Plug 'sainnhe/gruvbox-material'
let g:gruvbox_material_background='hard'
let g:gruvbox_material_foreground='original'
Plug 'scottymoon/vim-twilight'
Plug 'sherifkandeel/vim-colors'
Plug 'sickill/vim-monokai'
Plug 'srcery-colors/srcery-vim'
Plug 'shapeoflambda/dark-purple.vim'
Plug 'stulzer/heroku-colorscheme'
Plug 'tomasr/molokai' " v
" Trust me, you don't want the original.
let g:molokai_original = 0
" Add 24-bit treminal color support
let g:rehash256 = 1
Plug 'tpope/vim-vividchalk'
Plug 'trusktr/seti.vim'
Plug 'tyrannicaltoucan/vim-deep-space', " v
Plug 'vim-scripts/moria'
Plug 'vim-scripts/obsidian2.vim'
Plug 'vim-scripts/strange'
Plug 'vim-scripts/twilight256.vim'
Plug 'w0ng/vim-hybrid' " v

