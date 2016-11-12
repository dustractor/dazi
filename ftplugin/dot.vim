" Notice: Not using a global guard, rather a per-buffer guard:
if exists('b:dazi') | finish | endif
let b:dazi = 1

let b:dazipid = 0
let b:tmpfile = tempname()
let b:tmpimg = tempname()

function! s:SeeDot()
    if b:dazipid != 0
        let l:kl_cmdstr = printf('kill -s 15 %i',b:dazipid)
        let l:kr = system(l:kl_cmdstr)
    endif

    let l:mypath = expand("%:p")
    exe 'w! ' . b:tmpfile
    let l:da_cmdstr = printf('dot -Tpng -o %s %s',b:tmpimg,b:tmpfile)
    call system(l:da_cmdstr)
    let l:zi_cmdstr = printf('feh %s >/dev/null 2>&1 & echo $!',b:tmpimg)
    let b:dazipid = system(l:zi_cmdstr)
    echo b:dazipid

endfunction

com -buffer Dazi call s:SeeDot()

let s:mymap = get(g:,'dazimap','')

if s:mymap != ''
    exe printf('nnoremap <buffer> %s :silent! Dazi<CR>',s:mymap)
endif


