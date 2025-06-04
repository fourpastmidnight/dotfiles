" ============================================================================
" GIT CONFIGURATION MODULE
" ============================================================================

if exists('g:loaded_git_config')
  finish
endif
let g:loaded_git_config = 1

" ============================================================================
" vim-fugitive (no configuration needed)
" ============================================================================

" Fugitive works out of the box. Nothing to configure here.

" ============================================================================
" git-gutter configuration
" ============================================================================

" Platform-specific git executable detection
if exists('g:is_wsl') && g:is_wsl
    " If the WSL distro has git installed, use that, otheriwse fallback to
    " Windows
    if executable('/usr/bin/git')
        let g:gitgutter_git_executable = '/usr/bin/git'
    else
        let g:gitgutter_git_executable = '/mnt/c/Program\ Files/Git/bin/git.exe'
    endif
elseif exists('$MSYSTEM')
    " Git-for-Windows MinTTY: git is already on the path
    let g:gitgutter_git_executable = 'git'
elseif has('win32') || has('win64')
    " Windows or WSL: use Windows git
    let g:gitgutter_git_executable = 'C:/Program\ Files/Git/bin/git.exe'
else
    " Unix/Linux
    let g:gitgutter_git_executable = '/usr/bin/git'
endif

" Optional: always show gutter signs
let g:gitgutter_enabled = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" ============================================================================
" KEYMAPS (optional)
" ============================================================================

nnoremap <silent> <Leader>gh :GitGutterLineHighlightsToggle<CR>
nnoremap <silent> <Leader>gp :GitGutterPreviewHunk<CR>
nnoremap <silent> <Leader>gu :GitGutterUndoHunk<CR>
nnoremap <silent> <Leader>gs :GitGutterStageHunk<CR>

