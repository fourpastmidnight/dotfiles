" ============================================================================
" LSP CONFIGURATION MODULE
" This file configures vim-lsp, vim-lsp-settings, and language servers.
" ============================================================================

" Safety: do not load twice
if exists('g:loaded_lsp_config')
  finish
endif
let g:loaded_lsp_config = 1

" ============================================================================
" GENERAL LSP SETTINGS
" ============================================================================

" Enable LSP logging if needed
" let g:lsp_log_file = expand('~/.vim/lsp.log')

" Show diagnostics in the sign column
let g:lsp_signs_enabled = 1

" Use virtual text for diagnostics (ALE also provides this)
let g:lsp_virtual_text_enabled = 1

" Highlight references when cursor is on a symbol
let g:lsp_highlight_references_enabled = 1

" Use floating windows for hover/signature help
let g:lsp_float_enabled = 1

" ============================================================================
" KEYMAPS FOR LSP
" ============================================================================

" Use <Leader>l prefix for all LSP actions
nnoremap <silent> <Leader>ld :LspDefinition<CR>
nnoremap <silent> <Leader>lr :LspReferences<CR>
nnoremap <silent> <Leader>lt :LspTypeDefinition<CR>
nnoremap <silent> <Leader>li :LspImplementation<CR>
nnoremap <silent> <Leader>ls :LspDocumentSymbol<CR>
nnoremap <silent> <Leader>lw :LspWorkspaceSymbol<CR>
nnoremap <silent> <Leader>lh :LspHover<CR>
nnoremap <silent> <Leader>ln :LspRename<CR>
nnoremap <silent> <Leader>lf :LspDocumentFormat<CR>

" ============================================================================
" BUFFER-LOCAL LSP SETTINGS
" ============================================================================
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000

    " refer to doc to add more commands...
endfunction

augroup lsp_install
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server
    " registered
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ============================================================================
" LANGUAGE SERVER REGISTRATION
" vim-lsp-settings will auto-register most servers.
" ============================================================================

" Bash
if executable('bash-language-server')
    let g:lsp_settings['bash-language-server'] = {
    \  'cmd': ['bash-language-server', 'start'],
    \ }
endif

" C#
if executable('omnisharp')
    let g:lsp_settings['omnisharp'] = {
    \  'cmd': ['ominsharp'],
    \ }
endif

" F#
if executable('fsautocomplete')
    let g:lsp_settings['fsautocomplete'] = {
    \  'cmd': ['fsautocomplete'],
    \ }
endif

" PowerShell
if executable('pwsh')
    let g:lsp_settings['powershell-editor-services'] = {
    \  'cmd': ['pwsh', '-NoLogo', '-NoProfile', '-Command', 'PowerShellEditorServices.Host'],
    \ }
endif

" Python
if executable('pylsp')
    let g:lsp_settings['pylsp'] = {
    \  'cmd': ['pylsp'],
    \ }
endif

" ============================================================================
" CUSTOM SERVER CONFIGURATION (optional)
" ============================================================================

" Configure those LSP servers that vim-lsp-settings DOES NOT already know about

" Example: PowerShell Editor Services (if you want it later)
" if executable('pwsh')
"     call lsp#register_server({
"       'name': 'powershell',
"       'cmd': ['pwsh', '-NoLogo', '-NoProfile', '-Command', 'pwsh-es'],
"       'whitelist': ['ps1', 'psm1'],
"     })
" endif

" Configure those LSP Servers that vim-lsp-settings already know about
augroup LspCustomServers
    autocmd!

    " Add any other LSP server custom setting overrides here...
augroup END

" ============================================================================
" LSP UI CUSTOMIZATION
" ============================================================================

" Diagnostic signs
sign define LspError    text=✘ texthl=LspErrorSign
sign define LspWarning  text=▲ texthl=LspWarningSign
sign define LspInfo     text=● texthl=LspInfoSign
sign define LspHint     text=○ texthl=LspHintSign

" ============================================================================
" INTEGRATION WITH DDC (completion)
" ============================================================================
" ddc-source-lsp will automatically activate when LSP attaches.
" No extra config needed here unless you want custom behavior.

" ============================================================================
" AUTOCOMMANDS
" ============================================================================

augroup LspAutocmds
  autocmd!
  " Show diagnostics automatically when cursor stops
  autocmd CursorHold * LspHover
augroup END

