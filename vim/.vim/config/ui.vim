scriptencoding utf-8

" ============================================================================
" UI CONFIGURATION MODULE (non-visual)
" ============================================================================
if exists('g:loaded_ui_config')
    finish
endif
let g:loaded_ui_config = 1

set showmode
set cmdheight=1

" Set the cursor -- TODO: Lookup more info on this
"set guicursor=

set foldcolumn=5
set relativenumber
set number
set signcolumn=yes
set noerrorbells

" Start scrolling the screen when the cursor reaches 'n' lines from the top/bottom
set scrolloff=8

" ============================================================================
" Window / Split Behavior
" ============================================================================
" When splitting, put new windows below or to the right
set splitbelow
set splitright

" Use vertical diffs by default
set diffopt+=vertical

" ============================================================================
" Search UI
" ============================================================================
set hlsearch
set incsearch

" ============================================================================
" Completion UI (non-IDE)
" ============================================================================
" Menu behavior only; completion logic lives in completion.vim
" My options are:
"  - menuone: Show a menu even for a single match
"  - noinsert: Do not insert any text until a selection is actually made
"  - noselect: Do not 'auto-select' a match--user has to explicitly select
set completeopt=menuone,noinsert,noselect

" ============================================================================
" Whitespace / Listchars
" ============================================================================
" Characters used to visualize whitespace
set listchars=tab:\\uF811\\uF811,trail:\\u00B7,nbsp:\\u2420,lead:\\u00B7,space:\\u00B7,precedes:\\u2026,extends:\\u2026

" ============================================================================
" Mouse UI
" ============================================================================
set mouse=a
if has('mouse_sgr')
    set ttymouse=sgr
else
    set ttymouse=xterm2
endif

" ============================================================================
"  Airline Configuration
" ============================================================================

" Use ':h airline' or ':h vim-airline' to see documentation for all
" configuration settings.

" Airline ships with the following extensions, which may work with other plugins:
"
" * airline-ale          (dense-analysis/ale)
" * airline-batter       (lambdalisue/battery.vim)
" * airline-bookmark     (MattesGroeger/vim-bookmarks)
" * airline-branch       (tpope/vim-fugitive, lambda-lisue/gina.vim,
"                         lambda-lisue/gin.vim, ludovicchabant/vim-lawrencium,
"                         http://www.vim.org/scripts/script.php?script_id=90
"                         (vcscommand) )
" * airline-flog         (rbong/vim-flog)
" * airline-bufferline   (bling/vim-bufferline)
" * airline-capslock     (tpope/vim-capslock)
" * airline-coc          (neoclide/coc.nvim)
" * airline-codeium      (Exafunction/codeium.vim)
" * airline-commandt     (wincent/command-t)
" * airline-csv          (chrisbra/csv.vim)
" * airline-ctrlp        (ctrlpvim/ctrlp.vim)
" * airline-ctrlspace    (szw/vim-ctrlspace)
" * airline-cursormode   (vheon/vim-cursormode)
" * airline-denite       (Shougp/denite.nvim)
" * airline-dirvish      (justinmk/vim-dirvish)
" * airline-eclim        (https://eclim.org) -- works well with airline-syntastic extension
" * airline-fern         (lambda-lisue/fern.vim)
" * airline-fugitiveline
" * airline-fzf          (junegunn/fzf or junegunn/fzf.vim)
" * airline-gina         (lambda-lisue/gina.vim, lambda-lisue/gin.vim)
" * airline-grepper      (mhinz/vim-grepper)
" * airline-gutentags    (ludoovicchabant/vim-gutentags)
" * gen_tags.vim         (jsfaint/gen_tags.vim)
" * airline-hunks        (airblade/vim-gitgutter, mhinz/vim-signify,
"                         chrisbra/changesPlugin, tomtom/quickfixsigns.vim,
"                         neoclide/coc-git, lewis6991/gitsigns.nvim)
" * airline-keymap       Displays the current keymap in use
" * airline-languageclient (autozimu/LanguageClient-neovim) - Can be used for both vim and NeoVim
" * airline-localsearch  (mox-mox/vim-localsearch)
" * airline-lsp          (prabirshrestha/vim-lsp
" * airline-neomake      (neomake/neomake)
" * airline-nerdfont     (lambda-lisue/nerdfont.vim)
" * airline-nerdtree     (preservim/nerdtree.git)
" * airline-nrrwrgn      (chrisbra/NrrwRgn)
" * airline-nvimlsp      (neovim/nvim-lsp)
" * airline-obsession    (tpope/vim-obsession)
" * airline-omnisharp    (OmniSharp/omnisharp-vim)
" * airline-po           (http://www.vim.org/vimscripts/script.php?script_id=2530)
" * airline-poetv        (petobens/poet-v)
" * airline-promptline   (edkolev/promptline.vim)
" * airline-quickfix     Built-in for working with the quickfix buffer
" * airline-rufo         (ruby-formatter/rufo-vim)
" * airline-searchcount  Built-in
" * airline-syntastic    (vim-syntastic/syntastic)
" * airline-tabline      Built-in
" * airline-tabline-hlgroups
" * airline-tabpanel     Built-in
" * airline-scrollbar    Built-in
" * airline-taboo        (gcmt/taboo.vim)
" * airline-term         Built-in
" * airline-tabws        (s1341/vim-tabws)
" * airline-tagbar       (majutsushi/tagbar)
" * airline-taglist      (vegapppan/taglist)
" * airline-tmuxline     (edkolev/tmuxline.vim)
" * airline-undotree     (mbbill/undotree)
" * airline-unicode      (chrisbra/unicode.vim)
" * airline-unite        (Shougo/unitevim)
" * airline-vim9-lsp     (yegappan/lsp)
" * airline-vimagit      (jreybert/vimagit)
" * airline-vimcmake     (cdelledonne/vim-cmake)
" * airline-vimodoro     (VimFanTPdvorak/vimodoro)
" * airline-vimtex       (lervag/vimtex)
" * airline-virtualenv   (jmcantrell/vim-virtualenv)
" * airline-vista        (liuchengxu/vista.vim)
" * airline-whitespace   built-in
" * airline-windowswap   (wesQ3/vim-windowswap)
" * airline-wordcount    built-in
" * airline-xkblayout    built-in
" * airline-xtabline     (mg979/vim-xtabline)
" * airline-ycm          (ycm-core/YouCompleteMe)
" * airline-zoomwintab   (troydm/zoomwintab.vim)
" * airline-zhihu        (pxwg/zhihu.nvim)

let g:airline_section_z = airline#section#create(["\uE0A1" . ' %{line(".")} ' . "\uE0A3" . ' %{col(".")}'])

"let g:airline_theme = 'spaceduck'
"let g:airline_theme = 'ayu_dark'

let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

"let g:webdevicons_enable = 1
"let g:webdevicons_enable_airline_tabline = 1
"let g:webdevicons_enable_airline_statusline = 1

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
let g:airline_section_z = airline#section#create(["\uE0A1" . ' %{line(".")} ' . "\uE0A3" . ' %{col(".")}'])

" ============================================================================
" Winresizer UI
" ============================================================================
let g:winresizer_gui_enable = 1

augroup vimrc_ui
    autocmd!
    autocmd WinEnter,BufEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    autocmd InsertEnter * setlocal colorcolumn=110
    autocmd InsertLeave * setlocal colorcolumn=0
augroup END
