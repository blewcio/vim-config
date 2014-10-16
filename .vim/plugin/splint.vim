if exists("splint_check") || &cp
  finish
endif
let splint_check = 1

let s:save_cpo = &cpo
set cpo&vim

command SplintCheck call SplintCheck()
function! SplintCheck ()

 	let	l:filename = bufname("%")
	let l:makeprg_tmp = &makeprg
 
	if &filetype != "c"
    echo("Error: Not a C file.")
		return
	endif

	silent update
	cclose

	setlocal makeprg=splint
  silent exec "make ".l:filename

  echo(l:makeprg_tmp)
	setlocal makeprg="l:makeprg_tmp"
  copen

endfunction

let &cpo = s:save_cpo

