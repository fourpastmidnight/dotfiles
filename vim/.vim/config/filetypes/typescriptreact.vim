" ====================================================================
" Typescript React (TSX) filetype module
" ====================================================================

if exists('g:loaded_typescriptreact_config')
  finish
endif
let g:loaded_typescriptreact_config = 1

" These settings apply ONLY when editing JavaScript/TypeScript files.
" They run AFTER filetype detection and AFTER syntax/indent plugins load.
augroup ft_typescriptreact
  autocmd!

  " Enable syntax folding for JS/TS

  " pangloss/vim-javascript
  autocmd FileType typescriptreact setlocal foldmethod=syntax

  " Optional: conceal tweaks (if you want them)
  " autocmd FileType typescriptreact   setlocal conceallevel=1
  " Or:
  " autocmd Filetype typescriptreact   nnoremap <buffer> <leader>c :exec &l:conceallevel ? 'setlocal conceallevel=0' : 'setlocal conceallevel=1'<CR>

  " Optional: buffer-local mappings for JS/TS
  " autocmd FileType typescriptreact   nnoremap <buffer> <leader>f :TsBeautify<CR>

  " Optional: plugin-specific per-filetype commands
  " autocmd FileType typescriptreact   call SomePlugin#InitForTSX()
augroup END

