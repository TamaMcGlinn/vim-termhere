function! termhere#OpenTerminal(open_dos_terminal=v:false) abort
  execute ':term'
  execute ':set filetype=terminal'
  call feedkeys('A')
  if has('win32')
    let l:enter = "\<CR>"
    let l:command = 'doskey.cmd' . l:enter
    if a:open_dos_terminal
      let l:bash_start_command='cmd.exe /c "C:\\Progra~1\Git\bin\bash.exe --login -i"'
      let l:command .= l:bash_start_command . l:enter
    endif
    let l:command .= 'cls' . l:enter
    echom l:command
    call feedkeys(l:command)
  endif
endfunction

function! termhere#OpenSplitTerminal(open_dos_terminal=v:false) abort
  execute ':split'
  execute ':wincmd j'
  call termhere#OpenTerminal()
endfunction

function! termhere#OpenDOSTerminal() abort
  call termhere#OpenTerminal(v:true)
endfunction

function! termhere#OpenSplitDOSTerminal() abort
  call termhere#OpenSplitTerminal(v:true)
endfunction

function! termhere#JumpToTerminalBuffer() abort
  if &buftype ==# 'terminal'
    return
  endif
  let l:first_window_number = winnr()
  while v:true
    execute "wincmd W"
    if &buftype ==# 'terminal'
      return
    endif
    if winnr() == l:first_window_number
      break
    endif
  endwhile
  throw "Unable to find terminal window in current tab"
endfunction

function! termhere#JumpToNormalBuffer() abort
  " nofile_winnr allows us to prefer buffers whose type is not nofile,
  " (i.e. regular files) but still return them without error if it's the
  " only nonterminal buffer around
  let l:nofile_winnr = v:null
  if &buftype !=# 'nofile' && &buftype !=# 'terminal'
    return
  endif
  if &buftype ==# 'nofile'
    let l:nofile_winnr = winnr()
  endif
  let l:first_window_number = winnr()
  while v:true
    execute "wincmd W"
    if &buftype !=# 'nofile' && &buftype !=# 'terminal'
      return
    endif
    if &buftype ==# 'nofile'
      let l:nofile_winnr = winnr()
    endif
    if winnr() == l:first_window_number
      break
    endif
  endwhile
  if l:nofile_winnr is v:null
    throw "Unable to find non-terminal window in current tab to copy filename from"
  endif
  execute l:nofile_winnr .. "wincmd w"
endfunction

function! termhere#UseAbsoluteFilenameInTermBelow(prefix, ...) abort
  if &buftype ==# 'terminal'
    call termhere#JumpToNormalBuffer()
  endif
  let l:postfix = get(a:, 1, '')
  let l:filename = expand('%:p')
  call termhere#JumpToTerminalBuffer()
  call feedkeys('a' . a:prefix . l:filename . l:postfix)
endfunction

function! termhere#UseRelativeFilenameInTermBelow(prefix, ...) abort
  if &buftype ==# 'terminal'
    call termhere#JumpToNormalBuffer()
  endif
  let l:postfix = get(a:, 1, '')
  let l:filename = bufname('%')
  call termhere#JumpToTerminalBuffer()
  call feedkeys('a' . a:prefix . l:filename . l:postfix)
endfunction

