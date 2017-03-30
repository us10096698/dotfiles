set nocompatible

" main {

    " encoding {
        set encoding=utf-8
        set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
        set fileformat=unix
    " }

    " misc {
        set number
        set backspace=indent,eol,start
        set expandtab
        set smartindent
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set clipboard=unnamed
        set ruler
        set wrap
        set showmatch
        set textwidth=0
        set hidden
        set wildmode=list,full "completion
        set whichwrap=b,s,<,> " b:backspace, s:space, <:<Left> >:<Right>
        set noundofile
        set noswapfile
        set nobackup
        set colorcolumn=80
    "  }

    " search {
        set ignorecase
        set smartcase
        set wrapscan
        set incsearch
        set hlsearch

    " }

    " fileType {
        augroup ftype
           autocmd!
           autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
           autocmd BufNewFile,BufRead *.gradle set filetype=groovy
           autocmd BufRead,BufNewFile *.es6 set filetype=javascript
        augroup END
    " }

    " grep {
        set grepprg=git\ grep\ --no-index\ -I\ --line-number
        autocmd QuickFixCmdPost *grep* cwindow
    " }

    " statusLine {
        set laststatus=2
        set statusline=%<%f\ %m%r%h%w
        set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
        set statusline+=%=%l/%L,%c%V%8P
    " }
  
    " cursor { 
        noremap <C-e> <Esc>$
        noremap mm %
        inoremap <C-c> <Esc>
        nmap <silent> <Esc><Esc> :noh<CR>
    " }

    " syntax {
        if has("syntax")
          syntax on
        endif
    " }
" }

" plugins {

    " dein {
        if &compatible
          set nocompatible
        endif

        set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

        call dein#begin(expand('~/.vim/dein'))
  
        call dein#add('Shougo/dein.vim')
        call dein#add('Shougo/vimproc.vim', {
              \ 'build' : {
              \     'windows' : 'tools\\update-dll-mingw',
              \     'cygwin' : 'make -f make_cygwin.mak',
              \     'mac' : 'make -f make_mac.mak',
              \     'linux' : 'make',
              \     'unix' : 'gmake',
              \    },
              \ })
      
        " Snippets {
            call dein#add('Shougo/neocomplcache')
            call dein#add('Shougo/neosnippet')
            call dein#add('Shougo/neosnippet-snippets')
        " }
        
        " markdown {
            call dein#add('tyru/open-browser.vim')
            call dein#add('kannokanno/previm')
            call dein#add('plasticboy/vim-markdown')
        " }
        
        " misc {
            call dein#add('Shougo/unite.vim')
            call dein#add('Shougo/neomru.vim')
            call dein#add('Shougo/vimfiler.vim')
            call dein#add('scrooloose/nerdcommenter')
            call dein#add('mattn/emmet-vim')
            call dein#add('w0ng/vim-hybrid')
            call dein#add('scrooloose/syntastic')
            call dein#add('tpope/vim-fugitive')
            call dein#add('gregsexton/MatchTag')
            call dein#add('terryma/vim-multiple-cursors')
            call dein#add('ConradIrwin/vim-bracketed-paste')
            call dein#add('rking/ag.vim')
            call dein#add('rizzatti/dash.vim')
            call dein#add('junegunn/vim-easy-align')
            call dein#add('othree/yajs.vim')
        " }

        call dein#end()

        filetype plugin indent on

        if dein#check_install()
          call dein#install()
        endif

    " } 

    " unite {
        let g:unite_enable_start_insert = 1
        let g:unite_source_file_mru_limit = 200

        if executable('ag')
          let g:unite_source_grep_command = 'ag'
          let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
          let g:unite_source_grep_recursive_opt = ''
          let g:unite_source_rec_async_command =
            \ ['ag', '--follow', '--nocolor', '--nogroup',
            \  '--hidden', '-g', '']
        endif

        nnoremap [unite] <Nop>
        nmap <Space>u [unite]
        
        nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
        nnoremap <silent> [unite]g :<C-u>Unite -buffer-name=gitfiles file_rec/git<CR>
        nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async<CR>
        nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
        nnoremap <silent> [unite]bm :<C-u>Unite bookmark<CR>
        nnoremap <silent> [unite]ba :<C-u>UniteBookmarkAdd<CR>
        nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
    " }
    
    " vimFiler {
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_safe_mode_by_default = 0
        let g:vimfiler_ignore_pattern = []
        
        nnoremap [filer] <Nop>
        nmap <Space>f [filer]
        
        nnoremap <silent> [filer]i :<C-u>VimFilerBufferDir<CR>
        nnoremap <silent> [filer]e :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -no-quit<CR>
    " }
    
    " emmet {
        let g:user_emmet_expandabbr_key = '<C-g>'
    " }

    " fugitive {
        set diffopt+=vertical
      
        nnoremap [fugitive] <Nop>
        nmap <Space>g [fugitive]
      
        nnoremap <silent> [fugitive]s :<C-u>Gstatus<CR>
        nnoremap <silent> [fugitive]w :<C-u>Gwrite<CR>
        nnoremap <silent> [fugitive]r :<C-u>Gread<CR>
        nnoremap <silent> [fugitive]d :<C-u>Gdiff<CR>
        nnoremap <silent> [fugitive]c :<C-u>Gcommit<CR>
        nnoremap <silent> [fugitive]b :<C-u>Gblame<CR>
    " }
    
    " nerdCommenter {
        let NERDSpaceDelims = 1
        nmap ,, <Plug>NERDCommenterToggle
        vmap ,, <Plug>NERDCommenterToggle
    " }
    
    " easyAlign {
        vmap <CR> <Plug>(EasyAlign)
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    " }
    
    " syntastic {
        let g:syntastic_javascript_checkers=['eslint']
    " }
    
    " markdown {
        let g:vim_markdown_folding_disabled = 1
        nnoremap <silent> <C-p> :PrevimOpen<CR>
    " }
    
    " neoComplCache {
        let g:neocomplcache_enable_at_startup = 1
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " }
    
    " neoSnippet {
        " let g:neosnippet#snippets_directory = '~/.dotfiles/snip'
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        xmap <C-k> <Plug>(neosnippet_expand_target)
        imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"
    " }
    
    " colorscheme {
        set t_Co=256
        syntax enable
        set background=dark
        colorscheme hybrid
    " }
      
    " ag {
        if executable('ag')
          nnoremap [ag] <Nop>
          nmap <Space>a [ag]
          nnoremap <silent> [ag] :<C-u>Ag<CR>
        endif
    " }
    
    " dash {
        if executable('dash')
          nnoremap [dash] <Nop>
          nmap <Space>d [dash]
          nnoremap <silent> [dash] :<C-u>Dash<CR>
        endif
    " }
" }
