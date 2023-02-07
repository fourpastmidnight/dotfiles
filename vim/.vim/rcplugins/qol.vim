" Contains 'Quality of Life' plugins that help make using Vim more pleasant.
"
" For example, vim-startify, or NERDTree, if you prefer that over netrw.

Plug 'easymotion/vim-easymotion'

Plug 'lifepillar/vim-colortemplate'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-sayonara'
"Plug 'ntpeters/vim-better-whitespace'
" Configuration
" TODO: Setup an autocmd for markdown to ignore trailing whitespace
" TODO: Configure the plugin above
Plug 'ojroques/vim-oscyank', { 'branch': 'main' }
nmap <leader>y <Plug>OSCYank

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'tpope/vim-characterize'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'

"let g:airline_theme = 'spaceduck'
let g:airline_theme = 'base16_classic_dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#bookmark#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#clock#enabled = 1
let g:airline#extensions#clock#auto = 0
"let g:airline#extensions#clock#format = '%H:%M'
" %a = 3-letter day-of-week
" %A = full day-of-week
" %w = number of day of week, 0-6, 0 = Sunday
" %y = two-digit year
" %Y = four-digit year
" %b = 3-lettr month
" %B = full month
" %m = month number, 01..12
" %d = day number, 01..31
" %e = no leading zero day number: 1..31
" %l = no-leading zero hour
" %H = 24-hour hour, 00..23
" %I = 12-hour hour, 01..12
" %M = minutes, 00..59
" %S = seconds, 00..60
" %p = AM/PM indicator
" %Z = TimeZone offset, e.g. +08
" %j = day-of-year, 001..366
" %% = literal '%'
let g:airline#extensions#clock#format = '%a %e %b %Y %H:%M'
let g:airline#extensions#clock#updatetime = 60000
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#show_coc_status = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#hunks#coc_git = 0
let g:airline#extensions#lsp#enabled = 1
let g:airline#extensions#lsp#error_symbol = "\uEA87"
let g:airline#extensions#lsp#warning_symbol = "\uF071"
let g:airline#extensions#lsp#show_line_numbers = 1
let g:airline#extensions#lsp#open_lnum_symbol = '(' . "\uE0A1"
let g:airline#extensions#lsp#close_lnum_symbol = ')'
let g:airline#extensions#nerdtree_statusline = 1
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = '$'
let g:airline#extensions#omnisharp#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 2
let g:airline#extensions#scrollbar#enabled = 1
let g:airline#extensions#term#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#vim9lsp#enabled = 1
let g:airline#extensions#vim9lsp#error_symbol = "\uEA87"
let g:airline#extensions#vim9lsp#warning_symbol = "\uF071"
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0B0"
let g:airline_right_sep = "\uE0B2"
function! AirlineInit()
  let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}', ' ', "\uE0A3" . '%{col(".")}', ' ', 'clock'])
endfunction
let g:airline_skip_empty_sections = 1
"let g:airline_statusline_ontop = 1
