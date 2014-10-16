" Script for svn/git commit reviewing  (2011)
" by Blazej Lewcio blazej.lewcioatgooglemaildotcom
"
" FIX: works in the main project directory only (at least for git)
" TODO: Implement CommitCheckOpen, and CommitCheckClose for cleaning.
" TODO: Check if the currently edited file is affected by the
" commit and if yes, open VCSDiff in the same window.
" TODO: Define action flags in s:flagdict.

if exists("loaded_commit_check") || &cp
  finish
endif
let loaded_commit_check = 1

let s:save_cpo = &cpo
set cpo&vim

let s:flagdict = {'M': 'Modified', 'A': 'Added', 'D': 'Deleted'}
let s:commanddict = {'.svn': 'svn status', '.git': 'git status -uno --porcelain'}

command CommitCheck call CommitCheck()
function! CommitCheck()

  "Create list of dictionaries for quickfix
  let l:qflist = []

  "Store the number of the current tab
  let l:tabnr = tabpagenr()

  " Detect the versions system (git/svn)
  for l:key in keys(s:commanddict)
    if isdirectory(l:key)
      let l:command = s:commanddict[l:key]
    endif
  endfor
  unlet l:key

  " Get the git/svn output
  let l:status = system(l:command)
  " Create list of changes
  let l:list = split(l:status, '\n')
  unlet l:status

  " Parse the change types
  for l:line in l:list
      let [l:flag,l:file] = split(l:line)
      for l:key in keys(s:flagdict)        
          if l:key == l:flag
             let l:dict = {'filename': l:file, 'text': s:flagdict[l:key]}
             call add(l:qflist, l:dict)
             unlet l:dict
             "Open tabs for modified files
             if l:key == 'M'
                exec "tabedit " .l:file
                VCSVimDiff
             endif   
          endif
          unlet l:key
      endfor
      unlet l:flag
      unlet l:file
      unlet l:line
  endfor
  unlet l:list

  "Go back to the initial tab
  exec "tabn " .l:tabnr

  "Set the quickfix list
  call setqflist(l:qflist)
  "Open quickfix list
  if len(l:qflist) > 0
    copen 10
  else
    echo("Nothing to commit.") 
  endif  

  unlet l:qflist
  unlet l:tabnr
endfunction

let &cpo = s:save_cpo
