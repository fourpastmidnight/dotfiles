" NOTE: godlygeek/tabular MUST be loaded before preservim/vim-markdown.
"       It just so happens that I put that plugin in formatting/alignment.vim and am loading it BEFORE the
"       files in this directory.
Plug 'preservim/vim-markdown', { 'for': 'markdown' }
" Configure the vim_markdown plugin
let g:vim_markdown_fenced_languages = [
\   'bash=sh',
\   'conf',
\   'csharp=cs',
\   'css',
\   'c++=cpp',
\   'f#',
\   'help',
\   'html',
\   'ini=dosini',
\   'javascript',
\   'json',
\   'less',
\   'powershell=ps1',
\   'scss',
\   'toml',
\   'typescript',
\   'viml=vim',
\   'yaml'
\]
let g:markdown_syntax_conceal = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_edit_url_in = 'current'  " Supported values: tab, vsplit, hsplit, current

" I turned off the default key mappings becasue they're horrible. And 'ge' is used by this plugin which
" shadows an important vim function: go to end of previous word.
" Instead, let's create our own mappings
nmap <buffer><silent> gb :call <Plug>Markdown_OpenUrlUnderCursor
vmap <buffer><silent> gb <esc>:call normal! gv <bar> call <Plug>Markdown_OpenUrlUnderCursor<CR>
nmap <buffer><silent> gf :call <Plug>Markdown_EditUrlUnderCursor
vmap <buffer><silent> gf <esc>:call normal! gv <bar> call <Plug>Markdown_EditUrlUnderCursor<CR>

" Now map sosme shortcuts for navigating between headers, moving headings from h1 to h6 and vice versa,
" etc.
nmap <buffer><silent> [# :call <Plug>Markdown_MoveToPreviousHeader
vmap <buffer><silent> [# <esc>:call normal! gv <bar> call <Plug>Markdown_MoveToPreviousHeader<CR>
nmap <buffer><silent> ]# :call <Plug>Markdown_MoveToNextHeader
vmap <buffer><silent> ]# <esc>:call narmal! gv <bar> call <Plug>Markdown_MoveToNextHeader<CR>
