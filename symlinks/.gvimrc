" gvim_configuration {

    " misc {
        set browsedir=last
        set guioptions-=T
        set guioptions-=m

        inoremap <ESC> <ESC>:set iminsert=0<CR>
        autocmd FileType text setlocal textwidth=0

        if has("syntax")
          syntax enable
        endif

        if has('gui_macvim')
          set guifont=Menlo:h16
        endif

        filetype on
    " }

    "aliases {
        ca save browse confirm saveas
    " }

    " remember_window_position {
        let g:save_window_file = expand('~/.vimwinpos')
        augroup SaveWindow
          autocmd!
          autocmd VimLeavePre * call s:save_window()
          function! s:save_window()
            let options = ['set columns=' . &columns,'set lines=' . &lines,'winpos ' . getwinposx() . ' ' . getwinposy(),]
            call writefile(options, g:save_window_file)
          endfunction augroup END

        if filereadable(g:save_window_file)
          execute 'source' g:save_window_file
        endif
    " }

    " colorscheme {
        set background=dark
        colorscheme hybrid
    " }

    " transparency {
        if has('mac')
          autocmd FocusGained * set transparency=5
          autocmd FocusLost * set transparency=15
        else
          autocmd FocusGained * set transparency=250
          autocmd FocusLost * set transparency=200
        endif
    " }

" }

