" ====================================================================
" Typescript filetype module
" ====================================================================

if exists('g:loaded_typescript_config')
  finish
endif
let g:loaded_typescript_config = 1

" These settings apply ONLY when editing JavaScript/TypeScript files.
" They run AFTER filetype detection and AFTER syntax/indent plugins load.
augroup ft_typescript
  autocmd!

  " Enable syntax folding for JS/TS

  " pangloss/vim-javascript
  autocmd FileType typescript setlocal foldmethod=syntax

  " Optional: conceal tweaks (if you want them)
  " autocmd FileType typescript   setlocal conceallevel=1
  " Or:
  " autocmd Filetype typescript   nnoremap <buffer> <leader>c :exec &l:conceallevel ? 'setlocal conceallevel=0' : 'setlocal conceallevel=1'<CR>

  " Optional: buffer-local mappings for JS/TS
  " autocmd FileType typescript   nnoremap <buffer> <leader>f :TsBeautify<CR>

  " Optional: plugin-specific per-filetype commands
  " autocmd FileType typescript   call SomePlugin#InitForTS()
augroup END

