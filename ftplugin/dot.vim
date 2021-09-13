" Notice: Not using a global guard, rather a per-buffer guard:
if exists('b:dazi') | finish | endif
let b:dazi = 1

let b:dazipid = 0
let b:tmpfile = tempname()
let b:tmpimg = tempname() . ".png"
echom b:tmpfile
echom b:tmpimg

let b:w32dotpath = "c:\\Program Files (x86)\\GraphViz2.38\\bin\\dot.exe"
function! s:SeeDot()
    if has("unix")
        if b:dazipid != 0
            let l:kl_cmdstr = printf('kill -s 15 %i',b:dazipid)
            let l:kr = system(l:kl_cmdstr)
        endif
        let l:mypath = expand("%:p")
        exe 'w! ' . b:tmpfile
        let l:dot_command = printf('dot -Tpng -o %s %s',b:tmpimg,b:tmpfile)
        call system(l:dot_command)
        let l:viewer_command = printf('feh -x %s >/dev/null 2>&1 & echo $!',b:tmpimg)
        let b:dazipid = system(l:viewer_command)
    elseif has("win32")
        let l:mypath = expand("%:p")
        exe 'w! ' . b:tmpfile
        let l:path = expand('<sfile>:p:h') . "\\daziview.py"
        echo "-->".l:path
        let l:dot_command = printf('"%s" -Tpng -o "%s" "%s"',b:w32dotpath,b:tmpimg,b:tmpfile)
        let l:viewer_command = printf('python3 "%s"  "%s"',l:path,b:tmpimg)
        call system(l:dot_command)
        call system(l:viewer_command)
    endif

endfunction

com -buffer Dazi call s:SeeDot()

let s:mymap = get(g:,'dazimap','')

if s:mymap != ''
    exe printf('nnoremap <buffer> %s :Dazi<CR>',s:mymap)
endif

