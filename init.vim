" Use different python venv
let g:python3_host_prog = '$XDG_CONFIG_HOME/nvim/.venv/bin/python'

" Remap mode switch
:inoremap jk <esc>
:inoremap ол <esc>
:inoremap <esc> <nop>

" Set leader key
let g:mapleader = ','

" Setup search with ripgrerp

" Add appropriate flags
set grepprg=rg\ --vimgrep\ --hidden\ --follow

" Start grep prompt 
nnoremap <Leader>g :grep<Space>

" Automatically open the quickfix list after running grep
augroup GrepAutoOpen
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

" Navigate the quickfix list
nnoremap <Leader>gn :cnext<CR>
nnoremap <Leader>gp :cprev<CR>
nnoremap <Leader>go :copen<CR>
nnoremap <Leader>gc :cclose<CR>


" Set up the plugin manager (Vim-Plug)
call plug#begin('~/.vim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'frenzyexists/aquarium-vim', { 'branch': 'develop' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stevearc/oil.nvim'
call plug#end()

" Configure tree-sitter
lua << EOF
require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = { enable = true },
    ensure_installed = { 
        "c",
        "cpp",
        "lua",
        "vim",
        "help",
        "python",
        "typescript",
        "javascript",
        "tsx",
        "html",
    },
})
EOF

" Enable syntax highlighting and indenting
syntax on
filetype plugin indent on

" Use a different color scheme
set termguicolors
set background=dark
colorscheme aquarium

let g:aquarium_style='dark'
let g:airline_theme='minimalist'

" Set the tab width to 2 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Use relative line numbers and enable the status line
set relativenumber
set laststatus=2

" Enable searching with case sensitivity
set ignorecase
set smartcase

" Set the clipboard to use the system clipboard
set clipboard=unnamedplus

" Configure Coc
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-yaml',
      \ 'coc-pyright',
      \ 'coc-eslint',
      \ 'coc-clangd',
      \ 'coc-prettier',
      \ ]

" Add key mappings for Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Coc-Pyright configuration
nnoremap <Leader>rl :CocCommand python.runLinting<CR>
nnoremap <Leader>si :CocCommand python.sortImports<CR>
nnoremap <Leader>oi :CocCommand pyright.organizeimports<CR>
nnoremap <Leader>rs :CocCommand pyright.restartserver<CR>

" Set the language server for specific file types
autocmd FileType javascript setl omnifunc=v:lua.coc#refresh()
autocmd FileType typescript setl omnifunc=v:lua.coc#refresh()

" Turn on virtual text (displaying errors inline)
let g:coc_enable_virtual_text = 1

" CoC bindings 
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Save the file automatically when switching buffers or leaving insert mode
autocmd BufLeave,InsertLeave * silent! wall


" Setup oil - for good navigation 
nnoremap <leader>o :Oil<CR>
nnoremap <leader>O :Oil --float<CR>

" Format React and TS files on save
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx silent! CocCommand prettier.formatFile

lua << EOF
require("oil").setup({
    view_options = {
        show_hidden = true
    }
})
EOF

