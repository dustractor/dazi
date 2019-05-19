" Notice: Not using a global guard, rather a per-buffer guard:
if exists('b:dazi') | finish | endif
let b:dazi = 1

let b:tmpfile = tempname()
let b:tmpimg = tempname() . ".png"

function! s:SeeDot()

    let l:mypath = expand("%:p")
    exe 'w! ' . b:tmpfile
    let l:dotpath = "C:\\Program Files (x86)\\Graphviz2.38\\bin\\dot.exe"
    let l:viewerpath ="C:\\Program Files\\IrfanView\\i_view64.exe" 
    let l:da_cmdstr = printf('"%s" -Tpng -o "%s" "%s"',l:dotpath,b:tmpimg,b:tmpfile)
    echom l:da_cmdstr
    call system(l:da_cmdstr)
    let l:zi_cmdstr = printf('"%s" "%s" /one /closeslideshow',l:viewerpath,b:tmpimg)
    echom l:zi_cmdstr
    call system(l:zi_cmdstr)

endfunction

com -buffer Dazi call s:SeeDot()

let s:mymap = get(g:,'dazimap','')

if s:mymap != ''
    exe printf('nnoremap <silent><buffer>%s :silent! Dazi<CR>',s:mymap)
endif


