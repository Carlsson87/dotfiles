" ==============================
" Daniel Carlsson
" ==============================

" Plugins, install with :PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'mxw/vim-jsx'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'gosukiwi/vim-atom-dark'
call plug#end()

" Theme
colorscheme atom-dark-256
set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete

" Show line numbers
set number

" Use syntax highlighting
syntax on

" Do not add a newline to the end of files
set binary
set noeol

" Indentation
set tabstop=4           " Tab things, see http://vim.wikia.com/wiki/Indenting_source_code
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

" Highlight matching brace 
set showmatch           

" Don't create swapfiles.
set noswapfile          

" Default split directions
set splitright          
set splitbelow          

" Redraw lazily
set lazyredraw

" Assume the /g flag on :s substitutions to replace all matches in a line
set gdefault 

" Searching
set hlsearch            
set incsearch           
set ignorecase
set smartcase

" Delay when leaving insert mode
set ttimeoutlen=50      

" Start scrolling the screen before the cursor reaches the end.
set scrolloff=8

" Allow hiding modified buffers
set hidden

" Use UTF8 encoding
set encoding=utf8

" Allow backspacing over indentation, eol, and start of insert.
set backspace=2

" Automatically read modified files
set autoread

" Hide the status line
set noshowmode

" But always show the status line..
set laststatus=2

" Automatically source the .vimrc file on write
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup end

" Show relative line numbers when in Normal mode, absolute numbers in insert.
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Clear all trailing whitespace and remove empty lines on save.
autocmd BufWritePre *.js %s/\s\+$//e | %s/\n\{3,}/\r\r/e

" Consider JSON files to be javascript, for syntax highlighting.
autocmd BufNewFile,BufRead *.json set ft=javascript





" ========== Keymaps ==========

" === Leader commands
let mapleader = ","
nmap <Leader>t :!clear && yarn run jest %<cr>
nmap <Leader>l :!clear && yarn run eslint %<cr>
nmap <Leader>x :!node %<cr>
nmap <Leader>w :w<cr>
nmap <Leader>q :bd<cr>
nmap <Leader>ev :e ~/.vimrc<cr>
nmap <Leader>b :buffers<cr>
nmap <Leader>1 :NERDTreeToggle<cr>

nmap <c-v> :vsp<cr>

" Navigating splits
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j

" Fuzzy finding
nmap <c-p> :FZF<cr>

" vim-expand-region mappings
vmap v <plug>(expand_region_expand)
vmap <c-v> <plug>(expand_region_shrink)

" Insert linebreak at cursor
nmap K i<cr><esc>

" Move line up/down
nmap <s-Left> ddkP
nmap <s-Right> ddp

" Next/Previous buffer
nmap ä :bn<cr>
nmap ö :bp<cr>

" Resize splits
nmap <s-up> :resize +10 <bar> vertical resize +10<cr>
nmap <s-down> :vertical resize -10<cr>

" Start search
nmap <space> /
" Remove highlights after search
nmap ,<space> :nohlsearch<cr>

" Remap :W to :w
command! W w

" Command to save a file that was opened in readonly mode
command! Sudow :w !sudo tee %<cr>

" Map + to $ (go to end of line)
nmap + $

" Map jj to 
imap jj <esc>





" =========== Configs ==========

" === NERDTree

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeHijackNetrw = 1

" === javascript.vim
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" === Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''

" Remove default sections
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''

let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V-L',
    \ '' : 'V-B',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }



" === FZF

let g:fzf_colors =
\ { 'fg':      ['fg', 'normal'],
  \ 'bg':      ['bg', 'normal'],
  \ 'hl':      ['fg', 'comment'],
  \ 'fg+':     ['fg', 'cursorline', 'cursorcolumn', 'normal'],
  \ 'bg+':     ['bg', 'cursorline', 'cursorcolumn'],
  \ 'hl+':     ['fg', 'statement'],
  \ 'info':    ['fg', 'preproc'],
  \ 'prompt':  ['fg', 'conditional'],
  \ 'pointer': ['fg', 'exception'],
  \ 'marker':  ['fg', 'keyword'],
  \ 'spinner': ['fg', 'label'],
  \ 'header':  ['fg', 'comment'] }
let $fzf_default_command = 'ag --hidden --ignore .git -g ""'