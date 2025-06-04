" ====================================================================
" Markdown filetype module (preservim/vim-markdown)
" ====================================================================

" NOTE:
" " vim-markdown extends godlygeek/tabular. Ensure tabular loads BEFORE
" " vim-markdown in plugins.vim. No action is required here.

" --------------------------------------------------------------------
" 1. Load‑time plugin settings
" --------------------------------------------------------------------
let g:markdown_fenced_languages = [
      \ 'html', 'javascript', 'typescript', 'powershell=ps1', 'c#', 'f#',
      \ 'css', 'scss', 'less', 'bash=sh', 'conf', 'json', 'toml', 'yaml'
      \]

let g:vim_markdown_fenced_languages = [
      \ 'html', 'javascript', 'typescript', 'powershell=ps1', 'c#', 'f#',
      \ 'css', 'scss', 'less', 'bash=sh', 'conf', 'help', 'json', 'toml',
      \ 'vim', 'yaml'
      \]

let g:markdown_syntax_conceal = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 1

let g:vim_markdown_folding = 1
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1

let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_math = 1

let g:vim_markdown_no_default_keyMappings = 0

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

let g:vim_markdown_strikethrough = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1

" Supported values: tab, vsplit, hsplit, current
let g:vim_markdown_edit_url_in = 'current'


" --------------------------------------------------------------------
" 2. Filetype-specific configuration
" --------------------------------------------------------------------
" These settings apply ONLY when editing Markdown files.
" They run AFTER filetype detection and AFTER vim-markdown loads.

augroup ft_markdown
  autocmd!

  " Conceal level for Markdown buffers
  autocmd FileType markdown setlocal conceallevel=2

  " Optional: toggle conceal with <leader>c
  " autocmd FileType markdown nnoremap <buffer> <leader>c :exec &l:conceallevel ? 'setlocal conceallevel=0' : 'setlocal conceallevel=2'<CR>

  " Optional: Markdown-specific formatting or mappings can go here

augroup END

