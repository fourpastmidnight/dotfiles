" ============================================================================
" VIMSPECTOR DEBUGGING MODULE
" This file configures Vimspector, debug adapters, and debugging keymaps.
" ============================================================================

" Safety: do not load twice
if exists('g:loaded_vimspector_config')
  finish
endif
let g:loaded_vimspector_config = 1

" ============================================================================
" GENERAL VIMSPECTOR SETTINGS
" ============================================================================

" Always show the Vimspector UI when debugging starts
let g:vimspector_enable_mappings = 'HUMAN'

" Optional: where Vimspector stores its config files
let g:vimspector_base_dir = expand('~/.config/vimspector')

" ============================================================================
" DEBUG ADAPTER CONFIGURATION
" ============================================================================

" Install appropriate debug adapters depending on platform
if has('win32') || has('win64')
  let g:vimspector_install_gadgets = ['debugpy', 'netcoredbg']
else
  let g:vimspector_install_gadgets = ['debugpy', 'netcoredbg', 'bashdb']
endif
" You can place per-project .vimspector.json files in your project root.
" These global defaults apply when no project file exists.

let g:vimspector_configurations = {
\   'C#': {
\     'adapter': 'netcoredbg',
\     'configuration': {
\       'request': 'launch',
\       'program': '${workspaceRoot}/bin/Debug/net6.0/YourApp.dll',
\     },
\   },
\   'F#': {
\     'adapter': 'netcoredbg',
\     'configuration': {
\       'request': 'launch',
\       'program': '${workspaceRoot}/bin/Debug/net6.0/YourApp.dll',
\     },
\   },
\   'Python': {
\     'adapter': 'debugpy',
\     'configuration': {
\       'request': 'launch',
\       'program': '${file}',
\     },
\   },
\   'Bash': {
\     'adapter': 'bashdb',
\     'configuration': {
\       'request': 'launch',
\       'program': '${file}',
\     },
\   },
\ }

" ============================================================================
" KEYMAPS FOR DEBUGGING
" ============================================================================

" Start debugging
nnoremap <silent> <Leader>ds :call vimspector#Launch()<CR>

" Stop debugging
nnoremap <silent> <Leader>dx :call vimspector#Reset()<CR>

" Step over / into / out
nnoremap <silent> <Leader>dn :call vimspector#StepOver()<CR>
nnoremap <silent> <Leader>di :call vimspector#StepInto()<CR>
nnoremap <silent> <Leader>do :call vimspector#StepOut()<CR>

" Toggle breakpoint
nnoremap <silent> <Leader>db :call vimspector#ToggleBreakpoint()<CR>

" Add conditional breakpoint
nnoremap <silent> <Leader>dB :call vimspector#AddConditionalBreakpoint()<CR>

" Evaluate expression under cursor
nnoremap <silent> <Leader>de :call vimspector#Evaluate()<CR>

" ============================================================================
" BUFFER-LOCAL BEHAVIOR
" ============================================================================

augroup VimspectorBuffer
    autocmd!
    " Highlight breakpoints
    autocmd FileType cs,fs,python,sh sign define VimspectorBP text=● texthl=WarningMsg
augroup END

" ============================================================================
" OPTIONAL: UI CUSTOMIZATION
" ============================================================================

" Customize Vimspector windows
let g:vimspector_sidebar_width = 40
let g:vimspector_terminal_height = 15
let g:vimspector_code_minwidth = 80


