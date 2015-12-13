set nocompatible

"---------------------- Basic Settings -------------------------
  " Encoding
    set encoding=utf-8
    set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
    set fileformat=unix
  
  " General
    set number
    set backspace=indent,eol,start
    set expandtab
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set autoindent
    set smartindent
    set clipboard=unnamed
    set ruler
    set wrap
    set showmatch
    set textwidth=0 "Disable Automatic Carrier Return
    set hidden
    set wildmode=list,full "completion
    set whichwrap=b,s,<,> " b:backspace, s:space, <:<Left> >:<Right>
    "set list "Show Invisible Characters
    "set listchars=trail:-,tab:>-
  
  " Search
    set ignorecase
    set smartcase
    set wrapscan
    set hlsearch
    set incsearch

  " Grep (Git Grep) + QuickFix
    set grepprg=git\ grep\ --no-index\ -I\ --line-number
    autocmd QuickFixCmdPost *grep* cwindow

  " Filetype
    augroup ftype
      autocmd!
      autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
      autocmd BufNewFile,BufRead *.gradle set filetype=groovy
    augroup END

  " StatusLine
    set laststatus=2 "Always Show
    set statusline=%<%f\ %m%r%h%w
    set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
    set statusline+=%=%l/%L,%c%V%8P
  
  " Backup
    set noundofile
    set noswapfile
    "set backupdir=$HOME/.vimbackup
    
  " Cursor move
    inoremap <C-e> <Esc>$
    inoremap <C-a> <Esc>^
    noremap <C-e> <Esc>$
    noremap <C-a> <Esc>^
  
" ---------------------------------------

  if has("syntax")
    syntax on
  endif

" ---------------------- NeoBundle -----------------------------
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
  
  " Snippets
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
  
  " Markdown
    NeoBundle 'tyru/open-browser.vim'
    NeoBundle 'kannokanno/previm'
    NeoBundle 'plasticboy/vim-markdown'
  
  " Misc
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neomru.vim' "Necessary for :Unite file_mru
    NeoBundle 'Shougo/vimfiler.vim'
    NeoBundle 'scrooloose/nerdcommenter'
    NeoBundle 'mattn/emmet-vim'
    NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'tpope/vim-fugitive'

  call neobundle#end()
  
  filetype plugin indent on
  NeoBundleCheck

" ---------------------- Unite ------------------------------
  " let g:unite_enable_start_insert = 1
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_file_mru_filename_format = ''
  let g:unite_source_file_mru_limit = 200
  
  nnoremap [unite] <Nop>
  nmap <Space>u [unite]
  
  nnoremap <silent> [unite]f :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
  nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

" -------------------- VimFiler -----------------------------
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  
  nnoremap [filer] <Nop>
  nmap <Space>f [filer]
  
  nnoremap <silent> [filer]i :<C-u>VimFilerBufferDir -split -simple -winwidth=25 -no-quit<CR>
  nnoremap <silent> [filer]e :<C-u>VimFilerBufferDir -quit<CR>

" -------------------- fugitive ----------------------------
  set diffopt+=vertical

  nnoremap [fugitive] <Nop>
  nmap <Space>g [fugitive]

  nnoremap <silent> [fugitive]s :<C-u>Gstatus<CR>
  nnoremap <silent> [fugitive]w :<C-u>Gwrite<CR>
  nnoremap <silent> [fugitive]r :<C-u>Gread<CR>
  nnoremap <silent> [fugitive]d :<C-u>Gdiff<CR>
  nnoremap <silent> [fugitive]c :<C-u>Gcommit<CR>

" -------------------- NerdCommenter ------------------------
  let NERDSpaceDelims = 1
  nmap ,, <Plug>NERDCommenterToggle
  vmap ,, <Plug>NERDCommenterToggle

" -------------------- Syntastic -------------------
" To work this, you need to install `eslint` globally

  let g:syntastic_javascript_checkers=['eslint']

" -------------------- Markdown ---------------------
  let g:vim_markdown_folding_disabled = 1
  nnoremap <silent> <C-p> :PrevimOpen<CR>

" -------------------- NeoComplCache ------------------------
  let g:neocomplcache_enable_at_startup = 1

  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" -------------------- NeoSnippet --------------------------
  " let g:neosnippet#snippets_directory = '~/.dotfiles/snip'
  
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"

" -------------------- Environment --------------------------
  set background=dark
  colorscheme hybrid
  
