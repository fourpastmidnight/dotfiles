" ====================================================================
" JavaScript React (JSX) filetype module
" ====================================================================

if exists('g:loaded_javascriptreact_config')
  finish
endif
let g:loaded_javascriptreact_config = 1

" These settings apply ONLY when editing JavaScript/TypeScript files.
" They run AFTER filetype detection and AFTER syntax/indent plugins load.
augroup ft_javascriptreact
  autocmd!

  " Enable syntax folding for JS/TS

  " pangloss/vim-javascript
  autocmd FileType javascriptreact setlocal foldmethod=syntax

  " Optional: conceal tweaks (if you want them)
  " autocmd FileType javascriptreact   setlocal conceallevel=1
  " Or:
  " autocmd Filetype javascriptreact   nnoremap <buffer> <leader>c :exec &l:conceallevel ? 'setlocal conceallevel=0' : 'setlocal conceallevel=1'<CR>

  " Optional: buffer-local mappings for JS/TS
  " autocmd FileType javascriptreact   nnoremap <buffer> <leader>f :JsBeautify<CR>

  " Optional: plugin-specific per-filetype commands
  " autocmd FileType javascriptreact   call SomePlugin#InitForJSX()
augroup END
