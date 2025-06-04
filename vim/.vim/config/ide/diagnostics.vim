" ============================================================================
" DIAGNOSTICS CONFIGURATION MODULE
" This file configures ALE, diagnostic signs, linters, fixers, and formatting.
" ============================================================================

" Safety: do not load twice
if exists('g:loaded_diagnostics_config')
  finish
endif
let g:loaded_diagnostics_config = 1

" ============================================================================
" ALE — ASYNCHRONOUS LINTING ENGINE
" ============================================================================

" Enable ALE
let g:ale_enabled = 1

" Show signs in the gutter
let g:ale_sign_column_always = 1

" Use virtual text for diagnostics
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '▎'

" Diagnostic signs (match LSP signs for consistency)
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▲'
let g:ale_sign_info = '●'
let g:ale_sign_style_error = '✘'
let g:ale_sign_style_warning = '▲'

" ============================================================================
" ALE LINTER CONFIGURATION
" ============================================================================

" Use LSP diagnostics for Bash instead of shellcheck/shfmt
let g:ale_linters = {
    \ 'sh': ['language-server'],
    \ }

" ============================================================================
" ALE FIXERS (FORMATTERS)
" ============================================================================

" Enable fixers on save
let g:ale_fix_on_save = 1

" Fixer configuration
let g:ale_fixers = {
    \ 'python': ['autopep8', 'yapf', 'black'],
    \ 'sh': ['shfmt'],
    \ 'cs': ['dotnet-format'],
    \ 'fsharp': ['fantomas'],
    \ }

" ============================================================================
" LSP FORMATTING INTEGRATION
" ============================================================================

" Timeout for synchronous LSP formatting
let g:lsp_format_sync_timeout = 1000

" Formatting on save for languages using LSP formatting
augroup LspFormatting
    autocmd!
    autocmd BufWritePre *.rs,*.go LspDocumentFormatSync
augroup END

" ============================================================================
" BUFFER-LOCAL DIAGNOSTIC BEHAVIOR
" ============================================================================

augroup DiagnosticsBuffer
    autocmd!
    " Highlight trailing whitespace
    autocmd BufEnter * match ErrorMsg '\s\+$'
augroup END

" ============================================================================
" DIAGNOSTIC NAVIGATION KEYMAPS
" ============================================================================

" Use ALE navigation keys
nnoremap <silent> [d :ALEPrevious<CR>
nnoremap <silent> ]d :ALENext<CR>

" ============================================================================
" OPTIONAL: INTEGRATION WITH LSP DIAGNOSTICS
" ============================================================================

" ALE will display LSP diagnostics automatically when using language-server linters.
" No extra configuration needed here.


