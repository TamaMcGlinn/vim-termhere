
" Enable <ESC> to go back to normal mode
tnoremap <ESC> <C-\><C-n>
" Re-enable <ESC>. to repeat last argument
tnoremap <ESC>. <ESC>.

if has('win32')
  augroup TerminalMappings
    autocmd!
      " handle the double-exit required because of nesting Git terminal in cmd
      autocmd TermOpen * nnoremap <buffer> <C-D> aexit<CR>exit<CR>
      autocmd TermOpen * tnoremap <buffer> <C-D> exit<CR>exit<CR>
  augroup END
endif
