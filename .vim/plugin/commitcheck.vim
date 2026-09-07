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
      " Status line is "<flag> <path>"; match instead of split() since
      " renamed-file lines ("R  old -> new") and paths with spaces would
      " otherwise produce more than 2 whitespace-separated tokens
      let l:matches = matchlist(l:line, '^\s*\(\S\+\)\s\+\(.*\)$')
      if empty(l:matches)
        continue
      endif
      let l:flag = l:matches[1]
      let l:file = l:matches[2]
      " Renames are reported as "old -> new"; keep just the new path
      if l:file =~ ' -> '
        let l:file = matchstr(l:file, ' -> \zs.*$')
      endif
      for l:key in keys(s:flagdict)
          if l:key == l:flag
             let l:dict = {'filename': l:file, 'text': s:flagdict[l:key]}
             call add(l:qflist, l:dict)
             unlet l:dict
             "Open tabs for modified files
             if l:key == 'M'
                exec "tabedit " .l:file
                " Show a diff via fugitive if it's a git checkout and available
                if isdirectory('.git') && exists(':Gdiffsplit')
                  Gdiffsplit
                endif
             endif
          endif
          unlet l:key
      endfor
      unlet l:matches
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
