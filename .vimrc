" ========== commands and includes and such ==========

" === automatically source the .vimrc file upon save
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup end

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-expand-region'
Plug 'wesgibbs/vim-irblack'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'mxw/vim-jsx'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
call plug#end()

" ========== Keymaps ==========

" ===== Leader commands
let mapleader = ","
map <Leader>q :e ~/notes.md<cr>

nmap <Leader>t :!clear && yarn run jest %<cr>
nmap <Leader>l :!clear && yarn run eslint %<cr>
nmap <Leader>x :!node %<cr>
nmap <Leader>w :w<cr>
nmap <Leader>q :q<cr>
nmap <Leader>ev :e ~/.vimrc<cr>
nmap <Leader>1 :Vexplore<cr>

" === Splits ===

" create splits
nmap <c-v> :vsp<cr>
nmap <c-c> :sp<cr>

" move between splits
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" resize splits
nmap <s-up> :resize +10 <bar> vertical resize +10<cr>
nmap <s-down> :vertical resize -10<cr>

" === search ===

nmap <space> /
nmap ,<space> :nohlsearch<cr>

" === misc ===

command! W w
command! Sudow :w !sudo tee %<cr>
nmap + $
imap jj <esc>
nmap K i<cr><esc>

" =========== Configs ==========

" === Startify
function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction
let g:startify_custom_header = s:filter_header([
    \'',
    \'',
    \'',
    \'  _    _   ______  __     __  __  __    ____',
    \' | |  | | |  ____| \ \   / / |  \/  |  / __ \',
    \' | |__| | | |__     \ \_/ /  | \  / | | |  | |',
    \' |  __  | |  __|     \   /   | |\/| | | |  | |',
    \' | |  | | | |____     | |    | |  | | | |__| |',
    \' |_|  |_| |______|    |_|    |_|  |_|  \____/',
    \'',
    \'',
    \'',
\])

let g:startify_relative_path = 1
let g:startify_enable_special = 0
let g:startify_padding_left = 10
let g:startify_list_order = [
    \['          Most recently used files:'],
    \'dir',
    \['          Quick Commands:'],
    \'commands'
    \]
let g:startify_commands = [
    \{'s': ['Git Status', ':vnew | setlocal buftype=nofile | read !git status']},
    \{'p': ['Git Pull', ':vnew | setlocal buftype=nofile | read !git pull origin']}
    \]


" === NERDTree

let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeHijackNetrw = 0

" === Netrw
let g:netrw_liststyle = 3

" === Vim

colorscheme atom-dark-256
syntax on               " show syntax highlighting
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set number              " show line numbers
set showmatch           " show mathcing brace
set tabstop=8           " tab things, see http://vim.wikia.com/wiki/indenting_source_code
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set noswapfile          " dont create swapfiles for open buffers
set splitright          " create vertical splits to the right
set splitbelow          " create horizontal splits below
set hlsearch            " highlight results while searching
set incsearch           " perform the search incrementally as i'm typing
set ttimeoutlen=50      " less delay when leaving insert mode
set binary		" Do not add a newline to the end of files
set noeol
set scrolloff=8
set encoding=utf8
set backspace=indent,eol,start
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
" Show relative line numbers when in Normal mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
" Clear all trailing whitespace and remove empty lines on save.
autocmd BufWritePre *.js %s/\s\+$//e | %s/\n\{3,}/\r\r/e

" === Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:bufferline_echo = 0
" let g:airline_section_c = 'A'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''

" Hide the defult status line
set noshowmode

" Show airline
set laststatus=2

" === fuzzy finder

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

nmap <c-p> :FZF<cr>
nmap <c-e> :History<cr>

vmap v <plug>(expand_region_expand)
vmap <c-v> <plug>(expand_region_shrink)