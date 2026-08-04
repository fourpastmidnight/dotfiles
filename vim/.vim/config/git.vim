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

nnoremap <silent> <Leader>ggt :GitGutterLineHighlightsToggle<CR>
nnoremap <silent> <Leader>ggp :GitGutterPreviewHunk<CR>

" git status
nnoremap <leader>gst :GStatus<CR>
" git add -p
nnoremap <leader>gap :GitGutterStageHunk<CR>
" git remove -p
nnoremap <leader>grp :GitGutterUndoHunk<CR>
nnoremap <leader>gd  :Gvdiffsplit<CR>
nnoremap <leader>gD  :Gdiffsplit<CR>
nnoremap ]x          :ConflictedNext<CR>
nnoremap [x          :ConflictedPrev<CR>
nnoremap <leader>gb  :Gblame<CR>
nnoremap <leader>gc  :GV<CR>
nnoremap <leader>gC  :GV!<CR>
nnoremap <leader>gl  :Merginal<CR>

" A completion function that is used to get items from vim-fugitive to
" tab-complete a comamnd.
function! s:FugitiveComplete(A, L, P) abort
    return fugitive#Complete(a:A, a:L, a:P)
endfunction

" The below implements a keymap binding for 'git fetuch <upstream>' where
" <upstream> is pre-populated with the default remote for the repository while
" still supporting tab completion for available repo remotes.
function! s:GetDefaultGitRemote() abort
    let l:upstream = system('git rev-parse --abbrev-ref @{upstream} 2>/dev/null')
    if v:shell_error
        return 'origin'
    endif
    return split(l:upstream, '/')[0]
endfunction

command! -nargs=1 -complete=customlist,s:FugitiveComplete GfetchRemote execute 'Gfetch ' . <q-args>

" git fetch <default-upstream> (with <Tab> completion support)
nnoremap <leader>gfr :execute 'GfetchRemote ' . <SID>GetDefaultGitRemote() . ' '<CR>

" The below implements a keybinding for 'git checkout <default-branch>' where
" <default-branch> is pre-populated with the name of the repo's default branch
" (e.g. master, main) while still supporting tab completion.
function! s:GetDefaultBranch() abort
    let l:upstream = system('git rev-parse --abbrev-ref @{upstream} 2>/dev/null')
    if v:shell_error
        return 'master'
    endif
    return split(l:upstream, '/')[1]
endfunction

command! -nargs=1 -complete=customlist,s:FugitiveComplete GcheckoutBranch execute 'Gcheckout ' . <q-args>

" I decided to use gcr as a menomic for 'git checkout ref'
nnoremap <leader>gcr :execute 'GcheckoutBranch ' . <SID>GetDefaultBranch() . ' '<CR>

" This function will get the current branch to prepopulate for 'gp' and 'gP'
" (git push/pull, respectively), defined below.
function! s:GetCurrentBranch() abort
    let l:branch = system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
    if v:shell_error
        return ''
    endif
    return trim(l:branch)
endfunction

" git stash save
nnoremap <leader>gss :Gstash save<CR>
" git stash pop
nnoremap <leader>gsp :Gstash pop<CR>
" git stash push
nnoremap <leader>gsP :Gstash push<CR>
" git stash apply
nnoremap <leader>gsa :Gstash apply<CR>
" git stash drop
nnoremap <leader>gsd :Gstash drop<CR>
" git stash list
nnoremap <leader>gsl :Gstash list<CR>
" git show
nnoremap <leader>gsh :Gshow<CR>
" git push
command! -nargs=+ -complete=customlist,s:FugitiveComplete GpushRev execute 'Gpush ' . join(<q-args>)
nnoremap <leader>gp  :execute 'GpushRev ' . <SID>GetDefaultGitRemote() . ' ' . <SID>GetCurrentBranch() . ' '<CR>
" git pull
command! -nargs=+ -complete=customlist,s:FugitiveComplete GpullRev execute 'Gpull ' . join(<q-args>)
nnoremap <leader>gP  :execute 'GpullRev ' . <SID>GetDefaultGitRemote() . ' ' . <SID>GetCurrentBranch() . ' '<CR>

" Fuzzy Git search
nnoremap <leader>gff :GFiles<CR>
nnoremap <leader>gfm :GFiles?<CR>
nnoremap <leader>gfc :Commits<CR>
nnoremap <leader>gfC :BCommits<CR>
nnoremap <leader>gfb :GBranches<CR>

augroup vimrc_git
    autocmd!
    autocmd FileType fugitive nnoremap <buffer> [c [h
    autocmd FileType fugitive nnoremap <buffer> ]c ]h
augroup END
