set nocompatible
syntax on
filetype indent plugin on

if !filewritable($HOME."/.vim/backup")    " if backup directory doesn't exists yet                                                 
    call mkdir($HOME."/.vim/backup", "p") " create it
endif
set backup                      " backups are nice ...
set backupdir=~/.vim/backup/
if has('persistent_undo')
    set undofile                " so is persistent undo ...
    set undodir=~/.vim/backup/
    set undolevels=1000         " maximum number of changes that can be undone
    set undoreload=10000        " maximum number lines to save for undo on a buffer reload   
endif

set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.          
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
set wrap                        " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
set ttyfast                     " force redraw of the terminal emulator instead of scrolling

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Save as root
cab wr w !sudo tee %	

" Map Ctrl-Arrow
map Oa <C-Up>
map Ob <C-Down>

" Splitted window key binding
nnoremap <C-Up> <C-W>k<C-W>_zz
nnoremap <C-Down> <C-W>j<C-W>_zz

" Gvim options
highlight Normal guifg=gray guibg=#202020
set guioptions=rm
"set cursorline

" Load Tomorrow-Night colorscheme if exists, and check if 256colors term
if &t_Co > 2
    if filereadable(expand("$VIMRUNTIME/colors/Tomorrow-Night.vim"))
        colorscheme Tomorrow-Night
    elseif filereadable(expand("$HOME/.vim/colors/Tomorrow-Night.vim"))
        colorscheme Tomorrow-Night
    else
        colorscheme default
    endif
endif
