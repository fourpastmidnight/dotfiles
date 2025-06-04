" ====================================================================
" Configure sheerun/vim-polyglot
" ====================================================================

if exists('g:loaded_polyglot_config')
    finish
endif
let g:loaded_polyglot_config = 1

" Disable plugin languages (or aspects thereof)
let g:polyglot_disabled = [
\   'autoindent',
\   'sensible',
\   'ionide',
\   'javascript.plugin'
\]
