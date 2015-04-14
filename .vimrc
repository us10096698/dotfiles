set nocompatible
set noundofile

"------------------Encodings------------------"
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
set fileformat=unix

"------------------General--------------------"
set number
set backspace=indent,eol,start
set expandtab
set tabstop=2
set shiftwidth=2
"set softtabstop=2
set autoindent
set smartindent

set clipboard=unnamed

set ruler
set wrap

"set list "Show Invisible Characters
set listchars=trail:-,tab:>-

set showmatch

" b:backspace, s:space, <:<Left> >:<Right>
set whichwrap=b,s,<,>

set textwidth=0 "Disable Automatic Carrier Return

" -------------------- StatusLine ---------------------------

set laststatus=2 "Always Show

set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

" -------------------- Search -------------------------------"
set ignorecase
set smartcase
set wrapscan
set hlsearch

" -------------------- AutoCommands -------------------------"

autocmd BufNewFile,BufRead *.gradle set filetype=groovy

" -------------------- Complementation ----------------------"

set wildmode=list,full

" -------------------- Backups ------------------------------- "

set noswapfile
set backupdir=$HOME/.vimbackup

if has("syntax")
  syntax on
endif

filetype on

" -------------------- NeoBundle -------------------------- "

if !1 | finish | endif

if has('vim_starting')
  if &compatible
   set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
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

  NeoBundle 'Shougo/unite.vim'

" NeoSnippets
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'us10096698/snippets'

" Ruby
  NeoBundle 'AndrewRadev/switch.vim'
  NeoBundle 'tpope/vim-endwise'

" Markdown
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'kannokanno/previm'
  NeoBundle 'plasticboy/vim-markdown'

" Solarized Color Scheme
  NeoBundle 'altercation/vim-colors-solarized'

" Clipboard use
  NeoBundle 'kana/vim-fakeclip'

call neobundle#end()

filetype plugin indent on     " required!
NeoBundleCheck

" ------------------- Markdown Preview ---------------------

augroup PrevimSettings
  autocmd!
  autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

nnoremap <silent> <C-p> :PrevimOpen<CR>

" -------------------- NeoComplCache ------------------------ "
let g:neocomplcache_enable_at_startup = 1

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" -------------------- NeoSnippet -------------------------- "
let g:neosnippet#snippets_directory = '~/.vim/bundle/snippets/snip'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" -------------------- Environment --------------------------"

" Copy to Clipboard (for Cygwin Vim)
"  noremap :cb :w !cat > /dev/clipboard
vmap ,y "*y
nmap ,p "*p

