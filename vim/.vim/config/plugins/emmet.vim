" ====================================================================
" Configure mattn/emmet-vim
" ====================================================================


if exists('g:loaded_emmet_config')
    finish
endif
let g:loaded_emmet_config = 1

let g:user_emmet_settings = {
\   'html': 1,
\   'html5': 1,
\   'css': 1,
\   'javascript': 1,
\   'typescriptreact': 1,
\   'javascriptreact': 1,
\}

" Trigger key (default is <C-y>,)
let g:user_emmet_leader_key='<C-e>'
