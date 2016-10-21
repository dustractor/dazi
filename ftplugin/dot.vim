" Notice: Not using a global guard, rather a per-buffer guard:
if exists('b:dazi') | finish | endif
let b:dazi = 1

" Save the current file to a temp dir
" turn that into a temp image
" and look at that with feh
" xxx-todo: make the tmpimg stick
function! s:SeeDot()
    let l:mypath = expand("%:p")
    let l:tmpfile = tempname()
    let l:tmpimg = tempname()
    exe 'w! ' . l:tmpfile
    let l:da_cmdstr = 'dot -Tpng -o ' . l:tmpimg . ' ' . l:tmpfile
    let l:zi_cmdstr = 'feh ' . l:tmpimg . ' &'
    call system(l:da_cmdstr)
    call system(l:zi_cmdstr)
endfunction

" Make a command ( local to the buffer )
" to call the function
com -buffer Dazi call s:SeeDot()

" Likewise a mapping, but silenced

if !exists("g:dazimap")
    let g:dazimap="<F12>"
endif
exe "nnoremap <buffer> " . g:dazimap " :silent! Dazi<cr>"

" deal with focus-stealing prevention in your openbox rc file:
" ----------------------------[example]-----------------------
" <focusNew>yes</focusNew>
" ------------------------------------------------------------

" That is all
