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

" ----------------------------------------------------------------------------
"    KEYMAP HELPER FUNCTIONS
" ----------------------------------------------------------------------------

" A completion function that is used to get items from vim-fugitive to
" tab-complete a comamnd. This is used in many commands below, which are later
" used in many keybindings.
function! s:FugitiveComplete(A, L, P) abort
    return fugitive#Complete(a:A, a:L, a:P)
endfunction

function! s:GetGitRepoRoot() abort
    let l:root = <SID>ShellExecute('git rev-parse --show-toplevel')
    if v:shell_error
        return ''
    endif
    return trim(l:root)
endfunction

" This function gets the default upstream branch for the current git repository.
function! s:GetUpstreamRef() abort
    let l:upstream = <SID>ShellExecute('git rev-parse --abbrev-ref @{upstream}')
    if v:shell_error
        return ''
    endif
    return trim(l:upstream)
endfunction

" This function gets the default remote for the current git repository.
function! s:GetDefaultGitRemote() abort
    let l:ref = <SID>GetUpstreamRef()
    if empty(l:ref)
        return 'origin'
    endif
    return split(l:ref, '/')[0]
endfunction

" This function gets the default branch for the current git repository, e.g. master, main, etc.
function! s:GetDefaultBranch() abort
    let l:ref = <SID>GetUpstreamRef()
    if empty(l:ref)
        return 'master'
    endif
    return split(l:ref, '/')[1]
endfunction

" This function gets the currently checked out branch
function! s:GetCurrentBranch() abort
    let l:branch = <SID>ShellExecute('git rev-parse --abbrev-ref HEAD')
    if v:shell_error
        return ''
    endif
    return trim(l:branch)
endfunction

" Get available git worktrees for tab completion
function! s:WorktreePathComplete(A, L, P) abort
    let l:list = <SID>ShellExecute('git worktree list --porcelain')
    let l:paths = filter(split(l:list, "\n"), {_, v -> v =~ '^worktree '})
    return map(l:paths, {_, v -> substitute(v, '^worktree ', '', '')})
endfunction

let g:worktree_tabline = '%i '
let s:worktree_icon = s:has_devicons ? ' ' : 'Git Worktree: '
let s:branch_icon   = s:has_devicons ? ' ' : ''

"function! s:WorktreeBranchForTab(tabnr) abort
"    let cwd = getcwd(-1, a:tabnr)
"    let headfile = cwd . '/.git/HEAD'
"
"    if filereadable(headfile)
"        let head = readfile(headfile)
"        if !empty(head) && head[0] =~ '^ref:'
"            return substitute(head[0], '^ref: refs/heads/', '', '')
"        endif
"    endif
"
"    " Fallback: use directory name
"    return fnamemodify(cwd

" ----------------------------------------------------------------------------
"    CUSTOM GIT COMMANDS
" ----------------------------------------------------------------------------

" A :GfetchRemote command that provides <Tab> completion for vim-fugitive's :Gfetch command
command! -nargs=1 -complete=customlist,s:FugitiveComplete GfetchRemote execute 'Gfetch ' . <q-args>

" A :GcheckoutBranch command that provides <Tab> completion for vim-fugitive's :Gcheckout command.
command! -nargs=1 -complete=customlist,s:FugitiveComplete GcheckoutBranch execute 'Gcheckout ' . <q-args>

" A :GpushRev command that provides <Tab> completion for vim-fugitive's :Gpush
" command. This allows multiple branches to be pushed at once.
command! -nargs=+ -complete=customlist,s:FugitiveComplete GpushRev execute 'Gpush ' . join(<q-args>)

" A :GpullRev command that provides <Tab> completion for vim-fugitive's :Gpull
" command. This allows multiple branches to be pulled at once.
command! -nargs=+ -complete=customlist,s:FugitiveComplete GpullRev execute 'Gpull ' . join(<q-args>)

" A :GrebaseInteractive command that autostashes unstaged changes and
" autosquashes commits
command! -nargs=+ -complete=customlist,s:FugitiveComplete GrebaseInteractive execute 'G rebase -i --autostash --autosquash ' . <q-args>

" A :GrebaseInteractiveNoSquash command that autostashes unstanged changes but
" does NOT autosquash commits
command! -nargs=+ -complete=customlist,s:FugitiveComplete GrebaseInteractiveNoSquash execute 'G rebase -i --autostash ' . <q-args>

" A :GrebaseOnto command that provides <Tab> completion
command! -nargs=+ -complete=customlist,s:FugitiveComplete GrebaseOnto execute 'G rebase --onto ' . <q-args>

" A :GrebaseKeepBase command that provides <Tab> completion
command! -nargs=+ -complete=customlist,s:FugitiveComplete GrebaseKeepBase execute 'G rebase --keep-base ' . <q-args>

" A :GrebaseUpstream command that performs a simple rebase of a local branch
" to the remote branch--usually resulting in a fast-forwand rebase.
command! execute 'G rebase ' . <SID>GetUpstreamRef()

" Some helper commands for git rebase --abort, --continue, and --skip, etc.
command! GrebaseContinue         execute 'G rebase --continue'
command! GrebaseSkip             execute 'G rebase --skip'
command! GrebaseAbort            execute 'G rebase --abort'
command! GrebaseQuit             execute 'G rebase --quit'
command! GrebaseEditTodo         execute 'G rebase --edit-todo'
command! GrebaseShowCurrentPatch execute 'G rebase --show-current-patch'

command! -nargs=+ -complete=customlist,s:FugitiveComplete GworktreeAdd execute 'G worktree add ' . <q-args>
command! GworktreeList           execute 'G worktree list'
command! -nargs=1 GworktreeRemove execute 'G worktree remove ' . <q-args>
command! -nargs=1 GworktreeTab   call s:OpenGitWorktreeTab(<q-args>)

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

" git fetch <default-upstream> (with <Tab> completion support)
nnoremap <leader>gfr :execute 'GfetchRemote ' . <SID>GetDefaultGitRemote() . ' '<CR>

" git push
nnoremap <leader>gp  :execute 'GpushRev ' . <SID>GetDefaultGitRemote() . ' ' . <SID>GetCurrentBranch() . ' '<CR>

" git pull
nnoremap <leader>gP  :execute 'GpullRev ' . <SID>GetDefaultGitRemote() . ' ' . <SID>GetCurrentBranch() . ' '<CR>

" git checkout <ref>; usually <ref> is a branch, but it could be any ref.
nnoremap <leader>gcr :execute 'GcheckoutBranch ' . <SID>GetDefaultBranch() . ' '<CR>

" git show
nnoremap <leader>gsh :Gshow<CR>

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

nnoremap <leader>gra :GrebaseAbort<CR>
nnoremap <leader>grc :GrebaseContinue<CR>
nnoremap <leader>gri :execute 'GrebaseInteractive ' . <SID>GetUpstreamRef() . ' '<CR>
nnoremap <leader>grI :execute 'GrebaseInteractiveNoSquash ' . <SID>GetUpstreamref() . ' '<CR>
nnoremap <leader>gro :execute 'GrebaseOnto ' . <SID>GetUpstreamRef() . ' ' . <SID>GetCurrentBranch() . ' '<CR>
nnoremap <leader>grO :execute 'GrebaseKeepBase ' . <SID>GetUpstreamRef() . ' ' . <SID>GetCurrentBranch() . ' '<CR>
nnoremap <leader>grq :GrebaseQuit<CR>
nnoremap <leader>grs :GrebaseShowCurrentPatch<CR>
nnoremap <leader>grt :GrebaseEditTodo<CR>
nnoremap <leader>gru :GrebaseUpstream<CR>

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
