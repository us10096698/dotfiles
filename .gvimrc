" .gvimrc settings

"initial directory location of file saving dialog
set browsedir=last

" overwrite textwidth configuration
 autocmd FileType text setlocal textwidth=0

" alias setting
ca save browse confirm saveas

" IME switch via ESC key
inoremap <ESC> <ESC>:set iminsert=0<CR>

if has("syntax")
	syntax on
endif

filetype on 

" overwrite textwidth configuration
autocmd FileType text setlocal textwidth=0

"------------------------------------------------
"Remenber Window Position
"------------------------------------------------
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = ['set columns=' . &columns,'set lines=' . &lines,'winpos ' . getwinposx() . ' ' . getwinposy(),]
    call writefile(options, g:save_window_file)
  endfunction augroup END
"---------------------------------------------------
if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif

" -------------------- Solarized ---------------------------- "
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

"-------------------- Transparency Settings ------------

if has('mac')
  autocmd FocusGained * set transparency=20
  autocmd FocusLost * set transparency=40
else
  autocmd FocusGained * set transparency=220
  autocmd FocusLost * set transparency=200
endif

