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
Plug 'gosukiwi/vim-atom-dark'
call plug#end()

" Theme
colorscheme atom-dark-256
set guifont=Sauce\ Code\ Pro\ Medium\ Nerd\ Font\ Complete

" Show line numbers
set number

" Show a colored column
set colorcolumn=80

" Use syntax highlighting
syntax on

" tab things, see http://vim.wikia.com/wiki/indenting_source_code
set tabstop=8           
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

" Do not add a newline to the end of files
set binary		
set noeol

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
nmap <Leader>q :q<cr>
nmap <Leader>ev :e ~/.vimrc<cr>
nmap <Leader>b :buffers<cr>
nmap <Leader>v :vsp<cr>
nmap <Leader>1 :NERDTreeToggle<cr>

" Navigating splits
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j

" Fuzzy finding
nmap <c-p> :FZF<cr>
nmap <c-e> :History<cr>

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

" === Startify
function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let centered_lines = map(copy(a:lines), 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction
let g:startify_custom_header = s:filter_header([
    \'',
    \'MMMMMMMM               MMMMMMMM               AAA               KKKKKKKKK    KKKKKKKEEEEEEEEEEEEEEEEEEEEEE',
    \'M:::::::M             M:::::::M              A:::A              K:::::::K    K:::::KE::::::::::::::::::::E',
    \'M::::::::M           M::::::::M             A:::::A             K:::::::K    K:::::KE::::::::::::::::::::E',
    \'M:::::::::M         M:::::::::M            A:::::::A            K:::::::K   K::::::KEE::::::EEEEEEEEE::::E',
    \'M::::::::::M       M::::::::::M           A:::::::::A           KK::::::K  K:::::KKK  E:::::E       EEEEEE',
    \'M:::::::::::M     M:::::::::::M          A:::::A:::::A            K:::::K K:::::K     E:::::E',
    \'M:::::::M::::M   M::::M:::::::M         A:::::A A:::::A           K::::::K:::::K      E::::::EEEEEEEEEE',
    \'M::::::M M::::M M::::M M::::::M        A:::::A   A:::::A          K:::::::::::K       E:::::::::::::::E',
    \'M::::::M  M::::M::::M  M::::::M       A:::::A     A:::::A         K:::::::::::K       E:::::::::::::::E',
    \'M::::::M   M:::::::M   M::::::M      A:::::AAAAAAAAA:::::A        K::::::K:::::K      E::::::EEEEEEEEEE',
    \'M::::::M    M:::::M    M::::::M     A:::::::::::::::::::::A       K:::::K K:::::K     E:::::E',
    \'M::::::M     MMMMM     M::::::M    A:::::AAAAAAAAAAAAA:::::A    KK::::::K  K:::::KKK  E:::::E       EEEEEE',
    \'M::::::M               M::::::M   A:::::A             A:::::A   K:::::::K   K::::::KEE::::::EEEEEEEE:::::E',
    \'M::::::M               M::::::M  A:::::A               A:::::A  K:::::::K    K:::::KE::::::::::::::::::::E',
    \'M::::::M               M::::::M A:::::A                 A:::::A K:::::::K    K:::::KE::::::::::::::::::::E',
    \'MMMMMMMM               MMMMMMMMAAAAAAA                   AAAAAAAKKKKKKKKK    KKKKKKKEEEEEEEEEEEEEEEEEEEEEE',
    \'',
    \'',
    \'   SSSSSSSSSSSSSSS TTTTTTTTTTTTTTTTTTTTTTTUUUUUUUU     UUUUUUUUFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF',
    \' SS:::::::::::::::ST:::::::::::::::::::::TU::::::U     U::::::UF::::::::::::::::::::FF::::::::::::::::::::F',
    \'S:::::SSSSSS::::::ST:::::::::::::::::::::TU::::::U     U::::::UF::::::::::::::::::::FF::::::::::::::::::::F',
    \'S:::::S     SSSSSSST:::::TT:::::::TT:::::TUU:::::U     U:::::UUFF::::::FFFFFFFFF::::FFF::::::FFFFFFFFF::::F',
    \'S:::::S            TTTTTT  T:::::T  TTTTTT U:::::U     U:::::U   F:::::F       FFFFFF  F:::::F       FFFFFF',
    \'S:::::S                    T:::::T         U:::::D     D:::::U   F:::::F               F:::::F',
    \' S::::SSSS                 T:::::T         U:::::D     D:::::U   F::::::FFFFFFFFFF     F::::::FFFFFFFFFF',
    \'  SS::::::SSSSS            T:::::T         U:::::D     D:::::U   F:::::::::::::::F     F:::::::::::::::F',
    \'    SSS::::::::SS          T:::::T         U:::::D     D:::::U   F:::::::::::::::F     F:::::::::::::::F',
    \'       SSSSSS::::S         T:::::T         U:::::D     D:::::U   F::::::FFFFFFFFFF     F::::::FFFFFFFFFF',
    \'            S:::::S        T:::::T         U:::::D     D:::::U   F:::::F               F:::::F',
    \'            S:::::S        T:::::T         U::::::U   U::::::U   F:::::F               F:::::F',
    \'SSSSSSS     S:::::S      TT:::::::TT       U:::::::UUU:::::::U FF:::::::FF           FF:::::::FF',
    \'S::::::SSSSSS:::::S      T:::::::::T        UU:::::::::::::UU  F::::::::FF           F::::::::FF',
    \'S:::::::::::::::SS       T:::::::::T          UU:::::::::UU    F::::::::FF           F::::::::FF',
    \' SSSSSSSSSSSSSSS         TTTTTTTTTTT            UUUUUUUUU      FFFFFFFFFFF           FFFFFFFFFFF',
    \'',
    \])
let g:startify_enable_special = 0
let g:startify_list_order = [
    \'commands'
    \]
let g:startify_commands = [
    \['Heymo Frontend', ':cd ~/code/heymo-front-end | so .vimrc | Startify'],
    \['Heymo API', ':cd ~/code/heymo-api | so .vimrc | Startify'],
    \['Mygains API', ':cd ~/code/mygains-api | e package.json'],
    \['Todo', ':cd ~ | e __notes.md'],
    \['.vimrc', ':cd ~ | e .vimrc'],
    \['.zshrc', ':cd ~ | e .zshrc'],
    \]


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
let g:bufferline_echo = 0
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

" Tabline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#tabline#buffer_min_count = 2
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