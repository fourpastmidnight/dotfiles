" This file contains plugins, and their settings, which makes vim into more than just a text editor--
" a powerful IDE complete with IntelliSense(r) (via LSP) and debugging (via DAP).
" It also contains a few other plugins, such as rainbow bracket matching, etc.

Plug 'bash-lsp/bash-language-server'

Plug 'dense-analysis/ale'
" To continue to use CoC as the LSP server, set this to 1
let g:ale_disable_lsp = 1
" To have ALE work with Coc, use :CocConfig and add the following to your
" coc.settings file:
"
"    "diagnastic.displayByAle": true

" TODO: Most of ALE's features have been disabled until I try them out and/or
" configure them for specific languages.

" For ALE to use OmniSharp as a C# linter:
"let g:ale_linters = { 'cs: ['OmniSharp'] } - OR
"let b:ale_linters = ['OmniSHarp' ] in a ftplugin for CSharp files.

" By default, ALE attempts to provide linting for any/all supported files. You
" can override this with a global list or a buffer-local list (either set via
" commmand-mode or in a ftplugin(/after)? plugin.
" The option below is a boolean that enables/disables explicit linters. Set to
" 0 for the default behavior.
let g:ale_linters_explicit = 1

" Keep the sign gutter open always--don't know why ALE decides to "override"
" this...
let g:ale_sign_column_always = 1

" Set the error/warning icons to use
let g:ale_sign_error = "\uF057"
let g:ale_sign_warning = "\uF071"

" Integrate ALE with vim-airline.
let g:airline#extensions#ale#enabled = 1

" Configure linting only when you save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0 " Disable linting upon first opening a file
"
" Disable linting on file save:
let g:ale_lint_on_save = 0
"
" Disable warnings about trailing whitespace for files.
let b:ale_warn_about_trailing_whitespace = 1

Plug 'luochen1990/rainbow'
" interface to be used in order listed
" * `guis`: a list of `gui` (`:h highlight-gui`), used in order listed
" * `ctermfgs`: a list of `ctermfg` (`:h highlight-ctermfg`)
" * `cterms`: a list of `cterm` (`:h highlight-cterm`)
" * `operators`: describe the operators you want to highlight. (NOTE: be
"                careful about special characters which need escaping; you can find more
"                examples [here](https://github.com/luochen/1990/rainbow/issues3), and you
"                can also read the [vim help about
"                syn-pattern](https://vimdoc.sourceforge.net/htmldoct/syntax.html#.syn-pattern).
"                Note that this option will be overwritten by the `step` part of
"                `parentheses`.
" * `paretheses`: A list of parentheses definitions. A paretheses definition
"                 contains parts like `start=/(/`, `step=/,/`, `stop=/)/`, `fold`,
"                 `contained`,     `containedin=someSynNames`, `contains=@Spell`. See `:h syntax`
"                 for more details. Note that the `step` part is defined by this plugin and so
"                 it is not described by the official vim documentation.
" * `parentheses_options`: options shared between different paretheses; things
"                          like `containedin=xxxFuncBody`, `contains=@Spell` (or `contains=@NoSpell`)
"                          ofter appear here. This option is often used to resolve 3rd-party plugin
"                          compatibility issues.
" * `separately`: Configure for specific filetypes. For filetypes without
"                 separate configuration, value `0` means disable rainbow color only for this
"                 type of file. `default` means keep the default shim for this filetype.
" * `syn_name_prefix`: Add a prefix to the name of the syntax definition. This
"                      option is used to resolve 3rd-party plugin compatibility issues.
" * `after`: Execute some vim commands after the rainbow syntax definition.
"            Used to resolve 3rd-party plugin compatibility issues.
" * Keep a field empty to use the default setting.
"
" For more advanced configuration samples, try searching with this tag:
" http://github.com/luochen1990/rainbow/issues?utf8=y&q=label%3A"config+reference"+.
let g:rainbow_active = 1
let g:rainbow_conf = {
\    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\    'guis': [''],
\    'cterms': [''],
\    'operators': '_,_',
\    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\    'separately': {
\         '*': {},
\         'haskell': {
\             'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold']
\         },
\         'lisp': {
\             'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3']
\         },
\         'markdown': {
\             'parentheses_options': 'containedin-markdownCode contained'
\         },
\         'perl': {
\             'syn_name_prefix': 'perlBlockFoldRainbow'
\         },
\         'powershell': {
\             'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\{/ end=/\}/ fold']
\         },
\         'stylus': {
\             'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup']
\         },
\         'typescript': {
\             'parentheses': ['start=/{/ end=/}// fold contains=@colorableGroup', 'start=/(/ end=/)/', 'start=/\[/ end=l\]/']
\         },
\         'vim': {
\             'parentheses_options': 'containedin=vimFuncBody'
\         }
\    }
\}

Plug 'OmniSharp/omnisharp-vim'
if IsWSL()
    let g:OmniSharp_translate_cygwin_wsl = 1
endif
" Tell OminSharp to use the .NET 6 LS
let g:OmniSharp_server_use_net6 = 1
" Choose which code action selector UI will be used.
" Valid values are fzf, clap, ctrlp, unite, or ''.
let g:OmniSharp_selector_ui = ''
" Tell OmniSharp to syntax highlight even in insert mode
let g:OmniSharp_highlighting = 2

" Becasue this plugin is installed on all platforms, and the conditionals are only controlling how the
" post-install hooks are run, no need to 'conditionally load' this plugin.
if has('win32')
    Plug 'Shougo/vimproc.vim', {
    \   'branch': 'master',
    \   'do': 'curl -o C:\Users\cshea\.vim\plugged\vimproc.vim\lib\vimproc_win64.dll https://github.com/Shougo/vimproc.vim/releases/latest/download/vimproc_win64.dll'
    \}
elseif IsWSL()
    Plug 'Shougo/vimproc.vim', {
    \   'branch': 'master',
    \   'do': 'curl -o /c/Users/cshea/.vim/plugged/vimproc.vim/lib/vimproc_win64.dll https://github.com/Shougo/vimproc.vim/releases/latest/download/vimproc_win64.dll'
    \}
else
    Plug 'Shougo/vimproc.vim', { 'branch': 'master', 'do': 'make' }
endif

Plug 'SirVer/ultisnips'

" COC - Conqueror of Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Automatically install the following extensions if they are not already installed:
let g:coc_global_extensions=[
            \ 'coc-css',
            \ 'coc-deno',
            \ 'coc-emoji',
            \ 'coc-eslint',
            \ 'coc-highlight',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-powershell',
            \ 'coc-svelte',
            \ 'coc-svg',
            \ 'coc-tag',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-yaml',
            \ 'coc-yank'
            \]
"           \ 'coc-git',
"           \ 'ionide-coc-fsharp'
"           \ 'coc-omni',
"           \ 'coc-snippets',
"           \ 'coc-ultisnips',

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/stylelint')
  let g:coc_global_extensions += ['coc-stylelintplus']
endif

function! s:check_eslint()
  if !isdirectory('./node_modules') || !isdirectory('./node_modules/eslint')
    call coc#config('eslint', {
    \ 'enable': v:false,
    \ })
  endif
endfunction

augroup plugin_coc
    autocmd!
    autocmd BufEnter *.{js,jsx,ts,tsx} :call <SID>check_eslint()
augroup END

nmap <leader>do <Plug>(coc-codeaction)

Plug 'preservim/nerdcommenter'

Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings='human'
let g:vimspector_base_dir=$HOME."/.vim/plugged/vimspector"

Plug 'tpope/vim-commentary'
Plug 'tpop/vim-dotenv'
Plug 'tpope/vim-ragtag'
