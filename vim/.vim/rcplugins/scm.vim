" Contains plugins for working with SCMs inside of vim.

" Going to try vim-signify and see if that works faster/is better.
"Plug 'airblade/vim-gitgutter'
"if has('win32') || has('unixwin32')
"    let g:gitgutter_git_executable = '/c/Program\ Files/Git/bin/git.exe'
"elseif has('unix')
"    let g:gitgutter_git_executable = '/usr/bin/git'
"endif

Plug 'iberianpig/tig-explorer.vim'

Plug 'mattn/vim-gist'
Plug 'mhinz/vim-signify'
" Configuration for mhinz/vim-signify

" To cut down on signify trying to 'guess' what SCM is in use, only allow git and TFS since those are the
" ones I use 99.9% of the time
let g:signify_skip = { 'vcs': { 'allow': ['git','tfs'] } }
let g:signify_sign_change = '~'

Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'
        Plug 'junegunn/gv.vim'
        Plug 'idanarye/vim-merginal'
        Plug 'christoomey/vim-conflicted'
        Plug 'rhysd/committia.vim'
        Plug 'lambdalisue/gin.vim'
        Plug 'tpope/vim-rhubarb'


" TODO: Remove the individual plugin declarations above and replace with calls to SourceConfigFilesIn
"       The whole point of Chris Toomey's organization is declaring a plugin with its settings. What he
"       doesn't do is handle dependencies between plugins. Short of writing a plugin to handle that, it has
"       to be done manually.
"
"       vim-plug does not seem to have a way to control plugin loading--dependency handling was removed in
"       0.5.0. A simple implementation would be to provide a 'after' or 'before' property.
