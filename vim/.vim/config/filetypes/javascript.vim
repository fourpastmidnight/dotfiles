" ====================================================================
" JavaScript filetype module
" ====================================================================

if exists('g:loaded_javascript_config')
  finish
endif
let g:loaded_javascript_config = 1

" I prefer to use yuesk/vim-js for JavaScript syntax highlighting.
" Otherwise, pangloss/vim-javascript for everything else (included with
" sheerun/polyglot)

" ====================================================================
"   yuezk/vim-js
" ====================================================================

" There are no configuration settings for this plugin.


" ====================================================================
"   pangloss/vim-javascript (via sheerun/vim-polyglot)
" ====================================================================
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

"let g:javascript_conceal_function             = "ƒ"
"let g:javascript_conceal_null                 = "ø"
"let g:javascript_conceal_this                 = "@"
"let g:javascript_conceal_return               = "⇚"
"let g:javascript_conceal_undefined            = "¿"
"let g:javascript_conceal_NaN                  = "ℕ"
"let g:javascript_conceal_prototype            = "¶"
"let g:javascript_conceal_static               = "•"
"let g:javascript_conceal_super                = "Ω"
"let g:javascript_conceal_arrow_function       = "⇒"
"let g:javascript_conceal_noarg_arrow_function = "🞅"
"let g:javascript_conceal_underscore_arrow_function = "🞅"

" These settings apply ONLY when editing JavaScript/TypeScript files.
" They run AFTER filetype detection and AFTER syntax/indent plugins load.
augroup ft_javascript
  autocmd!

  " Enable syntax folding for JS/TS

  " pangloss/vim-javascript
  autocmd FileType javascript        setlocal foldmethod=syntax

  " Optional: conceal tweaks (if you want them)
  " autocmd FileType javascript        setlocal conceallevel=1
  " Or:
  " autocmd Filetype javascript        nnoremap <buffer> <leader>c :exec &l:conceallevel ? 'setlocal conceallevel=0' : 'setlocal conceallevel=1'<CR>

  " Optional: buffer-local mappings for JS/TS
  " autocmd FileType javascript        nnoremap <buffer> <leader>f :JsBeautify<CR>

  " Optional: plugin-specific per-filetype commands
  " autocmd FileType javascript        call SomePlugin#InitForJS()
augroup END

