if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/masa/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/masa/.vim,/usr/local/Cellar/macvim/HEAD-43fb579/MacVim.app/Contents/Resources/vim/vimfiles,/usr/local/Cellar/macvim/HEAD-43fb579/MacVim.app/Contents/Resources/vim/runtime,/usr/local/Cellar/macvim/HEAD-43fb579/MacVim.app/Contents/Resources/vim/vimfiles/after,/Users/masa/.vim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/masa/.vimrc', '/Users/masa/.vim/rc/dein.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/masa/.vim/dein'
let g:dein#_runtime_path = '/Users/masa/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/masa/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/masa/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/masa/.vim,/usr/local/Cellar/macvim/HEAD-43fb579/MacVim.app/Contents/Resources/vim/vimfiles,/Users/masa/.vim/dein/.cache/.vimrc/.dein,/usr/local/Cellar/macvim/HEAD-43fb579/MacVim.app/Contents/Resources/vim/runtime,/Users/masa/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/Cellar/macvim/HEAD-43fb579/MacVim.app/Contents/Resources/vim/vimfiles/after,/Users/masa/.vim/after'
filetype off
  let NERDSpaceDelims = 1
  vmap <CR> <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nnoremap <Leader>o :CtrlP<CR>
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
  let g:ctrlp_prompt_mappings = { 'PrtClearCache()':      ['<c-r>'], 'PrtSelectMove("j")':   ['<c-n>'], 'PrtSelectMove("k")':   ['<c-p>'], 'PrtHistory(-1)':       [], 'PrtHistory(1)':        [], 'AcceptSelection("h")': ['<c-j>'], 'AcceptSelection("v")': ['<c-l>'], 'PrtCurLeft()':         ['<left>'], 'PrtCurRight()':        ['<right>'] }
  let g:user_emmet_expandabbr_key = '<C-y>'
  nnoremap <Leader>/ :CtrlSF<Space>
  nnoremap <Leader>f :NERDTreeToggle<CR>
  set diffopt+=vertical
  nnoremap [fugitive] <Nop>
  nmap <Space>g [fugitive]
  nnoremap <silent> [fugitive]s :<C-u>Gstatus<CR>
  nnoremap <silent> [fugitive]w :<C-u>Gwrite<CR>
  nnoremap <silent> [fugitive]r :<C-u>Gread<CR>
  nnoremap <silent> [fugitive]d :<C-u>Gdiff<CR>
  nnoremap <silent> [fugitive]c :<C-u>Gcommit<CR>
  nnoremap <silent> [fugitive]b :<C-u>Gblame<CR>
  set t_Co=256
  syntax enable
  set background=dark
  au reset_au_group VimEnter * nested colorscheme hybrid
  let g:neosnippet#snippets_directory = '~/.snip'
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"
  let g:vim_markdown_folding_disabled = 1
  let g:previm_show_header = 0
  nnoremap <silent> <C-s> :PrevimOpen<CR>
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
