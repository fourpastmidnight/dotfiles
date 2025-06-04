if exists('g:loaded_plugins_config')
    finish
endif
let g:loaded_plugins_config = 1

if $HOSTNAME =~? '^US-LA-ACT-12687$' && (has('win32') || has('win64')) && !(exists('g:is_wsl') || g:is_wsl)
    if exists('$MSYSTEM')
        call plug#begin('/d/CTD/src/git/dotfiles/vim-win/vimfiles/plugged')
    else
        call plug#begin('D:\CTD\src\git\dotfiles\vim-win\vimfiles\plugged')
    endif
else
    call plug#begin()
endif

" Let vim-plug manage vim-plug
" THIS MUST APPEAR FIRST IN THIS FILE!
Plug 'junegunn/vim-plug'

" Plugins in sections labeled '(ORDERED)' have dependencies on other plugins.
" Ordering is IMPORTANT! See the documentation for each plugin to understand
" its dependencies and insert plugins into this list accordingly when the
" plugin has dependencies (or is depended upon by another plugin.

" ========================================================================
"    FILE TYPE PLUGINS (ORDERED)
" ========================================================================

" This is required for [plasticboy|preservim]/vim-markdown, included in sheerun/polyglot.vim
Plug 'godlygeek/tabular'

" Using this for JavaScript/TypeScript syntax highlighting over
" pangloss/javascript-vim, included in sheerun/polyglot.vim.
Plug 'yuezk/vim-js', { 'for': ['javascript','javascriptreact'] }

" These plugins are already contained in vim-polyglot:
" -----------------------------------------------------
" Plug 'cakebaker/scss-syntax.vim'
" Plug 'chrisbra/csv.vim'
" Plug 'ekalinin/Dockerfile.vim'
" Plug 'elzr/vim-json', { 'for': ['json', 'jsonp'] }
" Plug 'Herringtoarkholme/yats.vim', { 'for': ['typescript','typescriptreact'] }
" Plug 'ionide/Ionide-vim', { 'do': 'powershell -ExecutionPolicy Unrestricted .\\install.ps1', 'for': 'fsharp' }
" Plug 'maxmellon/vim-jsx-pretty', { 'for': ['typescript','typescriptreact'] }
" Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'preservim/vim-markdown', { 'for': 'markdown' }  (forked from plasticboy/vim-markdown)
" Plug 'pprovost/vim-ps1'
" Plug 'tpope/vim-cucumber'
" Plug 'tpope/vim-git'
Plug 'sheerun/vim-polyglot'

" ========================================================================
"    FILE TYPE PLUGINS (UNORDERED)
" ========================================================================

Plug 'fourpastmidnight/vim-posh.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx' ], 'do': 'make clean && make install' }
Plug 'https://codeberg.org/Jorenar/vim-SQL-UPPER'
"" Configure vim-SQL-UPPER plugin
" This varaible should be set to one of:
"   * 0                   - Disable auto-uppering
"   * list                - You can provide your own list of keywords, e.g. [ "select", "from" ], etc.
"   * "syntax"            - Keywords returned by syntaxcompleteOmniSyntaxList() function
"   * "drupal"            - Keywords from Drupal's List of SQL reserved words
"   * "wikipedia_all"     - All keywords from Wikipedia's list of SQL reserved word
"   * "wikipedia_sql2023" - Keywords from Wikipedia's list of SQL reserved words marked as 'In SQL:2023'
"let g:SQL_UPPER = 5

" ========================================================================
"    Formatting / Editing Behavior (UNORDERED)
" ========================================================================
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'

" ========================================================================
"    DATABASE TOOLS
" ========================================================================
Plug 'tpope/vim-dadbod'

" ========================================================================
"    IDE LSP (ORDERED)
" ========================================================================
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'OmniSharp/omnisharp-vim'
Plug 'bash-lsp/bash-language-server' " Requires prabirshrestha/vim-lsp!

" ========================================================================
"    Deno (Required for ddc.vim under IDE CODE COMPLETION)
" ========================================================================
Plug 'vim-denops/denops.vim'

" ========================================================================
"    IDE CODE COMPLETION (ORDERED)
" ========================================================================

" ddc.vim ecosystem
" ------------------------------------------------------------------------
Plug 'Shougo/ddc.vim'
Plug 'Shougo/pum.vim'
Plug 'Shougo/ddc-ui-pum'

" ddc sources
" ------------------------------------------------------------------------
Plug 'Shougo/ddc-source-lsp'
Plug 'Shougo/ddc-source-around'
Plug 'Shougo/ddc-buffer'
Plug 'Shougo/ddc-file'

" ddc filters
" ------------------------------------------------------------------------
Plug 'Shougo/ddc-filter-matcher_head'
Plug 'Shougo/ddc-filter-sorter_rank'

" AI Plugins
" ------------------------------------------------------------------------
Plug 'github/copilot.vim'  " Invoke `:Copilot setup`  to get started

" ========================================================================
"    IDE DIAGNOSTICS (ORDERED)
" ========================================================================
Plug 'dense-analysis/ale'

" ========================================================================
"    IDE DEBUGGING (ORDERED)
" ========================================================================
Plug 'puremourning/vimspector'

" ========================================================================
"    IDE CTAGS SUPPORT (for non-LSP languages)
" ========================================================================
Plug 'vim-scripts/taglist.vim'

" ========================================================================
"    IDE UNIT TEST RUNNER SUPPORT (for non-LSP languages)
" ========================================================================
Plug 'vim-test/vim-test'

" ========================================================================
"    MISCELLANEOUS UTILITY PLUGINS (UNORDERED)
" ========================================================================

" NerdTREE and associated extensions
" ------------------------------------------------------------------------
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Git Utility Plugins
" ------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim' " Depends on vim-fugitive above.
Plug 'idanarye/vim-merginal' " Depends on vim-fugitive, and on windows, vimproc.vim
Plug 'christoomey/vim-conflicted' " Depends on vim-fugitive
Plug 'rhysd/committia.vim'
"  The below plugin is deprecated in favor of the one immediately below it
"Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-gin'

" Other Utility Plugins
" ------------------------------------------------------------------------

" ORDERED Utility Plugins
Plug 'tpope/vim-vinegar'
"Plug 'mhinz/vim-signify'
Plug 'MattesGroeger/vim-bookmarks'

" UNORDERED Utility Plugins
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'simeji/winresizer'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" UI Enhancements
" ------------------------------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Load vim-airline-clock iff. in a Linux headless session outside of TMUX.
if !exists('$DISPLAY') && !exists('$WAYLAND_DISPLAY') && !exists('$TMUX')
    Plug 'enricobacis/vim-airline-clock'
endif
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'

" This plug-in should load last (just before colorschemes) so that it can
" maximally be used to repeat _anything_ the plugin supports
Plug 'tpope/vim-repeat'


" ========================================================================
"    Colorscheme Plugins
" ========================================================================
Plug 'AlessandroYorba/Alduin'
Plug 'vim-scripts/Spacegray.vim'
Plug 'aereal/vim-colors-japanesque'
"Plug 'ayu-theme/ayu-vim'
Plug 'luxed/ayu-vim'  " The original ayu theme (above) is no longer maintained, and this one has some fixes
Plug 'k4yt3x/ayu-vim-darker'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'artanikin/vim-synthwave84'
Plug 'arzg/vim-corvine'
Plug 'arzg/vim-substrata'
Plug 'arzg/vim-colors-xcode'
Plug 'balanceiskey/vim-framer-syntax'
Plug 'betoissues/contrastneed-theme'
Plug 'blackgate/tropikos-vim-theme'
Plug 'blindFS/flattr.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'carakan/new-railscasts-theme'
Plug 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'cocopon/iceberg.vim'
Plug 'croaker/mustang-vim'
Plug 'cseelus/vim-colors-clearance'
Plug 'cseelus/vim-colors-lucid'
Plug 'cseelus/vim-colors-tone'
Plug 'DankNeon/vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'deathlyfrantic/vim-distill'
Plug 'dikiaap/minimalist'
Plug 'doums/darcula'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dunckr/vim-monokai-soda'
Plug 'duythinht/vim-coffee'
Plug 'haze/sitruuna.vim'
Plug 'ehartc/Spink'
Plug 'encody/nvim'
Plug 'fcevado/molokai_dark'
Plug 'flazz/vim-colorschemes'
Plug 'flrnd/plastic.vim'
Plug 'franbach/miramare'
Plug 'gilsondev/lizard'
Plug 'glortho/feral-vim'
Plug 'gummesson/stereokai.vim'
Plug 'haishanh/night-owl.vim'
Plug 'J4CKR3D/Hypsteria'
Plug 'jacoborus/tender.vim'
Plug 'jansenfuller/crayon'
Plug 'jaredgorski/SpaceCamp'
Plug 'jdsimcoe/panic.vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'joshdick/onedark.vim'
Plug 'kadekillary/Turtles'
Plug 'koirand/tokyo-metro.vim'
Plug 'lewis6991/moonlight.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'lisposter/vim-blackboard'
Plug 'Lokaltog/vim-distinguished'
Plug 'lucasprag/simpleblack'
Plug 'Marfisc/vorange'
Plug 'maksimr/Lucius2'
Plug 'mhartington/oceanic-next'
Plug 'mkarmona/colorsbox'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'nightsense/carbonized'
Plug 'nightsense/cosmic_latte'
Plug 'rmdashrfv/nemo'
Plug 'nightsense/stellarized'
Plug 'nightsense/seabird'
Plug 'nightsense/seagrey'
Plug 'nightsense/snow'
Plug 'nightsense/strawberry'
Plug 'nightsense/vimspectr'
Plug 'nn1ks/vim-darkspace'
Plug 'noahfrederick/vim-hemisu'
Plug 'notpratheek/vim-luna'
Plug 'oguzbilgic/sexy-railscasts-theme'
Plug 'orthecreedence/void.vim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'quantum-omega/vim-burnttoast256', { 'name': 'burnttoast256' }
Plug 'Rigellute/rigel'
Plug 'rafalbromirski/vim-aurora'
Plug 'rakr/vim-one'
Plug 'ratazzi/blackboard.vim'
Plug 'relastle/bluewery.vim'
Plug 'rhysd/wallaby.vim'
Plug 'scottymoon/vim-chalkboard'
Plug 'scottymoon/vim-twilight'
Plug 'sherifkandeel/vim-colors'
Plug 'sickill/vim-monokai'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'srcery-colors/srcery-vim'
Plug 'tomasr/molokai'
Plug 'shapeoflambda/dark-purple.vim'
Plug 'stulzer/heroku-colorscheme'
Plug 'tpope/vim-vividchalk'
Plug 'trusktr/seti.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'vim-scripts/moria'
Plug 'vim-scripts/obsidian2.vim'
Plug 'vim-scripts/strange'
Plug 'vim-scripts/synic.vim'
Plug 'vim-scripts/twilight256.vim'
Plug 'vim-scripts/vilight.vim'
Plug 'w0ng/vim-hybrid'
Plug 'wadackel/vim-dogrun', { 'branch': 'main' }
Plug 'Zabanaa/neuromancer.vim'

call plug#end()
