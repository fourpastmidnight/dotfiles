" ============================================================================
" COMPLETION CONFIGURATION MODULE
" This file configures ddc.vim, pum.vim, and completion sources/filters.
" ============================================================================

" Safety: do not load twice
if exists('g:loaded_completion_config')
  finish
endif
let g:loaded_completion_config = 1

" ============================================================================
" Load plugins
" ============================================================================
" ddc.vim core
" ddc-ui-pum
" ddc-source-around
" ddc-source-buffer
" ddc-source-lsp
" ddc-filter-matcher_head
" ddc-filter-sorter_rank
" pum.vim

" ============================================================================
" DDC.VIM — COMPLETION ENGINE
" ============================================================================

" Core ddc configuration
call ddc#custom#patch_global({
    \ 'sources': ['lsp', 'around', 'buffer'],
    \ 'sourceOptions': {
    \   '_': {
    \     'matchers': ['matcher_head'],
    \     'sorters': ['sorter_rank'],
    \     'converters': [],
    \   },
    \   'lsp': {
    \     'mark': 'LSP',
    \     'forceCompletionPattern': '\.\w*',
    \   },
    \   'around': { 'mark': 'A' },
    \   'buffer': { 'mark': 'B' },
    \ },
    \ 'sourceParams': {
    \   'buffer': { 'requireSameFiletype': v:false },
    \ },
    \ 'ui': 'pum',
    \ 'autoCompleteEvents': ['InsertEnter', 'TextChangedI', 'TextChangedP'],
\ })

call ddc#enable()

" ============================================================================
" PUM.VIM — POPUP MENU UI
" ============================================================================
" pum.vim provides the completion popup UI used by ddc.vim.

" Basic pum settings
let g:pum#border = 'single'
let g:pum#max_height = 15
let g:pum#max_width = 60
let g:pum#highlight_normal = 'Pmenu'
let g:pum#highlight_border = 'Pmenu'

" ============================================================================
" KEYMAPS FOR COMPLETION
" ============================================================================

" Use pum.vim mappings for completion navigation
inoremap <silent><expr> <Tab>   pum#visible() ? pum#map#select_relative(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab> pum#visible() ? pum#map#select_relative(-1) : "\<S-Tab>"
inoremap <silent><expr> <CR>    pum#visible() ? pum#map#confirm() : "\<CR>"
inoremap <silent><expr> <C-e>   pum#visible() ? pum#map#cancel() : "\<C-e>"

" ============================================================================
" OPTIONAL: LSP-SPECIFIC COMPLETION TWEAKS
" ============================================================================
" ddc-source-lsp automatically activates when LSP attaches.
" No extra config needed unless you want custom behavior.
"
