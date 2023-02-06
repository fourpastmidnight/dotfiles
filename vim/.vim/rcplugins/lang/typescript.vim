" Configure HerringtonDarkholme/yats.vim
"let g:typescript_conceal_function             = "ƒ"
"let g:typescript_conceal_null                 = "ø"
"let g:typescript_conceal_undefined            = "¿"
"let g:typescript_conceal_this                 = "@"
"let g:typescript_conceal_return               = "⇚"
"let g:typescript_conceal_prototype            = "¶"
"let g:typescript_conceal_super                = "Ω"

nnoremap <buffer> <localleader>c :exec &conceallevel ? 'set conceallevel=0' : 'set conceallevel=1'<CR>
