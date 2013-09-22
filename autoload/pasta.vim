" pasta.vim - Pasting with indentation adjusted to paste destination"
" Author:     Marcin Kulik <http://ku1ik.com/>
" Version:    0.2

" Public API {{{1

function! pasta#normal_paste(p) "{{{2
  return s:NormalPasta(a:p)
endfunction
"}}}

function! pasta#visual_paste() "{{{2
  return s:VisualPasta()
endfunction
"}}}

function! pasta#setup() "{{{2
  return s:SetupPasta()
endfunction
"}}}

"}}}

" Private {{{1

function! s:NormalPasta(p)
  execute 'normal! ' . v:count1 . '"' . v:register . a:p

  if getregtype() isnot# 'V'
    return
  endif

  normal! '[V']=
endfunction

function! s:VisualPasta()
  " workaround strange Vim behavior (""p is no-op in visual mode)
  let reg = v:register == '"' ? '' : '"' . v:register
  let regtype = getregtype()
  exe "normal! gv" . v:count1 . reg . g:pasta_paste_after_mapping

  if visualmode() isnot# 'V' &&
    \regtype isnot# 'V'
    return
  endif

  normal! '[V']=
endfunction

function! s:SetupPasta()
  if exists("g:pasta_enabled_filetypes")
    if index(g:pasta_enabled_filetypes, &ft) == -1
      return
    endif
  elseif exists("g:pasta_disabled_filetypes") &&
       \ index(g:pasta_disabled_filetypes, &ft) != -1
    return
  endif

  if get(g:, 'pasta_no_default_key_mappings', 0)
    return
  endif

  if !get(g:, 'pasta_no_default_normal_key_mappings', 0)
    exe "nmap <buffer> " . g:pasta_paste_before_mapping . " <Plug>BeforePasta"
    exe "nmap <buffer> " . g:pasta_paste_after_mapping . " <Plug>AfterPasta"
  endif

  if !get(g:, 'pasta_no_default_visual_key_mappings', 0)
    exe "xmap <buffer> " . g:pasta_paste_before_mapping . " <Plug>VisualPasta"
    exe "xmap <buffer> " . g:pasta_paste_after_mapping . " <Plug>VisualPasta"
  endif
endfunction

"}}}

" vim:set sw=2 sts=2:
