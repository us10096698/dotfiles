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
        augroup END
    " }

    " grep {
        set grepprg=git\ grep\ --no-index\ -I\ --line-number
        autocmd QuickFixCmdPost *grep* cwindow
    " }

    " statusLine {
        set laststatus=2 "Always Show
        set statusline=%<%f\ %m%r%h%w
        set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
        set statusline+=%=%l/%L,%c%V%8P
    " }
  
    " cursor { 
        noremap <C-e> <Esc>$
        noremap mm %
    " }

    " syntax {
        if has("syntax")
          syntax on
        endif
    " }
" }

" plugins {
    " NeoBundle {
        if !1 | finish | endif
        
        if has('vim_starting')
          set runtimepath+=~/.vim/bundle/neobundle.vim/
        endif
      
        call neobundle#begin(expand('~/.vim/bundle/'))
        let g:neobundle_default_git_protocol='https' "for Proxy Environment
        
         NeoBundleFetch 'Shougo/neobundle.vim'
         NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }
      
        " Snippets {
            NeoBundle 'Shougo/neocomplcache'
            NeoBundle 'Shougo/neosnippet'
            NeoBundle 'Shougo/neosnippet-snippets'
        " }
        
        " markdown {
            NeoBundle 'tyru/open-browser.vim'
            NeoBundle 'kannokanno/previm'
            NeoBundle 'plasticboy/vim-markdown'
        " }
        
        " misc {
            NeoBundle 'Shougo/unite.vim'
            NeoBundle 'Shougo/neomru.vim' "Necessary for :Unite file_mru
            NeoBundle 'Shougo/vimfiler.vim'
            NeoBundle 'scrooloose/nerdcommenter'
            NeoBundle 'mattn/emmet-vim'
            NeoBundle 'w0ng/vim-hybrid'
            NeoBundle 'scrooloose/syntastic'
            NeoBundle 'tpope/vim-fugitive'
            NeoBundle 'gregsexton/MatchTag'
            NeoBundle 'terryma/vim-multiple-cursors'
            NeoBundle 'ConradIrwin/vim-bracketed-paste'
            NeoBundle 'rking/ag.vim'
            NeoBundle 'rizzatti/dash.vim'
            NeoBundle 'junegunn/vim-easy-align'
        " }
    
        call neobundle#end()
        filetype plugin indent on
        NeoBundleCheck
    " }
    
    " unite {
        " let g:unite_enable_start_insert = 1
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
    
    " VimFiler {
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_safe_mode_by_default = 0
        let g:vimfiler_ignore_pattern = []
        
        nnoremap [filer] <Nop>
        nmap <Space>f [filer]
        
        nnoremap <silent> [filer]i :<C-u>VimFilerBufferDir<CR>
        nnoremap <silent> [filer]e :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -no-quit<CR>
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
