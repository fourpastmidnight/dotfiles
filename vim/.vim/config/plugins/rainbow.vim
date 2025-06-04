" ====================================================================
" Rainbow parentheses module (luochen1990/rainbow)
" ====================================================================

if exists('g:loaded_rainbow_config')
    finish
endif
let g:loaded_rainbow_config = 1

" --------------------------------------------------------------------
" 1. Load‑time plugin settings
" --------------------------------------------------------------------
" Rainbow reads g:rainbow_conf when its syntax files load.

" interface to be used in order listed
" * `guis`: a list of `gui` (`:h highlight-gui`), used in order listed
" * `ctermfgs`: a list of `ctermfg` (`:h highlight-ctermfg`)
" * `cterms`: a list of `cterm` (`:h highlight-cterm`)
" * `operators`: describe the operators you want to highlight. (NOTE: be
" careful about special characters which need escaping; you can find more
" examples [here](https://github.com/luochen/1990/rainbow/issues3), and you
" can also read the [vim help about
" syn-pattern](https://vimdoc.sourceforge.net/htmldoct/syntax.html#.syn-pattern).
" Note that this option will be overwritten by the `step` part of
" `parentheses`.
" * `paretheses`: A list of parentheses definitions. A paretheses definition
" contains parts like `start=/(/`, `step=/,/`, `stop=/)/`, `fold`,
" `contained`,     `containedin=someSynNames`, `contains=@Spell`. See `:h syntax`
" for more details. Note that the `step` part is defined by this plugin and so
" it is not described by the official vim documentation.
" * `parentheses_options`: options shared between different paretheses; things
" like `containedin=xxxFuncBody`, `contains=@Spell` (or `contains=@NoSpell`)
" ofter appear here. This option is often used to resolve 3rd-party plugin
" compatibility issues.
" * `separately`: Configure for specific filetypes. For filetypes without
" separate configuration, value `0` means disable rainbow color only for this
" type of file. `default` means keep the default shim for this filetype.
" * `syn_name_prefix`: Add a prefix to the name of the syntax definition. This
" option is used to resolve 3rd-party plugin compatibility issues.
" * `after`: Execute some vim commands after the rainbow syntax definition.
" Used to resolve 3rd-party plugin compatibility issues.
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
\         'markdown': {
\             'parentheses_options': 'containedin-markdownCode contained'
\         },
\         'lisp': {
\             'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3']
\         },
\         'haskell': {
\             'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold']
\         },
\         'vim': {
\             'parentheses_options': 'containedin=vimFuncBody'
\         },
\         'perl': {
\             'syn_name_prefix': 'perlBlockFoldRainbow'
\         },
\         'posh': {
\             'parentheses': [
\                 'start=/(/ end=/)/ fold', 'start=/\\[/ end=\\]/ fold', 'start=/{/ end=/}/ fold'
\             ],
\             'syn_name_prefix': 'poshRainbow',
\             'parentheses_options': 'containedin=poshXmlScriptBlock'
\         },
\         'stylus': {
\             'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup']
\         },
\         'typescript': {
\             'parentheses': ['start=/{/ end=/}// fold contains=@colorableGroup', 'start=/(/ end=/)/', 'start=/\[/ end=l\]/']
\         }
\    }
\}
