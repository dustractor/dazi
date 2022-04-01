" Notice: Not using a global guard, rather a per-buffer guard:
if exists('b:dazi') | finish | endif

let b:dazi = 1

let b:dazipid = 0

let b:tmpfile = tempname()
let b:tmpimg = tempname() . ".png"


if has("win32")
    let s:dotpath = get(g:,"dazi_dotpath",
                \ "c:\\Program Files (x86)\\GraphViz2.38\\bin\\dot.exe")
else
    let s:dotpath = get(g:,"dazi_dotpath","dot")
endif


function! s:SeeDot()

    exe 'w! ' . b:tmpfile

    let l:dot_command = printf('"%s" -Tpng -o "%s" "%s"',
                \ s:dotpath,b:tmpimg,b:tmpfile)
    call system(l:dot_command)

    if has('win32')
        let l:image_viewer_path = expand('<sfile>:p:h') . "\\daziview.py"
        let l:viewer_command = printf('python3 "%s"  "%s"',
                    \ l:image_viewer_path,b:tmpimg)
    else
        let l:viewer_command = printf('feh  "%s"', b:tmpimg)
    endif
    call system(l:viewer_command)

endfunction

com -buffer Dazi call s:SeeDot()


let s:mymap = get(g:,'dazimap','')
if s:mymap != ''
    exe printf('nnoremap <buffer> %s :silent! Dazi<CR>',s:mymap)
endif

