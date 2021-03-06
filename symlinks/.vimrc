" common {

    if &compatible
        set nocompatible
    endif

    " setvals {
        set encoding=utf-8
        set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
        set fileformat=unix
        set number
        set backspace=indent,eol,start
        set expandtab
        set smartindent
        set tabstop=2
        set shiftwidth=2
        set softtabstop=2
        set clipboard=unnamed,unnamedplus
        set ruler
        set wrap
        set showmatch
        set textwidth=0
        set hidden
        set nowritebackup
        set wildmode=list,full "completion
        set whichwrap=b,s,<,> " b:backspace, s:space, <:<Left> >:<Right>
        set noundofile
        set noswapfile
        set nobackup
        set colorcolumn=80
        set ignorecase
        set smartcase
        set wrapscan
        set incsearch
        set hlsearch
        set splitbelow
        set splitright

        set cmdheight=2
        set updatetime=300
        set shortmess+=c
        set signcolumn=yes

        let mapleader = "\<Space>"
        let g:omni_sql_no_default_maps = 1
    "  }

    " autocmds {
        autocmd BufWritePre * :%s/\s\+$//ge "remove trailing spaces before saving
        augroup ftype
            autocmd!
            autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
            autocmd BufNewFile,BufRead *.gradle set filetype=groovy
            autocmd BufRead,BufNewFile *.es6 set filetype=javascript
            autocmd BufRead,BufNewFile *.swift set filetype=swift
        augroup END

        " pretty format json: gg=G
        au FileType json setlocal equalprg=python\ -m\ json.tool

        set grepprg=git\ grep\ --no-index\ -I\ --line-number
        autocmd QuickFixCmdPost *grep* cwindow

        augroup reset_au_group
            autocmd!
        augroup END
    " }

    " statusline {
        set laststatus=2
        set statusline=%<%f\ %m%r%h%w
        set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
        set statusline+=%=%l/%L,%c%V%8P
    " }

    " keymap {
        inoremap <C-c> <Esc>
        nmap <silent> <Esc><Esc> :noh<CR>
        noremap <silent> ,s :if exists("g:syntax_on")\|syntax off\|else\|syntax enable\|endif<CR>
        noremap mm %
        " leader magic
        nnoremap <Leader>w :w<CR>
        nnoremap <Leader>q :q<CR>
        nnoremap <Leader>wq :wq<CR>
        " ease window splitting
        nnoremap sj <C-w>j
        nnoremap sk <C-w>k
        nnoremap sl <C-w>l
        nnoremap sh <C-w>h
        nnoremap ss :<C-u>sp<CR><C-w>j
        nnoremap sv :<C-u>vs<CR><C-w>l
    " }

    " syntax {
        if has("syntax")
            syntax on
        endif
    " }
" }

" dein {
    if !has('gui_running')
        let s:dein_dir = expand ('~/.vim/dein')
        let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

        if &runtimepath !~# '/dein.vim'
            if !isdirectory(s:dein_repo_dir)
                execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
            endif
            execute 'set runtimepath^=' . s:dein_repo_dir
        endif

        let s:toml_file = expand('~/.vim/rc/dein.toml')
        if dein#load_state(s:dein_dir)
            call dein#begin(s:dein_dir)
            call dein#load_toml(s:toml_file)
            call dein#end()
            call dein#save_state()
        endif

        filetype plugin indent on

        if dein#check_install()
            call dein#install()
        endif
    endif
" }

