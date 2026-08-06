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

" ============================================================================
"   airline-gitworktree extension
" ============================================================================

if !exists('g:airline#extensions#gitworktree#symbols')
    let g:airline#extensions#gitworktree#symbols = {}
endif

let s:symbols = g:airline#extensions#gitworktree#symbols

let s:symbols.worktree                = get(s:symbols, 'worktree',                '')
let s:symbols.branch                  = get(s:symbols, 'branch',                  '')
let s:symbols.branch_missing          = get(s:symbols, 'branch_missing',          '')
let s:symbols.sep                     = get(s:symbols, 'sep',                     get(g:airline_symbols, 'left_sep', ''))
let s:symbols.alt_sep                 = get(s:symbols, 'alt_sep',                 get(g:airline_symbols, 'left_alt_sep', ''))
let s:symbols.fallback_worktree       = get(s:symbols, 'fallback_worktree',       'Git Worktree:')
let s:symbols.fallback_branch         = get(s:symbols, 'fallback_branch',         '')
let s:symbols.fallback_branch_missing = get(s:symbols, 'fallback_branch_missing', '/')

let g:airline#extensions#gitworktree#template = get(g:, 'airline#extensions#gitworktree#template', '%worktree %alt_sep %branch %alt_sep %name')

function! airline#extensions#gitworktree#apply_repo_colors(repo_id) abort
    " To define per-repo overrides for icons and colors, define a dictionary as shown below:
    "
    " let g:airline#extensions#gitworktree#repo_overrides = {
    " \ '/home/craig/src/a/b/c/my-repo/.git': {
    " \     'colors': {
    " \         'active':   ['#ffffff', '#005f87'],
    " \         'inactive': ['#d0d0d0', '#303030'],
    " \     },
    " \     'icons': {
    " \         'worktree_icon': '',
    " \         'branch_icon':   '',
    " \         'branch_missing_icon': '',
    " \     },
    " \     'order': 0,
    " \ },
    " \ '/home/craig/src/d/e/f/my-repo/.git': {
    " \     'colors': {
    " \         'active':   ['#ffffff', '#875f00'],
    " \         'inactive': ['#d0d0d0', '#303030'],
    " \     },
    " \     'icons': {
    " \         'worktree_icon': '',
    " \         'branch_icon':   '',
    " \     },
    " \     'order': 1,
    " \ },
    " \ } as shown below:
    let overrides = get(g:, 'airline#extensions#gitworktree#repo_overrides', {})

    if !has_key(overrides, a:repo_id)
        return
    endif

    let cfg = overrides[a:repo_id]
    if !has_key(cfg, 'colors')
        return
    endif

    let colors = cfg.colors

    if has_key(colors, 'inactive')
        let fg = colors.inactive[0]
        let bg = colors.inactive[1]
        execute 'hi airline_gitworktree_repo_inactive guifg=' . fg . ' guibg=' . bg
    endif

    if has_key(colors, 'active')
        let fg = colors.active[0]
        let bg = colors.active[1]
        execute 'hi airline_gitworktree_repo_active guifg=' . fg . ' guibg=' . bg
    endif
endfunction

function! airline#extensions#gitworktree#repo_sort_key(repo_id) abort
    let overrides = get(g:, 'airline#extensions#gitworktree#repo_overrides', {})

    if has_key(overrides, a:repo_id) && has_key(overrides[a:repo_id], 'order')
        return overrides[a:repo_id].order
    endif

    " Fallback to full path lexicographical ordering
    return 10000 + a:repo_id
endfunction

function! airline#extensions#gitworktree#apply_repo_icons(repo_id, symbols) abort
    let overrides = get(g:, 'airline#extensions#gitworkingtree#repo_overrides', {})

    if !has_key(overrides, a:repo_id)
        return a:symbols
    endif

    let cfg = overrides[a:repo_id]
    if has_key(cfg, 'icons')
        for key in keys(cfg.icons)
            let a:symbols[key] = cfg.icons[key]
        endfor
    endif

    return a:symbols
endfunction

function! airline#extensions#gitworktree#trim_repo_name(name) abort
    let maxlen = get(g:, 'airline#extensions#gitworktree#repo_name_maxlen', 20)
    " Trimming mode: 'none', 'prefix', 'suffix', 'both', 'middle'
    let mode   = get(g:, 'airline#extensions#gitworktree#repo_trim_mode', 'none')

    if strlen(a:name) <= maxlen || mode ==# 'none'
        return a:name
    endif

    switch mode
        case 'prefix'
            return '…' . a:name[-maxlen:]
        case 'suffix'
            return a:name[:maxlen] . '…'
        case 'both'
            return '…' . a:name[:maxlen] . '…'
        case 'middle'
            let half = maxlen / 2
            return a:name[:half] . '…' . a:name[-half:]
        default " (none)
            return a:name
    endswitch
endfunction

function! airline#extensions#gitworktree#format_info(tabnr) abort
    let cwd = getcwd(-1, a:tabnr)
    let headfile = cwd . '/.git/HEAD'

    " Get repo name
    let commondir_file = cwd . '/.git/commondir'
    let commondir = filereadable(commondir_file) ? readfile(commondir_file)[0] : cwd . '/.git'

    " Normalize the path name
    let repo_id = fnamemodify(commondir, ':p')
    call airline#extensions#gitworktree#apply_repo_colors(repo_id)
    call airline#extensions#gitworktree#apply_repo_icons(repo_id)

    " Repo name = directory name of the main repo
    let repo_name = fnamemodify(repo_id, ':t')

    " Extract branch
    let branch = ''
    if filereadable(headfile)
        let head = readfile(headfile)
        if !empty(head) && head[0] =~# '^ref:'
            let branch = substitute(head[0], '^ref: refs/heads/', '', '')
        endif
    endif

    let name = fnamemodify(cwd, ':t')
    if branch ==# ''
        let branch = name
    endif

    let symbols = g:airline#extensions#gitworktree#symbols
    let has_devicons = exists('*WebDevIconsGetFileTypeSymbol')

    " Worktree icon
    if symbols.worktree !=# ''
        let worktree_icon = symbols.worktree
    elseif has_devicons
        let worktree_icon = ''
    else
        let worktree_icon = symbols.fallback_worktree
    endif

    " Worktree name
    let branch_detected = v:false
    if branch !=# ''
        " Use branch name
        let name = branch
        let branch_detected = v:true

        " Branch icon
        if symbols.branch !=# ''
            let branch_icon  = symbols.branch
        elseif has_devicons
            let branch_icon = ''
        else
            let branch_icon = symbols.fallback_branch
        endif
    else
        " Use a shortened path name
        let name = airline#extensions#tabline#formatters#default#shorten_path(cwd)
        " Branch icon
        if symbols.branch_missing !=# ''
            let branch_icon  = symbols.branch_missing
        elseif has_devicons
            let branch_icon = ''
        else
            let branch_icon = symbols.fallback_branch_missing
        endif
    endif

    return {
          \ 'worktree_icon':   worktree_icon,
          \ 'branch_icon':     branch_icon,
          \ 'name':            name,
          \ 'repo_id':         repo_id,
          \ 'repo_name':       repo_name,
          \ 'branch_detected': branch_detected,
          \ }
endfunction

" The next 4 sections define a vim-airline "part" and register that part with
" vim-airline so that it can be used to format various aspects of the tab name
" for git worktrees opened in a vim tab.
function! airline#extensions#gitworktree#part_worktree(tabnr) abort
    let info = airline#extensions#gitworktree#format_info(a:tabnr)
    return info.worktree_icon
endfunction
call airline#parts#define('worktree', 'airline#extensions#gitworktree#part_worktree')

function! airline#extensions#gitworktree#part_repo(tabnr) abort
    let info = airline#extensions#gitworktree#format_info(a:tabnr)
    return info.repo_name
endfunction
call airline#parts#define('gitworktree_repo', 'airline#extensions#gitworktree#part_repo')

function! airline#extensions#gitworktree#part_branch(tabnr) abort
    let info = airline#extensions#gitworktree#format_info(a:tabnr)
    return info.branch_icon
endfunction
call airline#parts#define('worktree', 'airline#extensions#gitworktree#part_branch')

function! airline#extensions#gitworktree#part_name(tabnr) abort
    let info = airline#extensions#gitworktree#format_info(a:tabnr)
    return info.name
endfunction
call airline#parts#define('name', 'airline#extensions#gitworktree#part_name')

function! airline#extensions#gitworktree#formatter(bufnr,  buffers) abort
    let entries = []
    for tab in a:buffers
        let info = airline#extensions#gitworktree#format_info(tab)
        let repo_id = info.repo_id
        let sort_key = airline#extensions#gitworktree#repo_sort_key(repo_id)

        call add(entries, {
        \ 'tab': tab,
        \ 'info': info,
        \ 'sort_key': sort_key,
        \ })
    endfor

    call sort(entries, {a,b -> a.sort_key < b.sort_key ? -1 : 1})

    let header_needed = v:false
    let prev_repo = ''
    let info = {}
    for entry in entries
        if entry.repo_id !=# prev_repo
            if entry.tab == a:bufnr
                let header_needed = v:true
            endif
            let prev_repo = entry.repo_id
        endif

        if entry.tab == a:bufnr
            let info = entry.info
        endif
    endfor

    let active = (a:bufnr == tabpagenr())

    let worktree_icon_hl = active ? 'airline_gitworktree_icon_active'        : 'airline_gitworktree_icon_inactive'
    let repo_hl          = active ? 'airline_gitworktree_repo_active'        : 'airline_gitworktree_repo_inactive'
    let branch_icon_hl   =
               \ info.branch_detected
               \ ? (active ? 'airline_gitworktree_branch_icon_active' : 'airline_gitworktree_branch_icon_inactive')
               \ : (active ? 'airline_gitworktree_branch_missing_icon_active' : 'airline_gitworktree_branch_missing_icon_inactive')
    let branch_hl        = active ? 'airline_gitworktree_branch_active'      : 'airline_gitworktree_branch_inactive'
    let name_hl          = active ? 'airline_gitworktree_name_active'        : 'airline_gitworktree_name_inactive'

    let parts = []

    " Insert repo header only for the first tab of each repo
    if header_needed
        call add(parts, ['gitworktree', worktree_icon_hl])
        call add(parts, ['gitworktree_repo', repo_hl])
    endif

    " Always show branch info
    call add(parts, ['gitworktree_branch_icon'])
    call add(parts, ['gitworktree_branch'])
    call add(parts, ['gitworktree_name', name_hl])

    return parts
endfunction

if exists('g:airline#extensions#tabline#enabled') && g:airline#extensions#tabline#enabled
    call airline#extensions#tabline#add_formatter('gitworktree')
else
    set tabline=%!airline#extensions#gitworktree#format_name(tabpagenr())
endif

function! airline#extensions#gitworktree#init_highlights() abort
    " Worktree icon highlight (active)
    call airline#themes#apply_highlight('airline_gitworktree_icon_active', 'airline_tabtype', '', '')

    " Worktree icon highlight (inactive)
    call airline#themes#apply_highlight('airline_gitworktree_icon_inactive', 'airline_tabtype', '', '')

    " Worktree repo name highlight (active)
    call airline#themes#apply_highlight('airline_gitworktree_repo_active', 'airline_tabtype', '', '')

    " Worktree repo name highlight (inactive)
    call airline#themes#apply_highlight('airline_gitworktree_repo_inactive', 'airline_tabsel', '', '')

    " Branch name highlight (active)
    call airline#themes#apply_highlight('airline_gitworktree_branch_active', 'airline_tab', '', '')

    " Branch name highlight (inactive)
    call airline#themes#apply_highlight('airline_gitworktree_branch_inactive', 'airline_tab', '', '')

    " Branch icon highlight (active)
    call airline#thesemes#apply_highlight('airline_gitworktree_branch_icon_active', 'airline_gitworktree_branch', '', '')

    " Branch icon highlight (active)
    call airline#thesemes#apply_highlight('airline_gitworktree_branch_icon_inactive', 'airline_gitworktree_branch', '', '')

    " Branch missing icon highlight (active)
    call airline#thesemes#apply_highlight('airline_gitworktree_branch_missing_icon_active', 'airline_gitworktree_branch_icon_active', '', '')

    " Branch missing icon highlight (active)
    call airline#thesemes#apply_highlight('airline_gitworktree_branch_missing_icon_inactive', 'airline_gitworktree_branch_icon_inactive', '', '')

    " Worktree name highlight (active)
    call airline#themes#apply_highlight('airline_gitworktree_name_active', 'airline_tabsel', '', '')

    " Worktree icon highlight (inactive)
    call airline#themes#apply_highlight('airline_gitworktree_name_inactive', 'airline_tab', '', '')
endfunction

function! airline#extensions#gitworktree#apply_theme(palette) abort
    " Default: inherit from airline_tab and airline_tabtype
    call airline#themes#apply_highlight('airline_gitworktree_icon', 'airline_tabtype', '', '')
    call airline#themes#apply_highlight('airline_gitworktree_branch', 'airline_tab', '', '')
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon', 'airline_gitworktree_branch', '', '')
endfunction

augroup airline_gitworktree_theme
    autocmd!
    autocmd User AirlineAfterTheme call airline#extensions#gitworktree#apply_theme(g:airline#themes#palette)
augroup END

" Here are a few examples of theme-specific overrides

" Solarized
function! airline#themes#solarized#apply(palette) abort
    " Worktree icon: used solarized yellow
    call airline#themes#apply_highlight('airline_gitworktree_icon', a:palette.tabline.tabtype[0], a:palette.tabline.tabtype[1], '')

    " Branch name (active): use solarized blue
    call airline#themes#apply_highlight('airline_gitworktree_branch', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')

    " Branch name (inactive): use solarized blue
    call airline#themes#apply_highlight('airline_gitworktree_branch', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')

    " Branch icon (active): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon_active', 'airline_gitworktree_branch', '', '')

    " Branch icon (inactive): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon_incative', 'airline_gitworktree_branch', '', '')

    " Branch missing icon (active): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_missing_icon_active', 'airline_gitworktree_branch_icon_active', '', '')

    " Branch missing icon (inactive): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_missing_icon_inactive', 'airline_gitworktree_branch_icon_inactive', '', '')
endfunction

" onedark
function! airline#themes#onedark#apply(palette) abort
    " Worktree icon: used solarized yellow
    call airline#themes#apply_highlight('airline_gitworktree_icon', a:palette.tabline.tabtype[0], a:palette.tabline.tabtype[1], '')

    " Branch name (active): use solarized blue
    call airline#themes#apply_highlight('airline_gitworktree_branch', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')

    " Branch name (inactive): use solarized blue
    call airline#themes#apply_highlight('airline_gitworktree_branch', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')

    " Branch icon (active): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon_active', 'airline_gitworktree_branch', '', '')

    " Branch icon (inactive): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon_incative', 'airline_gitworktree_branch', '', '')

    " Branch missing icon (active): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_missing_icon_active', 'airline_gitworktree_branch_icon_active', '', '')

    " Branch missing icon (inactive): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_missing_icon_inactive', 'airline_gitworktree_branch_icon_inactive', '', '')
endfunction

" ayu
function! airline#themes#ayu#apply(palette) abort
    " Worktree icon: used solarized yellow
    call airline#themes#apply_highlight('airline_gitworktree_icon', a:palette.tabline.tabtype[0], a:palette.tabline.tabtype[1], '')

    " Branch name (active): use solarized blue
    call airline#themes#apply_highlight('airline_gitworktree_branch', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')

    " Branch name (inactive): use solarized blue
    call airline#themes#apply_highlight('airline_gitworktree_branch', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')

    " Branch icon (active): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon_active', 'airline_gitworktree_branch', '', '')

    " Branch icon (inactive): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_icon_incative', 'airline_gitworktree_branch', '', '')

    " Branch missing icon (active): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_missing_icon_active', 'airline_gitworktree_branch_icon_active', '', '')

    " Branch missing icon (inactive): same fg/bg as branch name, by default
    call airline#themes#apply_highlight('airline_gitworktree_branch_missing_icon_inactive', 'airline_gitworktree_branch_icon_inactive', '', '')

    " Worktree name: selected tab colors (same as filename)
    call airline#themes#apply_highlight('airline_gitworktree_name', a:palette.tabline.tabsel[0], a:palette.tabline.tabsel[1], '')
endfunction

" ----------------------------------------------------------------------------
"  Patch airline-branch for git worktrees
" ----------------------------------------------------------------------------
if exists('g:airline#extensions#branch#enabled') && g:airline#extensions#branch#enabled
    " Override airline's branch HEAD resolver
    function! airline#extensions#branch#get_head() abort
        " Resolve .git file or directory
        let gitfile = finddir('.git', getcwd(), ';')
        if gitfile ==# ''
            let gitfile = findfile('.git', getcwd(), ';')
        endif

        " If .git is a file, parse gitdir: pointer
        if filereadable(gitfile)
            let first = readfile(gitfile, '', 1)
            if !empty(first) && first[0] =~# '^.gitdir:'
                let realgit = substitute(first[0], '^.gitdir:\s*', '', '')
                return realgit . '/HEAD'
            endif
        endif

        " Otherwise, treat .git as a directory
        return gitfile . '/HEAD'
    endfunction

    " Override airline's branch extractor
    function! airline#extensions#branch#get_branch() abort
        let headfile = airline#extensions#branch#get_head()

        if !filereadable(headfile)
            return ''
        endif

        let head = readfile(headfile)
        if empty(head)
            return ''
        endif

        " ref: refs/heads/<branch>
        if head[0] =~# '^ref:'
            return substitute(head[0], '^ref: refs/heads/', '', '')
        endif

        " Detached HEAD or worktree-specific HEAD
        return head[0]
    endfunction
endif

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


" *airline-gitworktree*    Git worktree tabline extension for vim-airline
"
" ==============================================================================
" INTRODUCTION                                                    *gitworktree-intro*
"
" The *airline-gitworktree* extension enhances vim-airline's tabline by showing
" Git worktrees as first-class tab entries. Each Vim tab is treated as a Git
" worktree, displaying:
"
"     • Worktree icon
"     • Repository name
"     • Branch icon
"     • Branch name (or worktree name)
"     • Per-repo grouping headers
"     • Per-repo colors, icons, and ordering
"
" This extension is designed for users who work with multiple Git worktrees
" simultaneously and want a clean, informative, and customizable tabline.
"
" Requires:
"     • vim-airline
"     • Git worktrees
"
" ==============================================================================
" FEATURES                                                        *gitworktree-features*
"
" • Automatic detection of Git worktrees
" • Per-repo grouping headers (reduces tabline clutter)
" • Per-repo icon overrides
" • Per-repo color overrides
" • Per-repo ordering rules
" • Repo name trimming (prefix/suffix/both/middle)
" • Branch detection
" • Fallback icons for non-devicons setups
" • Supports powerline symbols when g:airline_powerline_fonts = 1
" • Theme integration with airline palettes
"
" ==============================================================================
" INSTALLATION                                                    *gitworktree-install*
"
" Place the plugin in your runtime path. Example using vim-plug:
"
"     Plug 'vim-airline/vim-airline'
"     Plug 'fourpastmidnight/airline-gitworktree'
"
" Enable airline's tabline:
"
"     let g:airline#extensions#tabline#enabled = 1
"
" The extension registers itself automatically.
"
" ==============================================================================
" BASIC USAGE                                                     *gitworktree-usage*
"
" Each Vim tab is rendered as:
"
"     <worktree-icon> <repo-name> <branch-icon> <branch-name>
"
" Example:
"
"      my-repo  feature/login
"
" When multiple worktrees belong to the same repo, the tabline displays a
" *grouping header* once per repo:
"
"      my-repo    main    feature/login    bugfix
"      another    dev     staging
"
" This reduces clutter and makes repo boundaries clear.
"
" ==============================================================================
" REPO GROUPING HEADERS                                          *gitworktree-headers*
"
" A repo header consists of:
"
"     <worktree-icon> <alt-sep> <repo-name>
"
" It is shown only for the *first* tab belonging to each repo. All other tabs
" for that repo omit the header and show only branch information.
"
" Headers automatically respect:
"
"     • Per-repo icon overrides
"     • Per-repo color overrides
"     • Repo name trimming
"     • Per-repo ordering rules
"
" No additional configuration is required.
"
" ==============================================================================
" REPO NAME TRIMMING                                              *gitworktree-trimming*
"
" The extension supports trimming long repository names so they fit cleanly in
" the tabline. Trimming is controlled by two options:
"
"     *g:airline#extensions#gitworktree#repo_name_maxlen*
"         Maximum allowed repo name length. If the repo name exceeds this
"         value and repo_trim_mode is not 'none', the name will be trimmed so
"         that its final length does not exceed the value of this option.
"
"     *g:airline#extensions#gitworktree#repo_trim_mode*
"         Controls how trimming is performed. Supported modes:
"
"             none      No trimming
"             prefix    …my-repo
"             suffix    my-repo…
"             both      …my-repo…
"             middle    my…repo
"
"           Default: 'none'
"
" Trimming applies to both headers and tab entries.
"
" ==============================================================================
" PER-REPO OVERRIDES                                              *gitworktree-overrides*
"
" You can define per-repo overrides using the full path to the repo’s
" commondir (unique even when repo names collide):
"
" Example:
"
"     let g:airline#extensions#gitworktree#repo_overrides = {
"     \ '/home/craig/src/a/b/c/my-repo/.git': {
"     \     'colors': {
"     \         'active':   ['#ffffff', '#005f87'],
"     \         'inactive': ['#d0d0d0', '#303030'],
"     \     },
"     \     'icons': {
"     \         'worktree_icon': '',
"     \         'branch_icon':   '',
"     \         'branch_missing_icon': '',
"     \         'alt_sep': '│',
"     \     },
"     \     'order': 0,
"     \ },
"     \ '/home/craig/src/d/e/f/my-repo/.git': {
"     \     'colors': {
"     \         'active':   ['#ffffff', '#875f00'],
"     \         'inactive': ['#d0d0d0', '#303030'],
"     \     },
"     \     'icons': {
"     \         'worktree_icon': '',
"     \         'branch_icon':   '',
"     \     },
"     \     'order': 1,
"     \ },
"     \ }
"
" Supported override keys:
"
"     colors.active              [fg, bg]
"     colors.inactive            [fg, bg]
"     icons.worktree_icon        icon for repo header + tabs
"     icons.branch_icon          icon for branch
"     icons.branch_missing_icon  icon when no branch detectoed
"     icons.sep                  separator between worktree icon and repo name
"     icons.alt_sep              separator between icon and repo name
"     order                      numeric sort key for repo grouping
"
" ==============================================================================
" REPO ORDERING                                                   *gitworktree-order*
"
" Repos can be sorted explicitly using the `order` key in repo_overrides.
"
" Example:
"
"     repo A → order 0
"     repo B → order 1
"     repo C → order 2
"
" Tabs reorder automatically in the tabline (airline allows this safely).
"
" ==============================================================================
" SYMBOLS                                                         *gitworktree-symbols*
"
" Default symbols:
"
"     worktree                ''
"     branch                  ''
"     branch_missing          ''
"     sep                     airline left_sep
"     alt_sep                 airline left_alt_sep
"     fallback_worktree       'Git Worktree:'
"     fallback_branch         ''
"     fallback_branch_missing '/'
"
" Override globally:
"
"     let g:airline#extensions#gitworktree#symbols.branch = ''
"
" Override per-repo via repo_overrides.
"
" ==============================================================================
" THEME INTEGRATION                                               *gitworktree-theme*
"
" The extension defines highlight groups:
"
"     airline_gitworktree_icon_active
"     airline_gitworktree_icon_inactive
"     airline_gitworktree_repo_active
"     airline_gitworktree_repo_inactive
"     airline_gitworktree_branch_active
"     airline_gitworktree_branch_inactive
"     airline_gitworktree_branch_icon_active
"     airline_gitworktree_branch_icon_inactive
"     airline_gitworktree_branch_missing_icon_active
"     airline_gitworktree_branch_missing_icon_inactive
"     airline_gitworktree_name_active
"     airline_gitworktree_name_inactive
"
" Themes may override these. Examples included for:
"
"     • solarized
"     • onedark
"     • ayu
"
" ==============================================================================
" BRANCH DETECTION                                                *gitworktree-branch*
"
" The extension patches airline-branch to correctly detect:
"
"     • worktree-specific HEAD files
"     • .git files containing gitdir: pointers
"
" ==============================================================================
" AUTHOR                                                          *gitworktree-author*
"
" Written by Craig E. Shea
" Designed to integrate seamlessly with vim-airline.
"
" ==============================================================================
