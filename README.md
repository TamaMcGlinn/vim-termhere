# Open Terminal Here

Termhere makes it easier to open a terminal, because it switches straight to insert mode,
enables the intuitive `<ESC>` to get back out, and adds functionality for swapping out
the terminal's directory and the vim working dir.

If you are on windows, it also loads 'doskey.cmd' (which you have to write), 
and starts up Git bash unless you use the 'DOS' functions.

Works well in conjunction with [dirhere](https://github.com/TamaMcGlinn/vim-dirhere).

## Install

Use your favourite plugin manager.

```
Plug 'TamaMcGlinn/vim-termhere'
```

Example config:

```
" cc for commandline, cs for split terminal below,
" windows only: cd for dos terminal, csd for split dos terminal below
if has('win32')
  " Note, you need to empty the file Git\etc\motd
  " to get rid of the 'Welcome to Git' message
  set shell=cmd.exe
  nnoremap <Leader>cc :call termhere#OpenTerminal()<CR>
  nnoremap <Leader>cd :call termhere#OpenDOSTerminal()<CR>
  nnoremap <Leader>csd :call termhere#OpenSplitDOSTerminal()<CR>
else
  nnoremap <Leader>cc :call termhere#OpenTerminal()<CR>
  nnoremap <Leader>cs :call termhere#OpenSplitTerminal()<CR>
endif

nnoremap <Leader>cf :call termhere#UseRelativeFilenameInTermBelow('')<CR>
nnoremap <Leader>cF :call termhere#UseAbsoluteFilenameInTermBelow('')<CR>

" if you use [which-key](https://github.com/liuchengxu/vim-which-key)
let g:which_key_map['c'] = {'name': '+Terminal',
             \'c': 'Full window',
             \'s': 'Split below',
             \'f': 'relative filename',
             \'F': 'absolute filename',
             \'d': 'DOS CMD',
             \}
```
