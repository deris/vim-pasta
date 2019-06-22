" pasta.vim - Pasting with indentation adjusted to paste destination"
" Author:     Marcin Kulik <http://ku1ik.com/>
" Version:    0.2

if exists("g:loaded_pasta") || &cp || v:version < 700
  finish
endif
let g:loaded_pasta = 1

let g:pasta_disabled_filetypes   = get(g:, 'pasta_disabled_filetypes', ["python", "coffee", "markdown",
  \ "yaml", "slim", "nerdtree", "netrw", "startify", "ctrlp"])
let g:pasta_paste_before_mapping = get(g:, 'pasta_paste_before_mapping', 'P')
let g:pasta_paste_after_mapping  = get(g:, 'pasta_paste_after_mapping', 'p')

nnoremap <silent> <Plug>BeforePasta :<C-U>call pasta#normal_paste('P')<CR>
nnoremap <silent> <Plug>AfterPasta :<C-U>call pasta#normal_paste('p')<CR>
xnoremap <silent> <Plug>VisualPasta :<C-U>call pasta#visual_paste()<CR>

augroup vim_pasta
  au FileType * call pasta#setup()
augroup END

" vim:set sw=2 sts=2:
